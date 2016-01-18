//
//  MMLoginResult.h
//  My-Zone
//
//  Created by chiery on 16/1/18.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMSearchNetResult.h"

@protocol MMLoginResultDetail @end
@interface MMLoginResultDetail : MMSearchNetResult
@property (nonatomic, strong) NSString *success;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *humanID;
@end


@interface MMLoginResult : MMSearchNetResult
@property (nonatomic, strong) MMLoginResultDetail *resultInfo;
@property (nonatomic, strong, setter = setTestArray:,getter=getTestArray) NSArray <MMLoginResultDetail> *testArray;
@end
