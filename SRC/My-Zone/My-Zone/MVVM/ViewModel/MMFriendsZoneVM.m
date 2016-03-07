//
//  MMFriendsZoneVM.m
//  My-Zone
//
//  Created by chiery on 16/3/7.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMFriendsZoneVM.h"

@interface MMFriendsZoneVM ()<MMNetworkPtc>

@end

@implementation MMFriendsZoneVM

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
- (void)fetchData {
    NSMutableDictionary *paraDict = [NSMutableDictionary new];
    NSString *humanId = [[NSUserDefaults standardUserDefaults] objectForKey:MMUserID];
    [paraDict setObjectSafe:humanId forKey:@"humanID"];
    
    BOOL networkState = [MMNetServies postUrl:@"/sys/friends/newFriends.htm"
                              resultContainer:[MMNewFriendsListResult new]
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
        self.friendsList = (MMNewFriendsListResult *)searchResult;
        self.showErrorView = NO;
        self.reloadData = YES;
    }
    else {
        self.friendsList = nil;
        self.showErrorView = YES;
        self.reloadData = NO;
        [UIAlertView networkError];
    }
}

@end
