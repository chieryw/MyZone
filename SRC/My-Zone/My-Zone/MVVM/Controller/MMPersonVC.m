//
//  MMPersonVC.m
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMPersonVC.h"
#import "MMPersonTableViewModel.h"
#import "MMTableViewCellProtocol.h"
#import "MMAddImageTableViewCell.h"
#import "MMPersonMessageTVC.h"

@interface MMPersonVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MMPersonTableViewModel *tableViewModel;
@property (nonatomic, strong) NSArray *tableDataSource;

@end

@implementation MMPersonVC

- (void)dealloc {
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人资料";
    
    self.navigationController.navigationBarHidden = NO;
    
    [self configTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 辅助函数
- (void)configTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self registerTableViewClass];
}

// 注册所有的tableCell
- (void)registerTableViewClass {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MMAddImageTableViewCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"MMAddImageTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMPersonMessageTVC" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"MMPersonMessageTVC"];
}

#pragma mark - init
- (MMPersonTableViewModel *)tableViewModel {
    if (!_tableViewModel) {
        _tableViewModel = [[MMPersonTableViewModel alloc] init];
    }
    return _tableViewModel;
}

- (NSArray *)tableDataSource {
    if (!_tableDataSource) {
        _tableDataSource = @[
                             self.tableViewModel.addImageCellModel,
                             self.tableViewModel.userNameCellModel,
                             self.tableViewModel.userSexyCellModel,
                             self.tableViewModel.userBirthdayCellModel,
                             self.tableViewModel.userSignCellModel,
                             self.tableViewModel.userGradeCellModel
                             ];
    }
    return _tableDataSource;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 0;
    
    id object = self.tableDataSource[indexPath.row];
    if ([object isKindOfClass:[MMAddImageCellModel class]]) {
       height = [MMAddImageTableViewCell cellHeightWithData:nil];
    }
    else {
       height = [MMPersonMessageTVC cellHeightWithData:nil];
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id object = self.tableDataSource[indexPath.row];
    NSString *identifierCell = @"";
    if ([object isKindOfClass:[MMAddImageCellModel class]]) {
        identifierCell = NSStringFromClass([MMAddImageTableViewCell class]);
    }
    else {
        identifierCell = NSStringFromClass([MMPersonMessageTVC class]);
    }
    
    UITableViewCell<MMTableViewCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    [cell configCellWithData:self.tableDataSource[indexPath.row]];
    return cell;
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
