//
//  QWNetworkController.m
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import "MMNetworkController.h"
#import "MMNetworkDelgt.h"

@interface MMNetworkController ()

@property (nonatomic, strong)  NSMutableArray *arrayConnection;	// 连接堆栈
@property (nonatomic, strong)  NSMutableArray *arrayDelegate;	// 代理堆栈

@end

// =====================================================================================
// 全局数据控制器
// =====================================================================================
static MMNetworkController *globalNetworkController = nil;

@implementation MMNetworkController

// 实例化
+ (MMNetworkController *)getInstance
{
    @synchronized(self)
    {
        if(globalNetworkController == nil)
        {
            globalNetworkController = [[super allocWithZone:NULL] init];
            
            // 初始化
            [globalNetworkController setArrayConnection:nil];
            [globalNetworkController setArrayDelegate:nil];
        }
    }
    
    return globalNetworkController;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self getInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

//添加connection
- (void)addConnection:(NSURLSessionTask *)connection andDelegate:(id)delegate
{
    @synchronized(self)
    {
        if(_arrayConnection == nil)
        {
            _arrayConnection = [[NSMutableArray alloc] init];
        }
        
        if (_arrayDelegate == nil)
        {
            _arrayDelegate = [[NSMutableArray alloc] init];
        }
        
        if (connection != nil)
        {
            [_arrayConnection addObject:connection];
            
            if (delegate == nil)
            {
                [_arrayDelegate addObject:[[NSNull alloc] init]];
            }
            else
            {
                [_arrayDelegate addObject:delegate];
            }
        }
    }
}

// 删除connection
- (void)removeConnection:(NSURLSessionTask *)connection
{
    @synchronized(self)
    {
        if((_arrayConnection != nil) && (_arrayDelegate != nil))
        {
            NSMutableArray *arrayConnectRemove = [[NSMutableArray alloc] init];
            NSMutableArray *arrayDelegateRemove = [[NSMutableArray alloc] init];
            
            NSInteger count = [_arrayConnection count];
            for(NSInteger i = 0; i < count; i++)
            {
                NSURLSessionTask *urlConnection = [_arrayConnection objectAtIndex:i];
                if(connection == urlConnection)
                {
                    [urlConnection cancel];
                    
                    id delegate = [_arrayDelegate objectAtIndex:i];
                    [[MMNetworkController getInstance] cancelNetCallBackWithDelegate:delegate];
                    
                    [arrayConnectRemove addObject:urlConnection];
                    [arrayDelegateRemove addObject:delegate];
                }
            }
            
            [_arrayDelegate removeObjectsInArray:arrayDelegateRemove];
            [_arrayConnection removeObjectsInArray:arrayConnectRemove];
            
            [arrayDelegateRemove removeAllObjects];
            [arrayConnectRemove removeAllObjects];
        }
    }
}

// 取消代理回调
- (void)cancelNetCallBackWithDelegate:(id)delegate
{
    if((delegate != nil) && ([delegate isKindOfClass:[MMNetworkDelgt class]]))
    {
        [delegate setDelegate:nil];
    }
}

// 通过网络代理回调的对象来删除connection
- (void)removeConnectionsByRequest:(id)requestObject
{
    @synchronized(self)
    {
        if((_arrayConnection != nil) && (_arrayDelegate != nil))
        {
            NSMutableArray *arrayConnectRemove = [[NSMutableArray alloc] init];
            NSMutableArray *arrayDelegateRemove = [[NSMutableArray alloc] init];
            
            NSInteger count = [_arrayConnection count];
            for(NSInteger i = 0; i < count; i++)
            {
                id delegate = [_arrayDelegate objectAtIndex:i];
                if ([delegate isKindOfClass:[MMNetworkDelgt class]])
                {
                    MMNetworkDelgt *networkDelgt = (MMNetworkDelgt *)delegate;
                    if ([networkDelgt isSame:requestObject] == YES)
                    {
                        [self cancelNetCallBackWithDelegate:delegate];
                        
                        NSURLSessionTask *urlConnection = [_arrayConnection objectAtIndex:i];
                        [urlConnection cancel];
                        
                        [arrayConnectRemove addObject:urlConnection];
                        [arrayDelegateRemove addObject:delegate];
                    }
                    
                }
            }
            
            [_arrayDelegate removeObjectsInArray:arrayDelegateRemove];
            [_arrayConnection removeObjectsInArray:arrayConnectRemove];
            
            [arrayDelegateRemove removeAllObjects];
            [arrayConnectRemove removeAllObjects];
        }
    }
}

// 销毁
- (void)destroy
{
    _arrayConnection = nil;
    _arrayDelegate = nil;
}

@end
