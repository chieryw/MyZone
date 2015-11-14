//
//  MMFriendsZoneVC.m
//  My-Zone
//
//  Created by chiery on 15/11/12.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMFriendsZoneVC.h"
#import "MMFriendsCell.h"

@interface MMFriendsZoneVC () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MMFriendsZoneVC

- (void)dealloc {
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubview];
    [self setupSubview];
}

- (void)initSubview {

}

- (void)setupSubview {
    [self registerTableViewCell];
}

- (void)registerTableViewCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"MMFriendsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MMFriendsCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 327;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MMFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMFriendsCell"];
    return cell;
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
