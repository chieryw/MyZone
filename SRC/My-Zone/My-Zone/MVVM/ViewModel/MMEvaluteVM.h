//
//  MMEvaluteVM.h
//  My-Zone
//
//  Created by chiery on 16/3/5.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMEvaluteVM : NSObject

@property (nonatomic, assign) BOOL showLoading;

/**
 *  提交当前评价
 *
 *  @param guideID 当前被评价对象的ID
 *  @param evalute 给出的评分
 *  @param isGood  是否来自点赞
 */
- (void)submmitWithGuideId:(NSString *)guideID andEvalute:(NSString *)evalute andType:(BOOL)isGood;

@end
