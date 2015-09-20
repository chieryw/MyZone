//
//  MMPhoneCheckVC.m
//  My-Zone
//
//  Created by chiery on 15/9/12.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#import "MMLoginVC.h"
#import "MMLoginVM.h"

@interface MMLoginVC ()

@property (nonatomic, strong) MMLoginVM *model;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UILabel *checkLabel;
@property (weak, nonatomic) IBOutlet UITextField *checkTF;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation MMLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 事件处理函数
- (IBAction)goNext:(id)sender {
}

- (IBAction)checkAction:(id)sender {
}

#pragma mark - 微调UI元素
- (void)configUI {

    _confirmButton.backgroundColor = [UIColor MMBlueColor];
    
}

#pragma mark - 初始化配置
- (MMLoginVM *)model {

    if (!_model) {
        _model = [[MMLoginVM alloc] init];
    }
    
    return _model;
    
}

- (UIButton *)confirmButton {

    return _confirmButton;
    
}

- (UITextField *)userNameTF {
    
    return _userNameTF;
    
}

@end
