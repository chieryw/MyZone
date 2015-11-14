//
//  MMDate.m
//  My-Zone
//
//  Created by chiery on 15/10/11.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMDate.h"

@implementation MMDate

+ (instancetype)shareInstance {
    static MMDate *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[MMDate alloc] init];
    });
    return __instance;
}

@end

@implementation MMDateFormatter

+ (instancetype)shareInstance {
    static MMDateFormatter *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[MMDateFormatter alloc] init];
    });
    return __instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setLocale:[[NSLocale alloc] initWithLocaleIdentifier:NSCalendarIdentifierGregorian]];
    }
    return self;
}

+ (NSString *)yyMMddString:(NSDate *)date {
    MMDateFormatter *dateFormatter = [MMDateFormatter shareInstance];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

@end
