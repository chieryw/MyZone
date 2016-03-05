//
//  MMEvaluteVC.h
//  My-Zone
//
//  Created by chiery on 15/11/7.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMBaseViewController.h"
#import "MMFriendsInfoResult.h"

@interface MMEvaluteVC : MMBaseViewController
@property (nonatomic, assign) BOOL isGood;
@property (nonatomic, strong) MMFriendsInfoResult *currentUserInfo;
@end
