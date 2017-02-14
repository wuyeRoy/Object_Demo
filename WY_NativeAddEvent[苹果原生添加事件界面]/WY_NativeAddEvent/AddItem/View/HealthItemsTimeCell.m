//
//  HealthItemTimeCell.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/7.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "HealthItemsTimeCell.h"
#import "HealthItems.h"
#import "NSDate+IHF.h"
@interface HealthItemsTimeCell()

@property(nonatomic,weak)UIButton *cancelBtn;
@property(nonatomic,weak)UIButton *sureBtn;
@property(nonatomic,weak)UIDatePicker *datePicker;

@end

@implementation HealthItemsTimeCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"HealthItemsTimeCell";
    HealthItemsTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[HealthItemsTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = IHWhiteColor;
        
        UIButton *cancelBtn = [[UIButton alloc] init];
        [cancelBtn setTitleColor:IHBaseColor forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [cancelBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:cancelBtn];
        self.cancelBtn = cancelBtn;

        
        UIButton *sureBtn = [[UIButton alloc] init];
        [sureBtn setTitleColor:IHBaseColor forState:UIControlStateNormal];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        sureBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:sureBtn];
        self.sureBtn = sureBtn;
        
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        [datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
        datePicker.datePickerMode=UIDatePickerModeDateAndTime;
        datePicker.center = self.center;
        [datePicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:datePicker];
        self.datePicker = datePicker;
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat btnH = 30;
    CGFloat btnW = 60;
    self.cancelBtn.frame = CGRectMake(0, 0, btnW, btnH);
    
    self.sureBtn.frame = CGRectMake(self.Width - btnW, 0, btnW, btnH);
    
    CGFloat pickerY = CGRectGetMaxY(self.sureBtn.frame);
    self.datePicker.frame = CGRectMake(0, pickerY, self.Width, self.Height - btnH);
}

#pragma mark - event methods
-(void)cancleBtnClick
{
    if ([self.delegate respondsToSelector:@selector(healthItemsTimeCellCancleBtnClick:)]) {
        [self.delegate healthItemsTimeCellCancleBtnClick:self.indexPath];
    }
}

-(void)sureBtnClick
{
    self.item.time = [self.datePicker.date string];
    if ([self.delegate respondsToSelector:@selector(healthItemsTimeCellSureBtnClick:)]) {
        [self.delegate healthItemsTimeCellSureBtnClick:self.indexPath];
    }
}

-(void)datePickerChange:(UIDatePicker *)datePicker
{
//    NSLog(@"%f",[datePicker.date timeIntervalSinceNow]);
    
//    self.item.time = [datePicker.date string];
}

#pragma mark - setter and getter 
- (void)setItem:(HealthItems *)item
{
    _item = item;
    NSDate *date = [NSDate dateFromString:item.time];
    [self.datePicker setDate:date];
}
@end
