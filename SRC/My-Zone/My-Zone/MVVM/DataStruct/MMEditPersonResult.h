//
//  MMEditPersonResult.h
//  My-Zone
//
//  Created by chiery on 16/1/24.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSearchNetResult.h"

@protocol MMEditPerson2Result @end
@interface MMEditPerson2Result : MMSearchNetResult
@property (nonatomic, strong) NSString *success;
@property (nonatomic, strong) NSString *message;
@end

@interface MMEditPersonResult : MMSearchNetResult
@property (nonatomic, strong) MMEditPerson2Result *resultInfo;
@end
