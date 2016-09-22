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

+ (BOOL)postUrl:(NSString *)url
resultContainer:(MMSearchNetResult *)result
       paraDict:(NSDictionary *)paraDict
       delegate:(id<MMNetworkPtc>)delegate
     customInfo:(id)info {
    
    if (paraDict) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:paraDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
        if (data && data.length > 0) {
            NSString *tempString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            MMSearchNetDelgt *netDelegate = [[MMSearchNetDelgt alloc] init];
            [netDelegate setSearchResult:result];
            [netDelegate setDelegate:delegate];
            [netDelegate setCustomInfo:info];
            
            BOOL network = [MMNetworkTask postSearch:url
                                            forParam:tempString
                                           withDelgt:netDelegate];
            return network;
        }
    }
    return NO;
}

@end
