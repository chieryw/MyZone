//
//  MMEditUserSignVC.m
//  My-Zone
//
//  Created by chiery on 15/10/10.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMEditUserSignVC.h"
#import "MMPersonTableViewModel.h"

@interface MMEditUserSignVC ()
@property (weak, nonatomic) IBOutlet UITextField *signTF;

@end

@implementation MMEditUserSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.userSignModel.subTitle.length > 0) {
        self.signTF.text = self.userSignModel.subTitle;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editDone:(id)sender {
    
    UITextField *tf = (UITextField *)sender;
    self.userSignModel.subTitle = tf.text;
    
}


@end
