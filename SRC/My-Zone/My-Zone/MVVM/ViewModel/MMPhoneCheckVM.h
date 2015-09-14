//
//  MMPhoneCheckVM.h
//  My-Zone
//
//  Created by chiery on 15/9/12.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMIntroViewModel.h"

@interface MMPhoneCheckVM : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *checkString;
@property (nonatomic, assign) BOOL checkSelected;
@property (nonatomic, assign) BOOL introViewNeedShow;
@property (nonatomic, strong) MMIntroViewModel *introViewModel;

- (instancetype)initWithModel:(id)sender;

@end
