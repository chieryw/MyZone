//
//  MMBaseViewController.m
//  My-Zone
//
//  Created by chiery on 15/9/13.
//  Copyright (c) 2015年 My-Zone. All rights reserved.
//

#import "MMBaseViewController.h"
#import "MMNetworkController.h"

@interface MMBaseViewController ()

@end

@implementation MMBaseViewController

- (void)dealloc {
    // 删除当前ViewController中的请求
    [[MMNetworkController getInstance] removeConnectionsByRequest:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 初始化对应的NavigationBackBar的返回图
    [self initSelf];
    
}

- (void)initSelf {

    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavigationBackImage"]
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self.navigationController
                                                                    action:@selector(popViewControllerAnimated:)];
        
        self.navigationItem.leftBarButtonItem = backItem;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
