//
//  QWNetworkTask.h
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import <Foundation/Foundation.h>
@class MMNetworkDelgt;

@interface MMNetworkTask : NSObject

// 得到当前网络状态
+ (NSString *)getCurNetStatus;

// 得到当前网络状态
+ (NSString *)getCurNetStatusForLog;

// 获取当前运营商Code
+ (NSString *)getCarrierCode;

/**
 *  搜索服务
 *
 *  @param service  服务类型@"t="
 *  @param param    Json String, Key-Value 方式来表示参数, 只有一个层级
 *  @param delegate 指定网络回调的Delegate
 *
 *
 */
+ (NSURLSessionTask *)postSearch:(NSString *)service
                        forParam:(NSString *)param
                       withDelgt:(MMNetworkDelgt *)delegate;

@end
