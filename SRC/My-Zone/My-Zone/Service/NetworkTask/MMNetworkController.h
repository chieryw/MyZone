//
//  QWNetworkController.h
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMNetworkController : NSObject

// 实例化
+ (MMNetworkController *)getInstance;

//添加connection
- (void)addConnection:(NSURLSessionTask *)connection andDelegate:(id)delegate;

// 删除connection
- (void)removeConnection:(NSURLSessionTask *)connection;

// 通过网络代理回调的对象来删除connection
- (void)removeConnectionsByRequest:(id)requestObject;

// 销毁
- (void)destroy;

@end
