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
@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation MMIntroView

- (void)dealloc {
    self.scrollView.delegate = nil;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 遮罩下面的视图
        self.backgroundColor = [UIColor whiteColor];
        // 初始化首页介绍视图
        [self initScrollView:frame];
        // 加上对应的Control
        [self addSubview:self.pageControl];
    }
    return self;
}

- (instancetype)init
{
    return [[MMIntroView alloc] initWithFrame:kFullScreenRect];
}

- (void)setModel:(MMIntroViewModel *)model {
    _model = model;
    self.pageControl.numberOfPages = model.images.count;
}

#pragma mark - 初始化视图

- (void)initScrollView:(CGRect)frame {

    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    
    }
    
    [self addSubview:_scrollView];
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(100,
                                                                       kScreenHeight - 100,
                                                                       kScreenWidth - 200,
                                                                       30)];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 0;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor MMBlueColor];
    }
    return _pageControl;
}



- (void)layoutSubviews {

    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    self.scrollView.contentSize = CGSizeMake(rect.size.width * self.model.images.count, rect.size.height);
    
    __weak typeof(self) weakSelf = self;
    [self.model.images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(idx * rect.size.width, 0, rect.size.width, rect.size.height)];
        imageView.image = image;
        [strongSelf.scrollView addSubview:imageView];
        
        // 最后一页上添加上进入按钮
        if (idx == strongSelf.model.images.count - 1) {
            // 当前的ImageView可以点击
            imageView.userInteractionEnabled = YES;
            
            [strongSelf.enterButton setFrame:CGRectMake(100,
                                              kScreenHeight - 150,
                                              kScreenWidth - 200,
                                              40)];
            [strongSelf.enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
            [imageView addSubview:strongSelf.enterButton];
            
        }
    }];
    
}

- (UIButton *)enterButton {

    if (!_enterButton) {
        _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_enterButton setBackgroundColor:[UIColor MMBlueColor]];
        [_enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_enterButton.titleLabel setFont:[UIFont MMTextFont16]];
        [_enterButton addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _enterButton;
}

- (void)dismissSelf {
    
    // 当前可以看见下面的视图
    self.backgroundColor = [UIColor clearColor];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.4
                     animations:^{
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         if (finished) {
                             [weakSelf removeFromSuperview];

                         }
                     }];
    
}


#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint contentOffSet = scrollView.contentOffset;
    self.pageControl.currentPage = contentOffSet.x/kScreenWidth;
    
}

@end
