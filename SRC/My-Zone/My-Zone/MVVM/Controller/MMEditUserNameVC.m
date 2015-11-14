//
//  MMEditUserNameVC.m
//  My-Zone
//
//  Created by chiery on 15/10/10.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMEditUserNameVC.h"
#import "MMPersonTableViewModel.h"

@interface MMEditUserNameVC ()
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
    // Dispose of any resources that can be recreated.
}
- (IBAction)editDone:(id)sender {
    
    UITextField *tf = (UITextField *)sender;
    self.userName.subTitle = tf.text;
    
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
