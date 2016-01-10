//
//  QWNetworkDelgt.h
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMNetworkPtc.h"

// ==================================================================
// 网络代理对象的逻辑基类
// ==================================================================

@interface MMNetworkDelgt : NSObject <NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDelegate>

@property (nonatomic, strong) id customInfo;    // 代理
@property (nonatomic, weak) id <MMNetworkPtc> delegate;   // 自定义图片信息
@property (nonatomic, strong) NSMutableData *receivedData;  // 数据接收对象
@property (nonatomic, strong) NSString *decodeKey;				// 加密字符

// 回调对象是否一样
- (bool)isSame:(id)delegateObject;

@end
