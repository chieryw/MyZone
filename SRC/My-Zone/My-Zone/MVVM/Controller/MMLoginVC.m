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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *enterBarButtonItem;

@end

@implementation MMLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 为UI配置统一的元素
    [self configUI];
    
    // 绑定界面
    [self bindModel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 事件处理函数
- (IBAction)goNext:(id)sender {
    
}

- (IBAction)checkAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
    }
    else {
        sender.selected = YES;
    }
}

- (IBAction)changeEnterType:(id)sender {
    if (self.model.enterType == MMEnterTypeLogin) {
        self.model.enterType = MMEnterTypeRegister;
    }
    else {
        self.model.enterType = MMEnterTypeLogin;
    }
}

#pragma mark - 微调UI元素
- (void)configUI {

    // 统一颜色设置
    self.confirmButton.backgroundColor = [UIColor MMBlueColor];
    
    // 设置是否需要验证码的按钮的风格
    [self.checkButton setImage:nil forState:UIControlStateNormal];
    [self.checkButton setImage:[UIImage imageNamed:@"BackImage1"] forState:UIControlStateSelected];
    
}

#pragma mark - 初始化配置
- (MMLoginVM *)model {

    if (!_model) {
        _model = [[MMLoginVM alloc] init];
    }
    
    return _model;
    
}

#pragma mark - 绑定数据
- (void)bindModel {

    RAC(self.model, userName) = self.userNameTF.rac_textSignal;
    
    RAC(self.model, password) = self.passwordTF.rac_textSignal;
    
    RAC(self.model, checkString) = self.checkTF.rac_textSignal;
    
    RAC(self.model, checkSelected) = RACObserve(self.checkButton, selected);
    
    @weakify(self);
    [RACObserve(self.model, enterType) subscribeNext:^(id x) {
        @strongify(self);
        if ([(NSNumber *)x integerValue] == MMEnterTypeLogin) {
            self.checkTF.hidden = YES;
            self.checkButton.hidden = YES;
            self.checkLabel.hidden = YES;
            self.enterBarButtonItem.title = @"我没账号";
            self.title = @"登录";
            [self.confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        }
        else {
            self.checkTF.hidden = NO;
            self.checkButton.hidden = NO;
            self.checkLabel.hidden = NO;
            self.enterBarButtonItem.title = @"我有账号";
            self.title = @"注册";
            [self.confirmButton setTitle:@"下一步" forState:UIControlStateNormal];
        }
    }];
    
}

@end
