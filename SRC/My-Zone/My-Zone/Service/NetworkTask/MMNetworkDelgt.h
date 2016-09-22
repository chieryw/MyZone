//
//  QWNetworkDelgt.h
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMSearchNetStatus.h"

//
//typedef void(^QWHNetworkFailurBlock)(SearchNetStatus * staus,id data);
//
//typedef void(^QWHNetworkSuccessBlock)(id data);
//
typedef void(^MMNetResultBlock)(MMSearchNetStatus * status,id data);

@interface MMNetworkDelgt : NSObject <NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDelegate>

@property (nonatomic, strong) id customInfo;                    // 代理
@property (nonatomic, copy) MMNetResultBlock resultBlock;       // 回调的block
@property (nonatomic, strong) NSMutableData *receivedData;      // 数据接收对象
@property (nonatomic, strong) NSString *decodeKey;				// 加密字符

@end
