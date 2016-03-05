//
//  MMEvaluteVM.m
//  My-Zone
//
//  Created by chiery on 16/3/5.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMEvaluteVM.h"
#import "MMSimpleResult.h"

@interface MMEvaluteVM ()<MMNetworkPtc>

@end

@implementation MMEvaluteVM

- (void)submmitWithGuideId:(NSString *)guideID andEvalute:(NSString *)evalute andType:(BOOL)isGood{
    NSMutableDictionary *paraDict = [NSMutableDictionary new];
    NSString *humanId = [[NSUserDefaults standardUserDefaults] objectForKey:MMUserID];
    [paraDict setObjectSafe:humanId forKey:@"humanID"];
    [paraDict setObjectSafe:guideID forKey:@"guideID"];
    [paraDict setObjectSafe:evalute forKey:@"treadNum"];
    
    NSString *urlString = isGood?@"/sys/praise.htm":@"/sys/tread.htm";
    BOOL networkState = [MMNetServies postUrl:urlString
                              resultContainer:[MMSimpleResult new]
                                     paraDict:[paraDict copy]
                                     delegate:self customInfo:nil];
    if (networkState) self.showLoading = YES;
    else [UIAlertView networkError];
}

- (void)getSearchNetBack:(MMSimpleResult *)searchResult forInfo:(id)customInfo {
    // 关闭loading
    self.showLoading = NO;
    
    // 处理网络请求
    if (searchResult && [searchResult.resultInfo.success isEqualToString:@"true"]) {
        [UIAlertView showTitle:@"评价成功!"
                       message:nil
                      delegate:nil
             cancelButtonTitle:@"确定"
             otherButtonTitles:nil];
    }
    else {
        [UIAlertView networkError];
    }
}

@end
