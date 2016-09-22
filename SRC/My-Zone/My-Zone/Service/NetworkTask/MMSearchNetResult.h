//
//  QWSearchNetResult.h
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import "MMNetworkDelgt.h"
#import "MMJSONModel.h"
#import "MMSearchNetStatus.h"

@interface MMSearchNetResult : MMJSONModel

@property (nonatomic, strong) MMSearchNetStatus *bstatus;

- (void)parseAllNetResult:(NSDictionary *)jsonDictionary;

- (void)parseNetResult:(NSDictionary *)jsonDictionary;

@end
