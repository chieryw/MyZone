//
//  NSUserDefaults+Addition.h
//  My-Zone
//
//  Created by chiery on 15/9/13.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Addition)

/**
 *  对应的键值对
 *
 *  @param key 键
 *
 *  @return 值
 */
+ (id)valueForKey:(NSString *)key;

/**
 *  存储用户信息
 *
 *  @param value 值
 *  @param key   键
 */
+ (void)setValue:(id)value forKey:(NSString *)key;

@end
