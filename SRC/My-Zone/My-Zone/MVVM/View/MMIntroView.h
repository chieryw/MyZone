//
//  MMIntroView.h
//  My-Zone
//
//  Created by chiery on 15/9/13.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMIntroViewModel.h"

@interface MMIntroView : UIView

@property (nonatomic, strong) MMIntroViewModel *model;
@property (nonatomic, strong) UIButton *enterButton;

@end
