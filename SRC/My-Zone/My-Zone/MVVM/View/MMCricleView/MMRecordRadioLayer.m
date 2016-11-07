//
//  MMRecordRadioLayer.m
//  My-Zone
//
//  Created by chiery on 2016/11/7.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

//  只是简单的使用animation，没有对instanceCount做复制，这里的层都是当前可操控的层。


#import "MMRecordRadioLayer.h"

static const CGFloat animationDuration = 3;
static const CGFloat animationRepeatCount = 1;
static NSString * const animationKey = @"pulse";

@interface MMRecordRadioLayer ()
@property (nonatomic, strong) CALayer *effect;
@property (nonatomic, strong) CAAnimationGroup *animationGroup;
@end


@implementation MMRecordRadioLayer

- (void)dealloc {
    if (self.effect && self.animationGroup) {
        [self.effect removeAnimationForKey:animationKey];
    }
    
    if (self.effect) {
        [self.effect removeFromSuperlayer];
        self.effect = nil;
    }
    
    if (self.animationGroup) {
        self.animationGroup = nil;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {
    [self addSublayer:self.effect];
    self.backgroundColor = [[UIColor clearColor] CGColor];
}

#pragma mark - Public
- (void)setVolume:(CGFloat)volume {
    _volume = volume;
    
    self.effect.frame = CGRectMake(CGRectGetWidth(self.bounds) * (1-volume) / 2, CGRectGetHeight(self.bounds) * (1-volume) / 2, CGRectGetWidth(self.bounds) * volume, CGRectGetHeight(self.bounds) * volume);
    self.effect.cornerRadius = CGRectGetWidth(self.bounds) * volume / 2;
}

- (void)startAnimation {
    if (self.animationGroup && self.effect) {
        [self.effect addAnimation:self.animationGroup forKey:animationKey];
    }
}

- (void)stopAnimation {
    if (self.animationGroup && self.effect) {
        [self.effect removeAnimationForKey:animationKey];
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.effect.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    self.effect.cornerRadius = CGRectGetWidth(frame) / 2;
}

#pragma mark - Property
- (CALayer *)effect {
    if (!_effect) {
        _effect = [CALayer layer];
        _effect.frame = self.bounds;
        _effect.opacity = 0;
        _effect.backgroundColor = [[UIColor clearColor] CGColor];
        _effect.borderWidth = 1;
        _effect.borderColor = [[UIColor redColor] CGColor];
    }
    return _effect;
}

- (CAAnimationGroup *)animationGroup {
    if (!_animationGroup) {
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = animationRepeatCount;
        
        // 为了能在外围展示较长的时间，设置时间函数为
        CAMediaTimingFunction *timeFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        animationGroup.timingFunction = timeFunction;
        
        // scale changing
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
        scaleAnimation.fromValue = @(0.0);
        scaleAnimation.toValue = @1.0;
        scaleAnimation.duration = animationDuration;
        
        // opacity changing
        CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.duration = animationDuration;
        opacityAnimation.values = @[@0, @0.2, @1];
        opacityAnimation.keyTimes = @[@0, @(0.5), @1];
        
        NSArray *animations = @[scaleAnimation,opacityAnimation];
        animationGroup.animations = animations;
        _animationGroup = animationGroup;
    }
    return _animationGroup;
}

@end
