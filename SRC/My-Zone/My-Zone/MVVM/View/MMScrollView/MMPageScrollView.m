//
//  MMPageScrollView.m
//  TestScrollView
//
//  Created by chiery on 16/1/19.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMPageScrollView.h"

@interface MMPageScrollView () <UIScrollViewDelegate>
@property (nonatomic, assign)   NSInteger       currentPageIndex;
@property (nonatomic, readonly) CGFloat         leftRightOffset;
@property (nonatomic, strong)   UIScrollView*   scrollView;
@property (nonatomic, strong)   NSMutableArray* viewsInPage;
@property (nonatomic, strong)   NSMutableArray* viewsCenter;
@end

@implementation MMPageScrollView{
    CGSize    _cellSize;
    NSInteger _numberOfCell;
    CGPoint   _lastVelocityScrollView;
}

- (void)dealloc
{
    _viewsInPage = nil;
    [[self.scrollView subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self.scrollView removeFromSuperview];
    self.scrollView = nil;
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {
    [self initializeValue];
    [self reloadData];
    
    [self.scrollView addObserver:self
           forKeyPath:@"contentOffset"
              options:NSKeyValueObservingOptionNew
              context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint tempPoint = [change[@"new"] CGPointValue];
        [self updateScale:tempPoint.x + self.frame.size.width/2];
    }
}

- (void)updateScale:(CGFloat)currentLocate {
    // 遍历数组中对象  对距离做检测，这样来设置view的scale的转化
    for (NSInteger i = 0; i < self.viewsCenter.count; i ++) {
        CGFloat currentViewCenter = [self.viewsCenter[i] floatValue];
        if (fabs(currentViewCenter - currentLocate) < (_cellSize.width / 2 + self.padding)) {
            // 计算距离的百分比
            CGFloat percent = fabs(currentViewCenter - currentLocate) / (_cellSize.width / 2 + self.padding);
            
            UIView *tempView = self.viewsInPage[i];
            CGPoint tempCenter = tempView.center;
            tempView.frame = CGRectMake(0,
                                        0,
                                        (1 - 0.05 * percent)*_cellSize.width,
                                        (1 - 0.05 * percent)*_cellSize.height);
            tempView.center = tempCenter;
        }
    }
}

- (void)initializeValue {
    _padding = 10;
    _currentPageIndex = 0;
    self.clipsToBounds = YES;
}

- (void)reloadData {
    if (!self.delegate || ![self.delegate respondsToSelector:@selector(numberOfPageInPageScrollView:)]) {
        return;
    }
    if (!self.dataSource || ![self.dataSource respondsToSelector:@selector(pageScrollView:dataForRowAtIndex:)]) {
        return;
    }
    
    // Default size
    _cellSize.width = self.frame.size.width - self.padding * 2 - 20 * 2;
    _cellSize.height = self.frame.size.height - 80;
    
    _numberOfCell = [self.delegate numberOfPageInPageScrollView:self];
    
    float startX = self.leftRightOffset;
    float topY   = 40;
    
    // Remove all old view
    [[self.scrollView subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    // Clean up
    self.viewsInPage = nil;
    self.viewsInPage = [NSMutableArray array];
    
    // pageCount
    NSInteger currentDataCount = self.viewsInPage.count;
    
    // Add cell
    for (int i = 0; i < _numberOfCell; i ++) {
        UIView *cell = nil;
        if (currentDataCount > i) cell = self.viewsInPage[i];
        else {
            cell = [UIView new];
            cell.frame = CGRectMake(startX, topY, _cellSize.width, _cellSize.height);
            [self.viewsInPage addObject:cell];
            
            // 将所有的centerx放到这个数组中  做位置的检测
            if (![self.viewsCenter containsObject:[NSNumber numberWithFloat:cell.center.x]]) {
                [self.viewsCenter addObject:[NSNumber numberWithFloat:cell.center.x]];
            }
        }
        
        UIColor *color = [self.dataSource pageScrollView:self dataForRowAtIndex:i];
        cell.backgroundColor = color;
        cell.layer.cornerRadius = 4;
        cell.layer.shadowColor = [[UIColor grayColor] CGColor];
        [self.scrollView addSubview:cell];
        startX += self.padding + _cellSize.width;
        
        if (i != 0) {
            CGPoint tempCenter = cell.center;
            cell.transform = CGAffineTransformScale(cell.transform, 0.95, 0.95);
            cell.center = tempCenter;
        }
    }
    
    // Add right padding
    float scrollViewSizeWith = startX - self.padding + (self.frame.size.width - _cellSize.width)/2;
    self.scrollView.contentSize = CGSizeMake(scrollViewSizeWith, 1);
}

- (UIView*)viewForRowAtIndex:(NSInteger)index {
    if (index < self.viewsInPage.count) {
        return self.viewsInPage[index];
    }
    return nil;
}

#pragma mark - Animation
- (void)scrollToPage:(NSUInteger)pageNumber animation:(BOOL)animation {
    float changeOffset = 0;
    if (pageNumber) {
        changeOffset = (_cellSize.width * pageNumber) + (self.padding*pageNumber);
        if (changeOffset >= self.scrollView.contentSize.width) {
        }
    }
    
    if (changeOffset == self.scrollView.contentOffset.x) {
        return;
    }
    
    if (animation) {
        [UIView animateWithDuration:0.2 animations:^{
            self.scrollView.contentOffset = CGPointMake(changeOffset, 0);
        }completion:^(BOOL finished) {
            if(self.delegate && [self.delegate respondsToSelector:@selector(pageScrollView:didScrollToPageAtIndex:)]) {
                [self.delegate pageScrollView:self didScrollToPageAtIndex:pageNumber];
            }
        }];
    } else {
        self.scrollView.contentOffset = CGPointMake(changeOffset, 0);
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(pageScrollView:didScrollToPageAtIndex:)]) {
            [self.delegate pageScrollView:self didScrollToPageAtIndex:pageNumber];
        }
    }
}

#pragma mark - Properties

- (NSMutableArray*)viewsInPage {
    if (!_viewsInPage) {
        _viewsInPage = [NSMutableArray array];
    }
    return _viewsInPage;
}

- (NSMutableArray *)viewsCenter {
    if (!_viewsCenter) {
        _viewsCenter = [NSMutableArray new];
    }
    return _viewsCenter;
}

- (void)setPadding:(CGFloat)padding {
    _padding = padding;
    [self reloadData];
}

- (UIScrollView*)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.multipleTouchEnabled = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (CGFloat)leftRightOffset {
    return (self.frame.size.width - _cellSize.width)/2;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _lastVelocityScrollView = CGPointMake(0, 0);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [scrollView setContentOffset:scrollView.contentOffset animated:NO];
    
    if (ABS(_lastVelocityScrollView.x) > 0.5) {
        // next
        if (_lastVelocityScrollView.x > 0.5) {
            if (_currentPageIndex + 1 < _numberOfCell) {
                _currentPageIndex += 1;
            }
        }
        // prev
        else {
            if (_currentPageIndex - 1 >= 0) {
                _currentPageIndex -= 1;
            }
        }
    }
    
    [self scrollToPage:self.currentPageIndex animation:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self updateCurrentPage];
        [self scrollToPage:self.currentPageIndex animation:YES];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    _lastVelocityScrollView = velocity;
}


#pragma mark -

- (void)updateCurrentPage {
    float leftRightPadding = self.leftRightOffset;
    // Find index page
    float leftCompare = leftRightPadding;
    int   currentIndexFinding = 0;
    
    if (self.scrollView.contentOffset.x <= leftRightPadding + _cellSize.width/2) {
        _currentPageIndex = 0;
    } else {
        currentIndexFinding ++;
        leftCompare += _cellSize.width + self.padding;
        for (int i = 1; i < _numberOfCell; i ++) {
            if (self.scrollView.contentOffset.x > leftCompare + _cellSize.width/2) {
                currentIndexFinding ++;
                leftCompare += _cellSize.width + self.padding;
            } else {
                break;
            }
        }
        _currentPageIndex = currentIndexFinding;
    }
}

@end
