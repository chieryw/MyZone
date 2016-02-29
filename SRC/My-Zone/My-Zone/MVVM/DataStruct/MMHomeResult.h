//
//  MMListResult.h
//  My-Zone
//
//  Created by chiery on 16/2/21.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSearchNetResult.h"
#import "MMGuideInfoResult.h"

@interface MMHomeResult : MMSearchNetResult

@property (nonatomic, strong) NSString *count;  // 当前列表的个数
@property (nonatomic, strong) NSArray <MMGuideInfoResult> *guideList;

@end
