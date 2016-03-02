//
//  MMHomeVM.m
//  My-Zone
//
//  Created by chiery on 16/2/29.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMHomeVM.h"
#import "MMHomeResult.h"

@interface MMHomeVM ()<MMNetworkPtc>

@end

@implementation MMHomeVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {
    self.hasMore = NO;
}

#pragma mark - 事件处理函数
- (void)fetchData:(MMFetchDataType)type {
    NSMutableDictionary *paraDict = [NSMutableDictionary new];
    NSString *humanId = [[NSUserDefaults standardUserDefaults] objectForKey:MMUserID];
    [paraDict setObjectSafe:humanId forKey:@"humanID"];
    [paraDict setObjectSafe:@(type) forKey:@"queryType"];
    
    BOOL networkState = [MMNetServies postUrl:@"/sys/queryguide.htm"
                              resultContainer:[MMHomeResult new]
                                     paraDict:[paraDict copy]
                                     delegate:self customInfo:nil];
    if (networkState) self.showLoading = YES;
    else [UIAlertView networkError];
}

- (void)loadMore {
    
}

#pragma mark - 网络回调函数
- (void)getSearchNetBack:(id)searchResult forInfo:(id)customInfo {
    
    // 关闭loading
    self.showLoading = NO;
    
    // 处理网络请求
    if (searchResult) {
        self.homeResult = (MMHomeResult *)searchResult;
        self.reloadData = YES;
    }
    else {
        self.homeResult = nil;
        self.reloadData = NO;
        [UIAlertView networkError];
    }
}

@end
