//
//  MMChooseBirthVC.m
//  My-Zone
//
//  Created by chiery on 15/10/10.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMChooseBirthVC.h"
#import "MMPersonTableViewModel.h"
#import "MMSimpleResult.h"

@interface MMChooseBirthVC ()<MMNetworkPtc>
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@property (nonatomic, strong) NSString *tempDate;

@end

@implementation MMChooseBirthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.userBirth.subTitle > 0) {
        [self setupBirthDate:self.userBirth.subTitle];
    }
    
    NSString *chooseDate = [MMDateFormatter yyMMddString:[NSDate date]];
    _tempDate = chooseDate;
    
}

- (void)setupBirthDate:(NSString *)dateString {
    NSMutableAttributedString *tempAttributedString = [[NSMutableAttributedString alloc] init];
    [tempAttributedString appendAttributedForeString:@"    您已经选择了："
                                            withFont:[UIFont systemFontOfSize:17]
                                        andTextColor:[UIColor MMTextColor]];
    
    [tempAttributedString appendAttributedForeString:[dateString substringWithRange:NSMakeRange(0, 4)]
                                            withFont:[UIFont systemFontOfSize:17]
                                        andTextColor:[UIColor MMTextTipColor]];
    [tempAttributedString appendAttributedForeString:@" 年 "
                                            withFont:[UIFont systemFontOfSize:17]
                                        andTextColor:[UIColor MMTextColor]];
    [tempAttributedString appendAttributedForeString:[dateString substringWithRange:NSMakeRange(5, 2)]
                                            withFont:[UIFont systemFontOfSize:17]
                                        andTextColor:[UIColor MMTextTipColor]];
    [tempAttributedString appendAttributedForeString:@" 月 "
                                            withFont:[UIFont systemFontOfSize:17]
                                        andTextColor:[UIColor MMTextColor]];
    [tempAttributedString appendAttributedForeString:[dateString substringWithRange:NSMakeRange(8, 2)]
                                            withFont:[UIFont systemFontOfSize:17]
                                        andTextColor:[UIColor MMTextTipColor]];
    [tempAttributedString appendAttributedForeString:@" 日"
                                            withFont:[UIFont systemFontOfSize:17]
                                        andTextColor:[UIColor MMTextColor]];
    
    _dateLabel.attributedText = tempAttributedString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)dateChanged:(id)sender {
    UIDatePicker *control = (UIDatePicker *)sender;
    NSDate *tempDate = control.date;
    NSString *chooseDate = [MMDateFormatter yyMMddString:tempDate];
    _tempDate = chooseDate;
}
- (IBAction)sureDate:(id)sender {
    if ([_tempDate isStringSafe]) {
        [self setupBirthDate:_tempDate];
        self.userBirth.subTitle = _tempDate;
    }
}

- (IBAction)commitBirth:(id)sender {
    if ([self.tempDate isStringSafe]) {
        NSString *humanDI = [[NSUserDefaults standardUserDefaults] objectForKey:MMUserID];
        
        NSMutableDictionary *paraDict = [NSMutableDictionary new];
        [paraDict setObjectSafe:humanDI forKey:@"humanID"];
        [paraDict setObjectSafe:self.tempDate forKey:@"brithday"];
        
        BOOL networkState = [MMNetServies postUrl:@"/tour/humaninfo.htm?action=brithday"
                                  resultContainer:[MMSimpleResult new]
                                         paraDict:[paraDict copy]
                                         delegate:self customInfo:nil];
        if (networkState) [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        else [UIAlertView networkError];
    }
    else {
        [UIAlertView tipMessage:@"还没有选择出生日期"];
    }
}

- (void)getSearchNetBack:(MMSimpleResult *)searchResult forInfo:(id)customInfo {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSNumber *networkState = searchResult.resultInfo.success;
    if ([networkState boolValue]) {
        self.userBirth.subTitle = self.tempDate;
    }
    [UIAlertView tipMessage:searchResult.resultInfo.message];
    
}


@end
