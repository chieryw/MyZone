//
//  MMFriendsZoneVM.m
//  My-Zone
//
//  Created by chiery on 16/3/7.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMFriendsZoneVM.h"

@interface MMFriendsZoneVM ()

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
    
    self.showLoading = YES;
    [[MMNetServies postRequest:@"/u/friends/new" resultContainer:[MMNewFriendsListResult new] paraDict:[paraDict copy] customInfo:nil] subscribeNext:^(id x) {
        NSParameterAssert([x isKindOfClass:[MMNewFriendsListResult class]]);
        // 关闭loading
        self.showLoading = NO;
        
        // 处理网络请求
        if (x) {
            self.friendsList = (MMNewFriendsListResult *)x;
            self.showErrorView = NO;
            self.reloadData = YES;
        }
        else {
            self.friendsList = nil;
            self.showErrorView = YES;
            self.reloadData = NO;
            [UIAlertView networkError];
        }
        
    } error:^(NSError *error) {
        [UIAlertView networkError];
    }];
}

- (void)loadMore {
    
}

@end
