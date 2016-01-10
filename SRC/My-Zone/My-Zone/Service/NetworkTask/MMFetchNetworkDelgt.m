//
//  QWFetchNetworkDelgt.m
//  Watch
//
//  Created by chieryW on 14/12/11.
//
//

#import "MMFetchNetworkDelgt.h"

@implementation MMFetchNetworkDelgt

// 数据接收结束
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    // 解析数据
    @autoreleasepool
    {
        if (self.receivedData && self.receivedData.length > 0) {
            NSError *error;
            _jsonResult = [NSJSONSerialization JSONObjectWithData:self.receivedData
                                                          options:NSJSONReadingMutableContainers
                                                            error:&error];
        }
    }
    
    // 回调
    if([self.delegate respondsToSelector:@selector(getFetchNetBack:forInfo:)])
    {
        // 回调
        [self.delegate getFetchNetBack:_jsonResult forInfo:self.customInfo];
    }
    
    [super URLSession:session task:task didCompleteWithError:error];
}

@end
