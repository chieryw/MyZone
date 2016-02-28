//
//  MMGuideInfoResult.h
//  My-Zone
//
//  Created by chiery on 16/2/28.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSearchNetResult.h"

@protocol MMGuideInfoResult @end
@interface MMGuideInfoResult : MMSearchNetResult
@property (nonatomic, strong) NSString *humanID;
@property (nonatomic, strong) NSString *humanName;
@property (nonatomic, strong) NSString *online;
@property (nonatomic, strong) NSString *signName;
@property (nonatomic, strong) NSString *VIP;
@property (nonatomic, strong) NSString *fileID;
@end
