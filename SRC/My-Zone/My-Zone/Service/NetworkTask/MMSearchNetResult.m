//
//  QWSearchNetResult.m
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import "MMSearchNetResult.h"
#import "MMJSONMapping.h"

@implementation MMSearchNetResult

- (instancetype)init
{
    if (self = [super init]) {

    }
    return self;
}

// 解析所有数据
- (void)parseAllNetResult:(NSDictionary *)jsonDictionary
{
    NSAssert(jsonDictionary, @"网络回调数据为空！！！！");
    
    // 解析业务线数据
    NSDictionary *data = jsonDictionary[@"data"];
    if(data) [self parseNetResult:data];
    
    NSDictionary *netStatus = jsonDictionary[@"netStatus"];
    if (netStatus) {
        MMSearchNetStatus *status = [MMSearchNetStatus new];
        [MMJSONMapping mappingObject:status withJSON:netStatus];
    }
}

// 解析业务数据
- (void)parseNetResult:(NSDictionary *)jsonDictionary
{
    // 开始自动化解析
    [MMJSONMapping mappingObject:self withJSON:jsonDictionary];
}

- (NSDictionary *)mappingPropertyList
{
    return nil;
}

@end
