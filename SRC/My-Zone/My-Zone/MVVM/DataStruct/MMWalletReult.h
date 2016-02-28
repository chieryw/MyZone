//
//  MMWalletReult.h
//  My-Zone
//
//  Created by chiery on 16/2/28.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSearchNetResult.h"

@interface MMWalletInfo : MMSearchNetResult
@property (nonatomic, strong) NSString *success;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *moneyNum;
@end


@interface MMWalletReult : MMSearchNetResult
@property (nonatomic, strong) MMWalletInfo *resultInfo;
@end
