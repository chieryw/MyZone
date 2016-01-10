//
//  QWNetworkDelgt.m
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import "MMNetworkDelgt.h"
#import "MMNetworkController.h"

@implementation MMNetworkDelgt

- (instancetype)init
{
    if (self = [super init]) {
        _receivedData = [[NSMutableData alloc] init];
    }
    return self;
}

- (bool)isSame:(id<MMNetworkPtc>)delegateObject
{
    return [_delegate isEqual:delegateObject];
}

// =============================================================================
// 代理函数
// =============================================================================
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
    NSURLResponse *response = task.response;
    if ([response respondsToSelector:@selector(statusCode)])
    {
        NSInteger statusCode = [((NSHTTPURLResponse *)response) statusCode];
        if (statusCode >= 400)
        {
#if DEBUG
            NSLog(@"Server returned HTTP Error code %ld", (long)statusCode);
#endif
        }
    }
    
    [[MMNetworkController getInstance] removeConnection:task];
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    NSLog(@"%@", session);
}

@end
