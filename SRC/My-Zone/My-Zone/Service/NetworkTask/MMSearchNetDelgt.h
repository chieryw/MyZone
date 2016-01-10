//
//  QWSearchNetDelgt.h
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import "MMNetworkDelgt.h"
#import "MMSearchNetResult.h"

@interface MMSearchNetDelgt : MMNetworkDelgt

@property (nonatomic, strong) MMSearchNetResult *searchResult;	// 结果数据

@end
