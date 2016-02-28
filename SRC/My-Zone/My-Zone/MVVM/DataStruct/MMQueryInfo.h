//
//  MMQueryInfo.h
//  My-Zone
//
//  Created by chiery on 16/2/28.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSearchNetResult.h"

@protocol MMQueryInfo @end
@interface MMQueryInfo : MMSearchNetResult
@property (nonatomic, strong) NSString *humanID;
@property (nonatomic, strong) NSString *humanName;
@property (nonatomic, strong) NSString *online;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *fileID;
@end
