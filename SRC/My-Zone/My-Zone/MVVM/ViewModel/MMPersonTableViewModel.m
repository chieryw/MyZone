//
//  MMPersonTableViewModel.m
//  My-Zone
//
//  Created by chiery on 15/9/28.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMPersonTableViewModel.h"

@implementation MMAddImageCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {
    self.images = [@[
                     @"EmptPhoto",
                     @"AddPhoto",
                     @"AddPhoto",
                     @"AddPhoto",
                     @"AddPhoto",
                     @"AddPhoto"
                     ] mutableCopy];
}

@end

@implementation MMPersonMessageCellModel


@end

@interface MMPersonTableViewModel ()

@property (nonatomic, strong) NSMutableArray *cellConfigArray;

@end

@implementation MMPersonTableViewModel

- (void)saveImage:(UIImage *)image {
    
    // 添加相应的图片到对应的文件夹中
    
    
}

- (MMAddImageCellModel *)addImageCellModel {
    if (!_addImageCellModel) {
        _addImageCellModel = [[MMAddImageCellModel alloc] init];
    }
    return _addImageCellModel;
}

- (MMPersonMessageCellModel *)userNameCellModel {
    if (!_userNameCellModel) {
        _userNameCellModel = [[MMPersonMessageCellModel alloc] init];
        _userNameCellModel.icon = @"Name";
        _userNameCellModel.title = @"姓名";
        _userNameCellModel.subTitle = @"请输入您的姓名";
    }
    return _userNameCellModel;
}

- (MMPersonMessageCellModel *)userSexyCellModel {
    if (!_userSexyCellModel) {
        _userSexyCellModel = [[MMPersonMessageCellModel alloc] init];
        _userSexyCellModel.icon = @"Sexy";
        _userSexyCellModel.title = @"性别";
        _userSexyCellModel.subTitle = @"请选择您的性别";
    }
    return _userSexyCellModel;
}

- (MMPersonMessageCellModel *)userBirthdayCellModel {
    if (!_userBirthdayCellModel) {
        _userBirthdayCellModel = [[MMPersonMessageCellModel alloc] init];
        _userBirthdayCellModel.icon = @"Birthday";
        _userBirthdayCellModel.title = @"出生日期";
        _userBirthdayCellModel.subTitle = @"请选择您的出生日期";
    }
    return _userBirthdayCellModel;
}

- (MMPersonMessageCellModel *)userSignCellModel {
    if (!_userSignCellModel) {
        _userSignCellModel = [[MMPersonMessageCellModel alloc] init];
        _userSignCellModel.icon = @"Sign";
        _userSignCellModel.title = @"签名";
        _userSignCellModel.subTitle = @"请输入您的签名";
    }
    return _userSignCellModel;
}

- (MMPersonMessageCellModel *)userGradeCellModel {
    if (!_userGradeCellModel) {
        _userGradeCellModel = [[MMPersonMessageCellModel alloc] init];
        _userGradeCellModel.icon = @"Rank";
        _userGradeCellModel.title = @"身份";
        _userGradeCellModel.subTitle = @"普通";
    }
    return _userGradeCellModel;
}

@end
