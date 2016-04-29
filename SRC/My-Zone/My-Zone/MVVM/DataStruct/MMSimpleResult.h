//
//  MMEditPersonResult.h
//  My-Zone
//
//  Created by chiery on 16/1/24.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSearchNetResult.h"

@protocol MMSimpleInfo @end
@interface MMSimpleInfo : MMSearchNetResult
@property (nonatomic, strong) NSNumber *success;
@property (nonatomic, strong) NSString *message;
@end

@interface MMSimpleResult : MMSearchNetResult
@property (nonatomic, strong) MMSimpleInfo *resultInfo;
@end
