//
//  MMChooseBirthVC.m
//  My-Zone
//
//  Created by chiery on 15/10/10.
//  Copyright © 2015年 My-Zone. All rights reserved.
//

#import "MMChooseBirthVC.h"
#import "MMPersonTableViewModel.h"

@interface MMChooseBirthVC ()
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
    [self setupBirthDate:_tempDate];
    self.userBirth.subTitle = _tempDate;

}

@end
