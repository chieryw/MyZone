//
//  QWNetworkDelgt.m
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import "MMNetworkDelgt.h"
#import "MMSearchNetStatus.h"

@implementation MMNetworkDelgt

- (instancetype)init
{
    if (self = [super init]) {
        _receivedData = [[NSMutableData alloc] init];
    }
    return self;
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [_receivedData appendData:data];
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error
{
    NSLog(@"didBecomeInvalidWithError");
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    MMSearchNetStatus *status = [MMSearchNetStatus new];
    
    NSURLResponse *response = task.response;
    if ([response respondsToSelector:@selector(statusCode)]) {
        NSInteger statusCode = [((NSHTTPURLResponse *)response) statusCode];
        status.code = @(statusCode);
        if (statusCode >= 400) {
            #if DEBUG
            NSLog(@"Server returned HTTP Error code %ld", (long)statusCode);
            #endif
        }
    }
    
    if (error) status.des = error.localizedDescription;
    if (self.resultBlock) self.resultBlock(status,nil);
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    // 当有backGround请求的时候需要在这里处理协议
    NSLog(@"%@", session);
}

@end
