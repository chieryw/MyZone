//
//  MMEditUserSignVC.m
//  My-Zone
//
//  Created by chiery on 15/10/10.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMEditUserSignVC.h"
#import "MMPersonTableViewModel.h"
#import "MMSimpleResult.h"

@interface MMEditUserSignVC ()<MMNetworkPtc>
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
    
}

- (IBAction)commitSign:(id)sender {
    if ([self.signTF.text isStringSafe]) {
        NSString *humanDI = [[NSUserDefaults standardUserDefaults] objectForKey:MMUserID];
        
        NSMutableDictionary *paraDict = [NSMutableDictionary new];
        [paraDict setObjectSafe:humanDI forKey:@"humanID"];
        [paraDict setObjectSafe:self.signTF.text forKey:@"signName"];
        
        BOOL networkState = [MMNetServies postUrl:@"/tour/humaninfo.htm?action=signName"
                                  resultContainer:[MMSimpleResult new]
                                         paraDict:[paraDict copy]
                                         delegate:self customInfo:nil];
        if (networkState) [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        else [UIAlertView networkError];
    }
    else {
        [UIAlertView tipMessage:@"签名不能为空"];
    }
}

- (void)getSearchNetBack:(MMSimpleResult *)searchResult forInfo:(id)customInfo {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSNumber *networkState = searchResult.resultInfo.success;
    if ([networkState boolValue]) {
        self.userSignModel.subTitle = self.signTF.text;
    }
    [UIAlertView tipMessage:searchResult.resultInfo.message];
    
}


@end
