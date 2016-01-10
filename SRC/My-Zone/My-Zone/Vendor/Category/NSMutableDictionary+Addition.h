//
//  NSMutableDictionary+Utility.h
//  QunariPhone
//
//  Created by chieryW on 14/11/28.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Addition)

- (void)setObjectSafe:(id)anObject forKey:(id < NSCopying >)aKey;

@end
