//
//  MMNetServies.h
//  My-Zone
//
//  Created by chiery on 16/1/24.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMSearchNetResult.h"
#import "MMSearchNetDelgt.h"

@interface MMNetServies : NSObject

/**
 *  post请求中间转化
 *
 *  @param url      请求路径
 *  @param result   结果承接容器
 *  @param paraDict 参数
 *  @param delegate 代理
 *  @param info     请求tag
 *
 *  @return 请求是否存在
 */
+ (NSURLSessionTask *)postUrl:(NSString *)url
              resultContainer:(MMSearchNetResult *)result
                     paraDict:(NSDictionary *)paraDict
                   customInfo:(id)info
                  resultBlock:(void(^)(MMSearchNetStatus *status,id data))resultBlcok;

+ (RACSignal *)postRequest:(NSString *)servie
           resultContainer:(MMSearchNetResult *)resultInstance
                  paraDict:(NSDictionary *)paraDict
                customInfo:(id)customInfo;

@end
