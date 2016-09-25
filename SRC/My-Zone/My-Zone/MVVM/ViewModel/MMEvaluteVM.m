//
//  MMEvaluteVM.m
//  My-Zone
//
//  Created by chiery on 16/3/5.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMEvaluteVM.h"
#import "MMSimpleResult.h"

@interface MMEvaluteVM ()

@end

@implementation MMEvaluteVM

- (void)submmitWithGuideId:(NSString *)guideID andEvalute:(NSString *)evalute andType:(BOOL)isGood{
    NSMutableDictionary *paraDict = [NSMutableDictionary new];
    NSString *humanId = [[NSUserDefaults standardUserDefaults] objectForKey:MMUserID];
    [paraDict setObjectSafe:humanId forKey:@"humanID"];
    [paraDict setObjectSafe:guideID forKey:@"guideID"];
    [paraDict setObjectSafe:evalute forKey:@"treadNum"];
    
    NSString *urlString = isGood?@"/tour/praise.htm":@"/tour/tread.htm";
    
    self.showLoading = YES;
    [[MMNetServies postRequest:urlString resultContainer:[MMSimpleResult new] paraDict:[paraDict copy] customInfo:nil] subscribeNext:^(id x) {
        NSParameterAssert([x isKindOfClass:[MMSimpleResult class]]);
        
        // 关闭loading
        self.showLoading = NO;
        
        // 处理网络请求
        if (x) {
            [UIAlertView showTitle:@"评价成功!"
                           message:nil
                          delegate:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
        }
        else {
            [UIAlertView networkError];
        }
    } error:^(NSError *error) {
        [UIAlertView networkError];
    }];
}

@end
