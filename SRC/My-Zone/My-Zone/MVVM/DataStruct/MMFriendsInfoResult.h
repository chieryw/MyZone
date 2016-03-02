//
//  MMGuideFriendsInfoResult.h
//  My-Zone
//
//  Created by chiery on 16/2/28.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSearchNetResult.h"

@interface MMFriendsInfoResult : MMSearchNetResult

@property (nonatomic, strong) NSString *humanID;
@property (nonatomic, strong) NSString *humanName;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *brithday;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *VIP;
@property (nonatomic, strong) NSString *praiseNum;
@property (nonatomic, strong) NSString *treadNum;
@property (nonatomic, strong) NSString *signName;
@property (nonatomic, strong) NSString *strangeFlag;

#warning 暂时保留
@property (nonatomic, strong) NSArray *images;

@end
