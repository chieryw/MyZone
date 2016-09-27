//
//  MMNetServies.m
//  My-Zone
//
//  Created by chiery on 16/1/24.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMNetServies.h"
#import "MMNetworkTask.h"

@implementation MMNetServies

+ (NSURLSessionTask *)postUrl:(NSString *)url
              resultContainer:(MMSearchNetResult *)result
                     paraDict:(NSDictionary *)paraDict
                   customInfo:(id)info
                  resultBlock:(void (^)(MMSearchNetStatus *, id))resultBlcok {
    
    if (paraDict) {
        // 解析参数数据
        NSData *data = [NSJSONSerialization dataWithJSONObject:paraDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
        if (data && data.length > 0) {
            NSString *paramString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            MMSearchNetDelgt *netDelegate = [[MMSearchNetDelgt alloc] init];
            [netDelegate setSearchResult:result];
            [netDelegate setResultBlock:resultBlcok];
            [netDelegate setCustomInfo:info];
            
            return [MMNetworkTask postSearch:url
                                    forParam:paramString
                                   withDelgt:netDelegate];
        }
    }
    return nil;
}

+ (RACSignal *)postRequest:(NSString *)servie
           resultContainer:(MMSearchNetResult *)resultInstance
                  paraDict:(NSDictionary *)paraDict
                customInfo:(id)customInfo {
    
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionTask *task = [MMNetServies postUrl:servie
                                       resultContainer:resultInstance
                                              paraDict:paraDict
                                            customInfo:customInfo
                                           resultBlock:^(MMSearchNetStatus *status, id data) {
                                     if(status && status.code && [status.code integerValue] == 0){
                                         [subscriber sendNext:data];
                                         [subscriber sendCompleted];
                                     }
                                     else{
                                         if (status) {
                                             NSError *error = [[NSError alloc] initWithDomain:@"myzone.com" code:status.code.integerValue userInfo:@{@"description":status.des?:@"未知错误！！！"}];
                                             [subscriber sendError:error];
                                         }
                                     }
                                }];
        
        // 信号执行完成或是信号执行错误就走这个信号指令
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] takeUntil:self.rac_willDeallocSignal];
    
    // 在这里打上一个记录标记，方便debug
    [signal setNameWithFormat:@"-connectionSignal: %@", servie];
    
    return signal;
}

@end
