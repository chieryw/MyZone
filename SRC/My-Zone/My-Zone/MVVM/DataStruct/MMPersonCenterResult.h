//
//  MMPersonCenterResult.h
//  My-Zone
//
//  Created by chiery on 16/1/24.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMSearchNetResult.h"

@protocol MMPersonImageResult @end
@interface MMPersonImageResult : MMSearchNetResult
@property (nonatomic, strong) NSString *fileID;
@property (nonatomic, strong) NSNumber *selected;
@end

@interface MMPersonCenterResult : MMSearchNetResult
@property (nonatomic, strong) NSString *humanName;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *brithday;
@property (nonatomic, strong) NSString *signName;
@property (nonatomic, strong) NSArray <MMPersonImageResult> *attFile;
@end
