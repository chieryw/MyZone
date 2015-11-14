//
//  MMDate.h
//  My-Zone
//
//  Created by chiery on 15/10/11.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMDate : NSDate

+ (instancetype)shareInstance;

@end

@interface MMDateFormatter : NSDateFormatter

+ (instancetype)shareInstance;

+ (NSString *)yyMMddString:(NSDate *)date;

@end
