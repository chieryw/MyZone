//
//  MMSettingVC.m
//  My-Zone
//
//  Created by chiery on 15/11/9.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMSettingVC.h"

@interface MMSettingVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tableViewDataTree;
@end

@implementation MMSettingVC
- (void)dealloc {
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initSubview];
    [self setupSubview];
}

- (void)initData {
    self.tableViewDataTree = @[
                               @"MMPasswordCell",
                               @"MMRemoveCacheCell"
                               ];
}

- (void)initSubview {

}

- (void)setupSubview {
    self.title = @"设置";
    self.tableView.tableFooterView = [UIView new];
    [self registerTableViewCell];
}

- (void)registerTableViewCell {
    for (NSString *cellIdentifier in self.tableViewDataTree) {
        [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = self.tableViewDataTree[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self performSegueWithIdentifier:@"ResetPasswordVC" sender:nil];
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
