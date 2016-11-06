//
//  MMTestImageSelectVC.m
//  My-Zone
//
//  Created by chiery on 2016/10/24.
//  Copyright © 2016年 My-Zone. All rights reserved.
//

#import "MMTestImageSelectVC.h"
#import "MMWebImageExampleVC.h"
#import "MMRequestPostUploadImage.h"

@interface MMTestImageSelectVC ()

@end

@implementation MMTestImageSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)jumpWebImageVC:(id)sender {
    MMWebImageExampleVC *vc = [MMWebImageExampleVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)uploadImage:(id)sender {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"mew_baseline" ofType:@"jpg"];
    [MMRequestPostUploadImage postRequestWithURL:@"/upload/image"
                                      postParems:nil
                                     picFilePath:imagePath
                                     picFileName:@"mew_baseline"
                                          result:^(NSError *error, NSDictionary *info) {
                                              NSLog(@"上传信息的info=======");
                                              NSLog(@"info");
                                              NSLog(@"是否出现错误========");
                                              NSLog(@"%@",error);
                                          }];
    
}

- (IBAction)downloadImage:(id)sender {
    // 图片下载的操作在网络图片加载中执行
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
