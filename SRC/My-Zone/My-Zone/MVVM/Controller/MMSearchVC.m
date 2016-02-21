//
//  MMSearchVC.m
//  My-Zone
//
//  Created by chiery on 15/10/19.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMSearchVC.h"
#import "MMPageScrollView.h"
#import "MJRefresh.h"

@interface MMSearchVC ()<MMPageScrollViewDataSource,MMPageScrollViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) MMPageScrollView *pageScrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editSortBarButton;
@end

@implementation MMSearchVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.array = @[
                   [UIColor redColor],
                   [UIColor orangeColor],
                   [UIColor blueColor],
                   [UIColor purpleColor],
                   [UIColor yellowColor]
                   ];
    
    self.pageScrollView = [[MMPageScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTabBarHeight)];
    self.pageScrollView.delegate = self;
    self.pageScrollView.dataSource = self;
    [self.pageScrollView setPadding:20];
    [self.pageScrollView reloadData];
    
    [self.view addSubview:self.pageScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - 事件处理
- (IBAction)editSortType:(id)sender {
    [UIActionSheet showInView:self.view
                        title:@"选择当前展示类型"
                     delegate:self
            cancelButtonTitle:@"取消"
       destructiveButtonTitle:nil
                          tag:10
            otherButtonTitles:@[@"随机",@"最新",@"最赞"]];
}


#pragma mark -

- (NSInteger)numberOfPageInPageScrollView:(MMPageScrollView*)pageScrollView
{
    return self.array.count;
}

- (UIColor *)pageScrollView:(MMPageScrollView*)pageScrollView dataForRowAtIndex:(NSInteger)index
{
    return self.array[index];
}

- (void)pageScrollView:(MMPageScrollView*)pageScrollView didScrollToPageAtIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
        [self.editSortBarButton setTitle:buttonTitle];
        
        // 做接下来的处理
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
