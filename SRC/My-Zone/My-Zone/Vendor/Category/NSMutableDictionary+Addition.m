//
//  NSMutableDictionary+Utility.m
//  QunariPhone
//
//  Created by chieryW on 14/11/28.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import "NSMutableDictionary+Addition.h"

@implementation NSMutableDictionary (Utility)

// 设置Key/Value
- (void)setObjectSafe:(id)anObject forKey:(id < NSCopying >)aKey
{
    if(anObject != nil)
    {
        [self setObject:anObject forKey:aKey];
    }
}

@end
