//
//  IH_CRFrequencyTypeCell.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/21.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_CRFrequencyTypeCell.h"
#import "CustomRepeat.h"
@interface IH_CRFrequencyTypeCell()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UILabel *valueLab;
@property(nonatomic,weak)UIPickerView *pickerView;
@end

@implementation IH_CRFrequencyTypeCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"IH_CRFrequencyTypeCell";
    IH_CRFrequencyTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
        titleLab.textColor = IHBlackColor;
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        
        
        UILabel *valueLab = [[UILabel alloc] init];
        valueLab.textColor = IHGrayTextColor;
        valueLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:valueLab];
        self.valueLab = valueLab;
        
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        pickerView.tag = 1;
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [self addSubview:pickerView];
        self.pickerView = pickerView;
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
    self.valueLab.frame = CGRectMake(timeX, 0, timeW, titleH);
    self.pickerView.frame = CGRectMake(0, titleH, self.Width, self.Height - titleH);
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.typeTag == 1) {
        return 1;
    }
    else
    {
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.typeTag == 1) {
        return self.dataArr.count;
    }
    else
    {
        return [self.dataArr[component] count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.typeTag == 1) {
        return self.dataArr[row];
    }
    else
    {
        return self.dataArr[component][row];
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.typeTag == 1) {
        NSLog(@"typeTag: %ld row: %ld",self.typeTag,row);
        self.repeat.value = self.dataArr[row];
        if ([self.delegate respondsToSelector:@selector(IH_CRFrequencyTypeCellSelectedType:)]) {
            [self.delegate IH_CRFrequencyTypeCellSelectedType:[self.dataArr[row] substringFromIndex:1]];
        }
    }
    else
    {
        NSLog(@"typeTag: %ld row: %ld",self.typeTag,row);
        if (component == 0) {
            NSString *str = [NSString stringWithFormat:@"%@%@",self.dataArr[0][row],self.repeat.unitStr];
//            self.valueLab.text = str;
            self.repeat.value = str;
            if ([self.delegate respondsToSelector:@selector(IH_CRFrequencyTypeCellSelectedNumber:)]) {
                [self.delegate IH_CRFrequencyTypeCellSelectedNumber:str];
            }
        }
    }
    
}

#pragma mark - setter and getter
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        if (self.typeTag == 1) {
            _dataArr = [[NSMutableArray alloc] initWithObjects:@"每天",@"每周",@"每月",@"每年", nil];
        }
        else
        {
            NSMutableArray *numbersArr = [[NSMutableArray alloc] init];
            for (int i = 1; i < 1000; i++) {
                [numbersArr addObject:[NSString stringWithFormat:@"%d",i]];
            }
            NSArray *unitArr = @[self.repeat.unitStr];
            _dataArr = [[NSMutableArray alloc] initWithObjects:numbersArr,unitArr, nil];
        }
    }
    return _dataArr;
}

- (void)setRepeat:(CustomRepeat *)repeat
{
    _repeat = repeat;
    self.titleLab.text = repeat.title;
    self.valueLab.text = repeat.value;
    if (repeat.isOpen) {
        self.pickerView.hidden = NO;
        self.valueLab.textColor = [UIColor redColor];
    }
    else
    {
        self.pickerView.hidden = YES;
        self.valueLab.textColor = IHGrayTextColor;
    }
}

- (void)setTypeTag:(NSInteger)typeTag
{
    _typeTag = typeTag;
    if (typeTag == 2 && self.dataArr) {//改变单位
        [self.dataArr replaceObjectAtIndex:1 withObject:@[self.repeat.unitStr]];
    }
}
@end
