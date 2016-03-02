//
//  MMUserDetailVM.h
//  My-Zone
//
//  Created by chiery on 16/3/2.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MMFriendsInfoResult;

@interface MMUserDetailVM : NSObject
@property (nonatomic, assign) BOOL showLoading;
@property (nonatomic, strong) NSString *humanId;    // 用于请求的参数
@property (nonatomic, assign) BOOL reloadData;      // 刷新界面
@property (nonatomic, assign) BOOL showErrorView;
@property (nonatomic, strong) MMFriendsInfoResult *friendsInfoResult;

- (void)startLoadData;

@end
