//
//  MMPageScrollView.h
//  TestScrollView
//
//  Created by chiery on 16/1/19.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMPageScrollView;
@protocol MMPageScrollViewDelegate <NSObject>

@required
/**
 *  当前单元格的个数
 *
 *  @param pageScrollView 当前的滚动视图
 *
 *  @return 子Item个数
 */
- (NSInteger)numberOfPageInPageScrollView:(MMPageScrollView*)pageScrollView;

@optional

/**
 *  相应点击事件
 *
 *  @param pageScrollView 当前滚动视图
 *  @param index          被选中的Item
 */
- (void)pageScrollView:(MMPageScrollView*)pageScrollView didScrollToPageAtIndex:(NSInteger)index;
@end

@protocol MMPageScrollViewDataSource <NSObject>

@required

/**
 *  数据源
 *
 *  @param pageScrollView 当前滚动视图
 *  @param index          当前Item
 *
 *  @return 数据源
 */
- (UIColor *)pageScrollView:(MMPageScrollView*)pageScrollView dataForRowAtIndex:(NSInteger)index;
@end

@interface MMPageScrollView : UIView

@property (nonatomic)           CGFloat   padding;
@property (nonatomic, weak) id<MMPageScrollViewDataSource> dataSource;
@property (nonatomic, weak) id<MMPageScrollViewDelegate> delegate;

//! 刷新界面
- (void)reloadData;

@end
