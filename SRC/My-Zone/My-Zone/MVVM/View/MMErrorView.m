//
//  MMErrorView.m
//  My-Zone
//
//  Created by chiery on 16/3/1.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMErrorView.h"

@interface MMErrorView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *pressedButton;
@end

@implementation MMErrorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {
    [self addSubviews];
    [self layoutSubview];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)addSubviews {
    [self addSubview:self.imageView];
    [self addSubview:self.messageLabel];
    [self addSubview:self.pressedButton];
}

- (void)layoutSubview {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.height.equalTo(@80);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.left.equalTo(self).offset(40);
        make.right.equalTo(self).offset(-40);
        make.height.lessThanOrEqualTo(@(60));
    }];
    [self.pressedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).offset(8);
        make.centerX.equalTo(self);
        make.height.equalTo(@(40));
        make.width.equalTo(@(80));
    }];
}

#pragma mark 
- (void)updateMessage:(NSString *)message buttonTitle:(NSString *)buttonTitle {
    self.messageLabel.text = message;
    [self.pressedButton setTitle:buttonTitle forState:UIControlStateNormal];
}

#pragma mark - Actions
- (void)retryNetwork {
    if (self.delegate && [self.delegate respondsToSelector:@selector(errorViewButtonPressed)]) {
        [self.delegate errorViewButtonPressed];
    }
}

#pragma mark - Property
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"Wifi"];
    }
    return _imageView;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.font = [UIFont MMTextFont14];
        _messageLabel.textColor = [UIColor MMTextTipColor];
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.text = @"网络错误，请稍后重试！";
    }
    return _messageLabel;
}

- (UIButton *)pressedButton {
    if (!_pressedButton) {
        _pressedButton = [UIButton new];
        [_pressedButton setTitle:@"重试" forState:UIControlStateNormal];
        [_pressedButton setTitleColor:[UIColor MMBlueColor] forState:UIControlStateNormal];
        [_pressedButton.titleLabel setFont:[UIFont MMTextFont16]];
        [_pressedButton addTarget:self action:@selector(retryNetwork) forControlEvents:UIControlEventTouchUpInside];
        _pressedButton.layer.cornerRadius = 4;
        _pressedButton.layer.borderWidth = kScaleInApp;
        _pressedButton.layer.borderColor = [[UIColor MMBlueColor] CGColor];
    }
    return _pressedButton;
}

@end

