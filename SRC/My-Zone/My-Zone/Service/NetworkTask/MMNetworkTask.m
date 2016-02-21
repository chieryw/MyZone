//
//  QWNetworkTask.m
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import "MMNetworkTask.h"

#import "Reachability.h"

#import "MMNetworkTask.h"
#import	"MMNetworkController.h"
#import "MMSearchNetDelgt.h"

#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

// 超时
#define kNetworkTaskTimeOut					60


@implementation MMNetworkTask

// 得到当前网络状态
+ (NSString *)getCurNetStatus
{
    Reachability *curReach = [Reachability reachabilityForInternetConnection];
    
    // 获得网络状态
    NetworkStatusIphone netStatus = [curReach currentReachabilityStatus];
    switch (netStatus)
    {
        case NotReachable:
        {
            return nil;
        }
            break;
            
        case ReachableViaWWAN:
        {
            return @"2g/3g";
        }
            break;
            
        case ReachableViaWiFi:
        {
            return @"wifi";
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

// 得到当前网络状态
+ (NSString *)getCurNetStatusForLog
{
    Reachability *curReach = [Reachability reachabilityForInternetConnection];
    
    // 获得网络状态
    NetworkStatusIphone netStatus = [curReach currentReachabilityStatus];
    switch (netStatus)
    {
        case NotReachable:
        {
            return nil;
        }
            break;
            
        case ReachableViaWWAN:
        {
            // 判断是否能够取得运营商
            Class telephoneNetWorkClass = (NSClassFromString(@"CTTelephonyNetworkInfo"));
            if (telephoneNetWorkClass != nil)
            {
                CTTelephonyNetworkInfo *telephonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
                
                if ([telephonyNetworkInfo respondsToSelector:@selector(currentRadioAccessTechnology)])
                {
                    // 7.0 系统的适配处理。
                    
                    return [NSString stringWithFormat:@"%@",telephonyNetworkInfo.currentRadioAccessTechnology];
                }
            }
            
            return @"2g/3g";
        }
            break;
            
        case ReachableViaWiFi:
        {
            return @"wifi";
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

+ (NSString *)getCarrierCode
{
    // 判断是否能够取得运营商
    Class telephoneNetWorkClass = (NSClassFromString(@"CTTelephonyNetworkInfo"));
    if (telephoneNetWorkClass != nil)
    {
        CTTelephonyNetworkInfo *telephonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
        
        // 获得运营商的信息
        Class carrierClass = (NSClassFromString(@"CTCarrier"));
        if (carrierClass != nil)
        {
            CTCarrier *carrier = telephonyNetworkInfo.subscriberCellularProvider;
            
            // 移动运营商的mcc 和 mnc
            NSString * mobileCountryCode = [carrier mobileCountryCode];
            NSString * mobileNetworkCode = [carrier mobileNetworkCode];
            
            // 统计能够取到信息的运营商
            if ((mobileCountryCode != nil) && (mobileNetworkCode != nil))
            {
                NSString *mobileCode = [[NSString alloc] initWithFormat:@"%@%@", mobileCountryCode, mobileNetworkCode];
                return mobileCode;
            }
        }
    }
    
    return nil;
}

// 搜索
+ (BOOL)postSearch:(NSString *)service
          forParam:(NSString *)param
            forRes:(BOOL)isSync
    forTargetModel:(NSString *)targetModel
         withDelgt:(MMSearchNetDelgt *)searchNetDelgt
{
    NSData *postData = [param dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *httpGetURLString = [NSMutableString stringWithString:MMDebugUrl];
    
    if ((service != nil) && ([service length] > 0)){
        [httpGetURLString appendString:service];
    }
    
    NSURL *url = [[NSURL alloc] initWithString:httpGetURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:kNetworkTaskTimeOut];
    
    // 设置参数
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"Close" forHTTPHeaderField:@"Connection"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:searchNetDelgt delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request];
    [task resume];
    
    [[MMNetworkController getInstance] addConnection:task andDelegate:searchNetDelgt];
    
    return YES;
}

// 搜索
+ (BOOL)postSearch:(NSString *)service
          forParam:(NSString *)param
            forRes:(BOOL)isSync
         withDelgt:(MMSearchNetDelgt *)searchNetDelgt
{
    return [MMNetworkTask postSearch:service forParam:param forRes:isSync forTargetModel:nil withDelgt:searchNetDelgt];
}

@end
