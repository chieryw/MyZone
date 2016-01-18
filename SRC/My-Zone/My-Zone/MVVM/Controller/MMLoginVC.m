//
//  MMPhoneCheckVC.m
//  My-Zone
//
//  Created by chiery on 15/9/12.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#import "MMLoginVC.h"
#import "MMLoginVM.h"
#import "MMEnterVC.h"
#import "MMNetworkTask.h"
#import "MMNetworkDelgt.h"
#import "MMSearchNetDelgt.h"
#import "MMLoginResult.h"

@interface MMLoginVC ()<UITextFieldDelegate,MMNetworkPtc>

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

- (void)dealloc {

    self.userNameTF.delegate = nil;
    self.passwordTF.delegate = nil;
    self.checkTF.delegate = nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configSelf];

}

- (void)configSelf {
    // 为UI配置统一的元素
    [self configUI];
    
    // 添加对应元素的代理
    [self addDelegate];
    
    // 观测信号源
    [self setupRACSignal];
}

#pragma mark - 事件处理函数
- (IBAction)goNext:(id)sender {
    
    if ([self checkUserNameAndPassword]) {
        
        if (self.model.enterType == MMEnterTypeLogin) {
            
            // 现在不做处理
        }
        else {
            NSDictionary *tempDict = @{
            @"mobileNum":@"1881111888",
            @"password":@"342343423"
            };
            
            NSData *data = [NSJSONSerialization dataWithJSONObject:tempDict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];
            
            NSString *tempString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            MMSearchNetDelgt *delegate = [[MMSearchNetDelgt alloc] init];
            [delegate setSearchResult:[MMLoginResult new]];
            [delegate setDelegate:self];
            
            BOOL network = [MMNetworkTask postSearch:@"/tour/logon.htm"
                                            forParam:tempString
                                              forRes:YES
                                           withDelgt:delegate];
            
//            [self performSegueWithIdentifier:@"nextSegue" sender:sender];
        }
    
    }
    
}

- (IBAction)valideAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}


- (IBAction)changeEnterType:(id)sender {
    if (self.model.enterType == MMEnterTypeLogin) {
        self.model.enterType = MMEnterTypeRegister;
    }
    else {
        self.model.enterType = MMEnterTypeLogin;
    }
    
    // 切换Type时 重置数据
    [self reloadData];
}

#pragma mark - 微调UI元素
- (void)configUI {

    // 统一颜色设置
    self.confirmButton.backgroundColor = [UIColor MMBlueColor];
}

- (void)addDelegate {

    self.userNameTF.delegate = self;
    self.passwordTF.delegate = self;
    self.checkTF.delegate = self;
    
}

#pragma mark - networkBack
- (void)getFetchNetBack:(NSDictionary *)jsonDictionary forInfo:(id)customInfo {
    NSLog(@"%@",jsonDictionary);
}

- (void)getSearchNetBack:(MMLoginResult *)searchResult forInfo:(id)customInfo {
    NSLog(@"%@",searchResult);
}

#pragma mark - 初始化配置
- (MMLoginVM *)model {

    if (!_model) {
        _model = [[MMLoginVM alloc] init];
    }
    
    return _model;
}

- (void)reloadData {

    self.userNameTF.text = @"";
    self.passwordTF.text = @"";
    self.checkTF.text = @"";
    self.model.userName = @"";
    self.model.password = @"";
    self.model.checkString = @"";
    
}

#pragma mark - 绑定数据
- (void)setupRACSignal {

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

#pragma mark - 辅助函数
- (BOOL)checkUserNameAndPassword {

    if (self.model.userName.length != 11) {
        [UIAlertView tipTitle:@"手机号码不足11位" buttonName:@"确定"];
        return NO;
    }
    
    if (self.model.password.length != 4) {
        [UIAlertView tipTitle:@"用户密码不足4位" buttonName:@"确定"];
        return NO;
    }
    
    return YES;
    
}

#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:self.userNameTF]) {
        if (textField.text.length + string.length >11) {
            return NO;
        }
    }
    
    if ([textField isEqual:self.passwordTF]) {
        if (textField.text.length + string.length > 4) {
            return NO;
        }
    }
    
    return YES;
}

@end
