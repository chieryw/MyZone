//
//  MMGuideListResult.h
//  My-Zone
//
//  Created by chiery on 16/2/28.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSearchNetResult.h"
#import "MMFriendsInfo.h"

@interface MMGuideListResult : MMSearchNetResult
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSArray <MMFriendsInfo> *guideList;

@end
