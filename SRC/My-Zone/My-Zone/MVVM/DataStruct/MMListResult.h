//
//  MMListResult.h
//  My-Zone
//
//  Created by chiery on 16/2/21.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSearchNetResult.h"

@protocol MMGuideListResuilt @end
@interface MMGuideListResuilt : MMSearchNetDelgt
@property (nonatomic, strong) NSString *humanID;
@property (nonatomic, strong) NSString *humanName;
@property (nonatomic, strong) NSString *online;
@property (nonatomic, strong) NSString *signName;
@property (nonatomic, strong) NSString *VIP;
@property (nonatomic, strong) NSString *fileID;
@end

@interface MMListResult : MMSearchNetResult

@property (nonatomic, strong) NSString *count;  // 当前列表的个数
@property (nonatomic, strong) NSArray <MMGuideListResuilt> *guideList;

@end
