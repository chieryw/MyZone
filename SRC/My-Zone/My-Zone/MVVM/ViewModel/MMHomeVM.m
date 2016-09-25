//
//  MMHomeVM.m
//  My-Zone
//
//  Created by chiery on 16/2/29.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMHomeVM.h"
#import "MMHomeResult.h"

@interface MMHomeVM ()

@end

@implementation MMHomeVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {
    self.hasMore = NO;
}

#pragma mark - 事件处理函数
- (void)fetchData {
    NSMutableDictionary *paraDict = [NSMutableDictionary new];
    NSString *humanId = [[NSUserDefaults standardUserDefaults] objectForKey:MMUserID];
    [paraDict setObjectSafe:humanId forKey:@"humanID"];
    [paraDict setObjectSafe:@(self.fetchDataType) forKey:@"queryType"];
    
    self.showLoading = YES;
    @weakify(self);
    [[MMNetServies postRequest:@"/list/guider" resultContainer:[MMHomeResult new] paraDict:[paraDict copy] customInfo:nil] subscribeNext:^(id x) {
        NSParameterAssert([x isKindOfClass:[MMHomeResult class]]);
        @strongify(self);
        self.showLoading = NO;
        
        // 处理网络请求
        if (x) {
            self.homeResult = (MMHomeResult *)x;
            self.showErrorView = NO;
            self.reloadData = YES;
        }
        else {
            self.homeResult = nil;
            self.showErrorView = YES;
            self.reloadData = NO;
            [UIAlertView networkError];
        }
        
    } error:^(NSError *error) {
        @strongify(self);
        self.showLoading = NO;
        [UIAlertView networkError];
    }];
}

- (void)loadMore {
    
}

@end
