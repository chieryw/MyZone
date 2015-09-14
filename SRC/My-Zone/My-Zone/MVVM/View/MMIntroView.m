//
//  MMIntroView.m
//  My-Zone
//
//  Created by chiery on 15/9/13.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#import "MMIntroView.h"

@interface MMIntroView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation MMIntroView

- (void)dealloc {
    _scrollView.delegate = nil;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initScrollView:frame];
    }
    return self;
}

- (void)initScrollView:(CGRect)frame {

    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        
        [self addSubview:_scrollView];
    }
    
}

- (instancetype)init
{
    return [[MMIntroView alloc] initWithFrame:kFullScreenRect];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    _scrollView.contentSize = CGSizeMake(rect.size.width * self.model.images.count, rect.size.height);
    
    [self.model.images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(idx * rect.size.width, 0, rect.size.width, rect.size.height)];
        imageView.image = image;
        [_scrollView addSubview:imageView];
        
        // 最后一页上添加上进入按钮
        if (idx == self.model.images.count - 1) {
            [_enterButton setFrame:CGRectMake(100,
                                              kScreenHeight - 150,
                                              kScreenWidth - 200,
                                              40)];
            [_enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
            [imageView addSubview:_enterButton];
        }
    }];
    
}

- (UIButton *)enterButton {

    if (!_enterButton) {
        _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_enterButton setBackgroundColor:[UIColor MMBlueColor]];
        [_enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_enterButton.titleLabel setFont:[UIFont MMTextFont16]];
    }
    
    return _enterButton;
}

@end
