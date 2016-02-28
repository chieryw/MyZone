//
//  MMQueryListResult.h
//  My-Zone
//
//  Created by chiery on 16/2/28.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSearchNetResult.h"
#import "MMQueryInfo.h"

@interface MMQueryListResult : MMSearchNetResult
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSArray <MMQueryInfo> *visitorList;
@end
