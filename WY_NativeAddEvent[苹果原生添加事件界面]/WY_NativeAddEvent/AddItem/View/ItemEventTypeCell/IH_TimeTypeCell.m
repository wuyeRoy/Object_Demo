//
//  IH_TimeTypeCell.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/17.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_TimeTypeCell.h"
#import "ItemEvent.h"
#import "NSDate+IHF.h"
@interface IH_TimeTypeCell()

@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UILabel *timeLab;
@property(nonatomic,weak)UIDatePicker *datePicker;
@end
@implementation IH_TimeTypeCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"IH_TimeTypeCell";
    IH_TimeTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = IHWhiteColor;
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        
        
        UILabel *timeLab = [[UILabel alloc] init];
        timeLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:timeLab];
        self.timeLab = timeLab;
        
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        [datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
        datePicker.datePickerMode=UIDatePickerModeDateAndTime;
        [datePicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:datePicker];
        self.datePicker = datePicker;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat titleH = 44;
    CGFloat titleW = (self.Width - UITableViewCellLeftRightMargin*2)/4.0;
    self.titleLab.frame = CGRectMake(UITableViewCellLeftRightMargin, 0, titleW, titleH);
    
    CGFloat timeX = CGRectGetMaxX(self.titleLab.frame);
    CGFloat timeW = self.Width - titleW - UITableViewCellLeftRightMargin*2;
    self.timeLab.frame = CGRectMake(timeX, 0, timeW, titleH);
    
    self.datePicker.frame = CGRectMake(0, titleH, self.Width, self.Height - titleH);
}

-(void)datePickerChange:(UIDatePicker *)datePicker
{
    if ([self.itemEvent.title isEqualToString:@"开始"]) {
        
        NSTimeInterval timeInterval = [datePicker.date timeIntervalSinceDate:[NSDate dateFromString:self.itemEvent.value format:self.itemEvent.format]];
        NSLog(@"timeInterval:  %f",timeInterval);
        
        NSString *timeStr = [datePicker.date stringWithFormat:self.itemEvent.format];
        self.timeLab.text = timeStr;
        self.itemEvent.value = timeStr;
        
        if ([self.delegate respondsToSelector:@selector(IH_TimeTypeCellStartTimeChange:changedDate:indexPath:)]) {
            
            [self.delegate IH_TimeTypeCellStartTimeChange:timeInterval changedDate:timeStr indexPath:self.indexPath];
        }
    }
    else
    {

        NSDate *starDate = [NSDate dateFromString:self.itemEvent.starTimeValue format:self.itemEvent.format];
        if ([datePicker.date timeIntervalSinceDate:starDate] < 0) {//结束时间小于开始时间
            [datePicker setDate:[starDate dateByAddingTimeInterval:60*60]];//默认让结束时间大于开始时间 1h
        }
        
        NSString *timeStr = [datePicker.date stringWithFormat:self.itemEvent.format];
        self.itemEvent.value = timeStr;
        if ([self.itemEvent.format isEqualToString:IHDateFormate_yMd]) {//全天模式
            NSString *weekStr = [NSDate weekTowTypeStringFromString:timeStr format:self.itemEvent.format];
            self.timeLab.text = [NSString stringWithFormat:@"%@ %@",timeStr,weekStr];
        }
        else
        {
            NSDate *start = [NSDate dateFromString:self.itemEvent.starTimeValue format:self.itemEvent.format];
            NSDate *end = [NSDate dateFromString:self.itemEvent.value format:self.itemEvent.format];
            
            if ([start isEqualToDateForDay:end]) {
                self.timeLab.text = [self.itemEvent.value substringFromIndex:12];
            }
            else
            {
                self.timeLab.text = self.itemEvent.value;
            }
        }
        
    }
    
    
}

#pragma setter and getter
- (void)setDatePickerTypeTag:(NSInteger)datePickerTypeTag
{
    _datePickerTypeTag = datePickerTypeTag;
    if (datePickerTypeTag == 1) {
        self.datePicker.datePickerMode=UIDatePickerModeDateAndTime;
    }
    else
    {
        self.datePicker.datePickerMode = UIDatePickerModeDate;
    }
}

- (void)setItemEvent:(ItemEvent *)itemEvent
{
    _itemEvent = itemEvent;
    self.titleLab.text = itemEvent.title;
    
    if ([itemEvent.format isEqualToString:IHDateFormate_yMd]) {//全天模式
        NSString *weekStr = [NSDate weekTowTypeStringFromString:itemEvent.value format:itemEvent.format];
        self.timeLab.text = [NSString stringWithFormat:@"%@ %@",itemEvent.value,weekStr];
    }
    else
    {
        if ([itemEvent.title isEqualToString:@"结束"]) {//如果是同一天 不需要显示前面的年月日
            
            NSDate *start = [NSDate dateFromString:itemEvent.starTimeValue format:itemEvent.format];
            NSDate *end = [NSDate dateFromString:itemEvent.value format:itemEvent.format];
            
            if ([start isEqualToDateForDay:end]) {
                self.timeLab.text = [itemEvent.value substringFromIndex:12];
            }
            else
            {
                self.timeLab.text = itemEvent.value;
            }
        }
        else
        {
            self.timeLab.text = itemEvent.value;
        }
    }
    
    
    
    //判断是否展开
    if (itemEvent.isOpen) {
        self.timeLab.textColor = [UIColor redColor];
        self.datePicker.hidden = NO;
        NSDate *date = [NSDate dateFromString:itemEvent.value format:itemEvent.format];
        [self.datePicker setDate:date animated:YES];
    }
    else
    {
        self.timeLab.textColor = IHBlackColor;
        self.datePicker.hidden = YES;
    }
}
@end
