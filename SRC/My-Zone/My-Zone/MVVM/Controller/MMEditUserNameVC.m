//
//  MMEditUserNameVC.m
//  My-Zone
//
//  Created by chiery on 15/10/10.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMEditUserNameVC.h"
#import "MMPersonTableViewModel.h"
#import "MMEditPersonResult.h"

@interface MMEditUserNameVC ()<MMNetworkPtc>
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;

@end

@implementation MMEditUserNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.userName.subTitle.length > 0) {
        self.userNameTF.text = self.userName.subTitle;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)editDone:(id)sender {
    
//    UITextField *tf = (UITextField *)sender;
//    self.userName.subTitle = tf.text;
    
}
- (IBAction)commitUserName:(id)sender {
    if ([self.userNameTF.text isStringSafe]) {
        NSString *humanDI = [[NSUserDefaults standardUserDefaults] objectForKey:MMUserID];
        
        NSMutableDictionary *paraDict = [NSMutableDictionary new];
        [paraDict setObjectSafe:humanDI forKey:@"humanID"];
        [paraDict setObjectSafe:self.userNameTF.text forKey:@"humanName"];
        
        BOOL networkState = [MMNetServies postUrl:@"sys/humaninfo.htm?action=humanName"
                                  resultContainer:[MMEditPersonResult new]
                                         paraDict:[paraDict copy]
                                         delegate:self customInfo:nil];
        if (networkState) [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        else [UIAlertView networkError];
    }
    else {
        [UIAlertView tipMessage:@"用户名不能为空"];
    }
}

- (void)getSearchNetBack:(MMEditPersonResult *)searchResult forInfo:(id)customInfo {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSString *networkState = searchResult.resultInfo.success;
    if ([networkState isEqualToString:@"true"]) {
        self.userName.subTitle = self.userNameTF.text;
    }
    [UIAlertView tipMessage:searchResult.resultInfo.message];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
