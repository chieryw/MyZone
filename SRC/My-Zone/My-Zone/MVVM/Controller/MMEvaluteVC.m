//
//  MMEvaluteVC.m
//  My-Zone
//
//  Created by chiery on 15/11/7.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMEvaluteVC.h"
#import "MMEvaluteVM.h"
#import "MMFriendsInfoResult.h"

@interface MMEvaluteVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userDescription;
@property (weak, nonatomic) IBOutlet UIImageView *currentMarkImage;
@property (weak, nonatomic) IBOutlet UITextField *evaluteTextField;
@property (nonatomic, strong) MMEvaluteVM *model;
@end

@implementation MMEvaluteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigationTitle];
    [self configSubview];
    
    //  管理键盘
    [self managerKeyboard];
}

- (void)configNavigationTitle {
    if (self.isGood) self.title = @"赞";
    else self.title = @"踩";
}

- (void)configSubview {
    self.userHeaderImageView.image = [UIImage imageNamed:@""];
    self.userName.text = self.currentUserInfo.humanName;
    self.userDescription.text = [NSString stringWithFormat:@"达人导游，%@",self.currentUserInfo.age];
    self.currentMarkImage.image = self.isGood?[UIImage imageNamed:@"GoodEvaluteBig"]:[UIImage imageNamed:@"BadEvaluteBig"];
}

- (void)bindRAC {
    @weakify(self)
    [RACObserve(self.model, showLoading) subscribeNext:^(id x) {
        @strongify(self)
        [self updateLoading];
    }];
}

- (void)managerKeyboard {
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(currentViewEndEdit:)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)currentViewEndEdit:(UITapGestureRecognizer *)gesture {
    if ([gesture.view isKindOfClass:[UITextField class]]) {
        return;
    }
    [self.view endEditing:YES];
}


- (void)updateLoading {
    if (self.model.showLoading) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)submmit:(id)sender {
    [self.model submmitWithGuideId:self.currentUserInfo.humanID andEvalute:self.evaluteTextField.text andType:self.isGood];
}


#pragma mark - Property
- (MMEvaluteVM *)model {
    if (!_model) {
        _model = [MMEvaluteVM new];
    }
    return _model;
}

@end
