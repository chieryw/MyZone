//
//  NSUserDefaults+Addition.m
//  My-Zone
//
//  Created by chiery on 15/9/13.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#import "NSUserDefaults+Addition.h"

@implementation NSUserDefaults (Addition)

+ (id)valueForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

+ (void)setValue:(id)value forKey:(NSString *)key {
    return[[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
}

@end
