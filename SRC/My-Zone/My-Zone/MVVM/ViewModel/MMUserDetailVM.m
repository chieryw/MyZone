//
//  MMUserDetailVM.m
//  My-Zone
//
//  Created by chiery on 16/3/2.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMUserDetailVM.h"
#import "MMFriendsInfoResult.h"

@interface MMUserDetailVM ()

@end

@implementation MMUserDetailVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {

}

- (void)startLoadData {
    NSMutableDictionary *paraDict = [NSMutableDictionary new];
    NSString *humanId = [[NSUserDefaults standardUserDefaults] objectForKey:MMUserID];
    [paraDict setObjectSafe:humanId forKey:@"humanID"];
    
    self.showLoading = YES;
    [[MMNetServies postRequest:@"/u/friends/guider/info" resultContainer:[MMFriendsInfoResult new] paraDict:[paraDict copy] customInfo:nil] subscribeNext:^(id x) {
        NSParameterAssert([x isKindOfClass:[MMFriendsInfoResult class]]);
        
        // 关闭loading
        self.showLoading = NO;
        
        // 处理网络请求
        if (x) {
            self.friendsInfoResult = (MMFriendsInfoResult *)x;
            self.showErrorView = NO;
            self.reloadData = YES;
        }
        else {
            self.friendsInfoResult = nil;
            self.showErrorView = YES;
            self.reloadData = NO;
            [UIAlertView networkError];
        }
        
    } error:^(NSError *error) {
        [UIAlertView networkError];
    }];
}

@end
