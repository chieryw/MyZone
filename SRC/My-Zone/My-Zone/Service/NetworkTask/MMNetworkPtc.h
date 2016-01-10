//
//  QWNetworkPtc.h
//  QunariPhone
//
//  Created by chieryW on 14/11/26.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MMNetworkPtc <NSObject>
@optional

// 获取网络请求回调
- (void)getSearchNetBack:(id)searchResult forInfo:(id)customInfo;
- (void)getFetchNetBack:(NSDictionary *)jsonDictionary forInfo:(id)customInfo;

@end
