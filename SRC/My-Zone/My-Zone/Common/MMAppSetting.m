//
//  MMAppSetting.m
//  My-Zone
//
//  Created by chiery on 15/9/19.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMAppSetting.h"

@implementation MMAppSetting

+ (instancetype)getInstance {

    static MMAppSetting *__instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instace = [[MMAppSetting alloc] init];
    });
    
    return __instace;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        //
        
    }
    return self;
}

- (void)configureIntroView {

    NSNumber *isFirstDownload = [NSUserDefaults valueForKey:MMApplicationFirstDownload];
    NSNumber *isFirstEnter = [NSUserDefaults valueForKey:MMApplicationFirstEnter];
    
    if (!isFirstDownload) {
        [NSUserDefaults setValue:[NSNumber numberWithBool:YES] forKey:MMApplicationFirstDownload];
    }
    
    if (!isFirstEnter) {
        [NSUserDefaults setValue:[NSNumber numberWithBool:YES] forKey:MMApplicationFirstEnter];
    }
    
}

@end
