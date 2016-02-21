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
#import <MobileCoreServices/UTCoreTypes.h>
#import "MMEditUserNameVC.h"
#import "MMEditUserSignVC.h"
#import "MMChooseBirthVC.h"
#import "MMRequestPostUploadImage.h"

typedef NS_ENUM(NSInteger, MMActionSheetType) {
    MMActionSheetTypeSexy,
    MMActionSheetTypePhoto,
};

@interface MMPersonVC ()<UITableViewDataSource,UITableViewDelegate,MMAddImageCellDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
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
    
    // 将对应的返回事件  转变到dismissNavigationController事件
    [self overrideBack];
}

#pragma mark - UIViewController LifeStyle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - 事件处理函数
- (void)editUserName {
    [self performSegueWithIdentifier:@"editUserNameSegue" sender:@"editName"];
}

- (void)chooseSexy {
    [UIActionSheet showInView:self.view
                        title:nil
                     delegate:self
            cancelButtonTitle:@"取消"
       destructiveButtonTitle:nil
                          tag:MMActionSheetTypeSexy
            otherButtonTitles:@[@"男",@"女"]];
}

- (void)chooseBirthday {
    [self performSegueWithIdentifier:@"chooseBirthSegue" sender:@"chooseBirth"];
}

- (void)editSign {
    [self performSegueWithIdentifier:@"editSignSegue" sender:@"editSign"];
}

- (void)takePhoto {
    [self pickerControllerWithType:UIImagePickerControllerSourceTypeCamera];
}

- (void)choosePhoto {
    [self pickerControllerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)dismissNavigationController:(UIBarButtonItem *)item {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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

- (void)overrideBack {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavigationBackImage"]
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(dismissNavigationController:)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)pickerControllerWithType:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = type;
    [self presentViewController:imagePicker animated:YES completion:nil];
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
    
    // 添加代理
    if ([cell isKindOfClass:[MMAddImageTableViewCell class]]) {
        [(MMAddImageTableViewCell *)cell setDelegate:self];
    }
    
    return cell;
    
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        // 不做处理
    }
    else if (indexPath.row == 1) {
        [self editUserName];
    }
    else if (indexPath.row == 2) {
        [self chooseSexy];
    }
    else if (indexPath.row == 3) {
        [self chooseBirthday];
    }
    else if (indexPath.row == 4) {
        [self editSign];
    }
    else if (indexPath.row == 5) {
        [UIAlertView tipTitle:@"该功能暂不支持！" buttonName:@"确定"];
    }
    
}

#pragma mark - MMAddImageCellDelegate
- (void)addImage:(UIImageView *)imageView {
    
    [UIActionSheet showInView:self.view
                        title:nil
                     delegate:self
            cancelButtonTitle:@"取消"
       destructiveButtonTitle:nil
                          tag:MMActionSheetTypePhoto
            otherButtonTitles:@[@"拍照",@"从相册中选择"]];
}

#pragma mark - UIActionSheetDelegate 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (actionSheet.tag) {
        case MMActionSheetTypeSexy:
        {
            if (buttonIndex == 1) {
                self.tableViewModel.userSexyCellModel.subTitle = @"男";
            }
            else if (buttonIndex == 2) {
                self.tableViewModel.userSexyCellModel.subTitle = @"女";
            }
            
        }
            break;
        case MMActionSheetTypePhoto:
        {
            if (buttonIndex == 1) {
                [self takePhoto];
            }
            else if (buttonIndex == 2) {
                [self choosePhoto];
            }
        }
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
}

#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        // 这里的操作交个Model
        [self.tableViewModel performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSString *tag = (NSString *)sender;
    if ([tag isEqualToString:@"editSign"]) {
        MMEditUserSignVC *vc = (MMEditUserSignVC *)segue.destinationViewController;
        vc.userSignModel= self.tableViewModel.userSignCellModel;
    }
    else if ([tag isEqualToString:@"editName"]) {
        MMEditUserNameVC *vc = (MMEditUserNameVC *)segue.destinationViewController;
        vc.userName = self.tableViewModel.userNameCellModel;
    }
    else if ([tag isEqualToString:@"chooseBirth"]) {
        MMChooseBirthVC *vc = (MMChooseBirthVC *)segue.destinationViewController;
        vc.userBirth = self.tableViewModel.userBirthdayCellModel;
    }
    
}


@end
