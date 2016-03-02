//
//  MMUserDetailVM.m
//  My-Zone
//
//  Created by chiery on 16/3/2.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMUserDetailVM.h"
#import "MMFriendsInfoResult.h"

@interface MMUserDetailVM ()<MMNetworkPtc>

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
    
    BOOL networkState = [MMNetServies postUrl:@"/sys/guidefriendsinfo.htm"
                              resultContainer:[MMFriendsInfoResult new]
                                     paraDict:[paraDict copy]
                                     delegate:self customInfo:nil];
    if (networkState) self.showLoading = YES;
    else [UIAlertView networkError];
}

- (void)getSearchNetBack:(id)searchResult forInfo:(id)customInfo {
    // 关闭loading
    self.showLoading = NO;
    
    // 处理网络请求
    if (searchResult) {
        self.friendsInfoResult = (MMFriendsInfoResult *)searchResult;
        self.showErrorView = NO;
        self.reloadData = YES;
    }
    else {
        self.friendsInfoResult = nil;
        self.showErrorView = YES;
        self.reloadData = NO;
        [UIAlertView networkError];
    }
}

@end
