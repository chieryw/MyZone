//
//  QWSearchNetResult.h
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import "MMNetworkDelgt.h"
#import "MMJSONModel.h"

@interface MMSearchNetResult : MMJSONModel

// 解析所有数据
- (void)parseAllNetResult:(NSDictionary *)jsonDictionary;

// 解析业务数据
- (void)parseNetResult:(NSDictionary *)jsonDictionary;

@end
