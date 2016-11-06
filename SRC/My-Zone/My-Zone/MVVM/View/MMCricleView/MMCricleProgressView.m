//
//  MMCricleProgressView.m
//  TestPlay
//
//  Created by QITMAC000441 on 2016/11/7.
//  Copyright © 2016年 QITMAC000441. All rights reserved.
//

#import "MMCricleProgressView.h"

static const CGFloat spacing = 20;
static const CGFloat dashLineWidth = 1.2f;
static const CGFloat dashLineSpacing = 3.0f;
static const CGFloat grayLineWidth = 8.0f;
static const CGFloat progressLineWidth = 6.0f;
static const CGFloat colorLineWidth = 2.0f;

@interface MMCricleProgressView ()

@property (nonatomic, strong) CAShapeLayer *darkDashLayer;
@property (nonatomic, strong) CAShapeLayer *colorDashLayer;
@property (nonatomic, strong) CAShapeLayer *grayLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation MMCricleProgressView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSelf];
        [self layoutViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf];
        [self layoutViews];
    }
    return self;
}

- (void)initSelf {
    self.layer.backgroundColor = [[UIColor clearColor] CGColor];
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutViews {
    [self.layer addSublayer:self.grayLayer];
    [self.grayLayer addSublayer:self.progressLayer];
    [self.layer addSublayer:self.darkDashLayer];
    [self.darkDashLayer addSublayer:self.colorDashLayer];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height)/2 - spacing;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:- M_PI_2 endAngle: (M_PI * 2)- M_PI_2 clockwise:YES];
    
    CGFloat bigRadius = radius + 8;
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithArcCenter:center radius:bigRadius startAngle:- M_PI_2 endAngle: (M_PI * 2)- M_PI_2 clockwise:YES];
    
    self.colorDashLayer.path = path.CGPath;
    self.darkDashLayer.path = path.CGPath;
    
    self.grayLayer.path = bigPath.CGPath;
    self.progressLayer.path = bigPath.CGPath;
    
    [self createGradientLayer];
}


- (void)createGradientLayer {
    CALayer *gradientLayer = [CALayer layer];
    
    // 左侧渐变
    CAGradientLayer *leftGradientLayer = [CAGradientLayer layer];
    leftGradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds));
    leftGradientLayer.locations = @[@0.3,@0.9,@1.0];
    leftGradientLayer.colors = @[(id)[[UIColor redColor] CGColor], (id)[[UIColor yellowColor] CGColor]];
    [gradientLayer addSublayer:leftGradientLayer];
    
    // 右侧渐变
    CAGradientLayer *rightGradientLayer = [CAGradientLayer layer];
    rightGradientLayer.frame = CGRectMake(CGRectGetWidth(self.bounds)/2, 0, CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds));
    rightGradientLayer.locations = @[@0.3,@0.9,@1.0];
    rightGradientLayer.colors = @[(id)[[UIColor greenColor] CGColor], (id)[[UIColor yellowColor] CGColor]];
    [gradientLayer addSublayer:rightGradientLayer];
    
    gradientLayer.mask = self.colorDashLayer;
    [self.layer addSublayer:gradientLayer];
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    self.colorDashLayer.strokeEnd = progress;
    self.progressLayer.strokeEnd = progress;
}

#pragma mark - Property init

- (CAShapeLayer *)grayLayer {
    if (!_grayLayer) {
        _grayLayer = [CAShapeLayer layer];
        _grayLayer.lineWidth = grayLineWidth;
        _grayLayer.strokeColor = [[UIColor grayColor] CGColor];
        _grayLayer.fillColor = [[UIColor clearColor] CGColor];
    }
    return _grayLayer;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.lineWidth = progressLineWidth;
        _progressLayer.strokeColor = [[UIColor orangeColor] CGColor];
        _progressLayer.fillColor = [[UIColor clearColor] CGColor];
        _progressLayer.lineJoin = kCALineJoinRound;
    }
    return _progressLayer;
}

- (CAShapeLayer *)darkDashLayer {
    if (!_darkDashLayer) {
        _darkDashLayer = [CAShapeLayer layer];
        _darkDashLayer.lineWidth = dashLineWidth;
        _darkDashLayer.strokeColor = [[UIColor grayColor] CGColor];
        _darkDashLayer.fillColor = [[UIColor clearColor] CGColor];
        _darkDashLayer.lineCap = kCALineCapRound;
        _darkDashLayer.lineJoin = kCALineJoinRound;
        _darkDashLayer.lineDashPhase = 10;
        _darkDashLayer.lineDashPattern = @[@(dashLineWidth),@(dashLineSpacing)];
    }
    return _darkDashLayer;
}

- (CAShapeLayer *)colorDashLayer {
    if (!_colorDashLayer) {
        _colorDashLayer = [CAShapeLayer layer];
        _colorDashLayer.lineWidth = colorLineWidth;
        _colorDashLayer.strokeColor = [[UIColor grayColor] CGColor];
        _colorDashLayer.fillColor = [[UIColor clearColor] CGColor];
        _colorDashLayer.lineCap = kCALineCapRound;
        _colorDashLayer.lineJoin = kCALineJoinRound;
        _colorDashLayer.lineDashPhase = 10;
        _colorDashLayer.lineDashPattern = @[@(dashLineWidth),@(dashLineSpacing)];
    }
    return _colorDashLayer;
}

@end
