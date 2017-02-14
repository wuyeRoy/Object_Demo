//
//  IH_CRSwitchPickerTypeCell.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/22.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_CRSwitchPickerTypeCell.h"
#import "CustomRepeat.h"
@interface IH_CRSwitchPickerTypeCell ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UISwitch *rightSwitch;
@property(nonatomic,weak)UIView *horizLineView;
@property(nonatomic,weak)UIPickerView *pickerView;

@property(nonatomic,strong)NSArray *dataArr;
@end


@implementation IH_CRSwitchPickerTypeCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"IH_CRSwitchPickerTypeCell";
    IH_CRSwitchPickerTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
        
        
        UISwitch *rightSwitch = [[UISwitch alloc] init];
        [rightSwitch addTarget:self action:@selector(rightSwitchChange) forControlEvents:UIControlEventValueChanged];
        [self addSubview:rightSwitch];
        self.rightSwitch = rightSwitch;
        
        UIView *horizLineView = [[UIView alloc] init];
        horizLineView.backgroundColor = IHBackGroundColor;
        [self addSubview:horizLineView];
        self.horizLineView = horizLineView;
        
        UIPickerView *pickerView = [[UIPickerView alloc] init];
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
    CGFloat titleW = (self.Width - UITableViewCellLeftRightMargin*2)/2.0;
    self.titleLab.frame = CGRectMake(UITableViewCellLeftRightMargin, 0, titleW, titleH);
    
    CGFloat switchW = 55;
    CGFloat switchH = 31;
    CGFloat switchX = self.Width - UITableViewCellLeftRightMargin - switchW;
    CGFloat switchY = (44-switchH)/2.0;
    self.rightSwitch.frame = CGRectMake(switchX, switchY, switchW, switchH);
    
    self.horizLineView.frame = CGRectMake(UITableViewCellLeftRightMargin, 44, self.Width - UITableViewCellLeftRightMargin, 1);

    self.pickerView.frame = CGRectMake(0, titleH+1, self.Width, self.Height - (titleH + 1));
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [self.dataArr count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataArr[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataArr[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *firStr = self.dataArr[0][[pickerView selectedRowInComponent:0]];
    NSString *secStr = self.dataArr[1][[pickerView selectedRowInComponent:1]];
    self.repeat.value = [NSString stringWithFormat:@"%@ %@",firStr,secStr];
//
    if ([self.delegate respondsToSelector:@selector(IH_CRSwitchPickerTypeCellSelectValue:)]) {
        [self.delegate IH_CRSwitchPickerTypeCellSelectValue:self.repeat.value];
    }
}

#pragma mark - event method
- (void)rightSwitchChange
{
    self.repeat.isOpen = !self.repeat.isOpen;
    if ([self.delegate respondsToSelector:@selector(IH_CRSwitchPickerTypeCellSwitchValueChange)]) {
        [self.delegate IH_CRSwitchPickerTypeCellSwitchValueChange];
    }
}

#pragma mark - setter and getter
- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        NSArray *firstArr = @[@"第一个",@"第二个",@"第三个",@"第四个",@"第五个",@"最后一个"];
        NSArray *secondArr = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"自然日",@"工作日",@"周末"];
        _dataArr = @[firstArr,secondArr];
    }
    return _dataArr;
}

- (void)setRepeat:(CustomRepeat *)repeat
{
    _repeat = repeat;
    
    self.titleLab.text = repeat.title;
    self.rightSwitch.on = repeat.isOpen;
    if (repeat.isOpen) {
        self.pickerView.hidden = NO;
        
        NSArray *valueArr = [repeat.value componentsSeparatedByString:@" "];
        NSString *firstStr = [valueArr firstObject];
        NSString *lastStr = [valueArr lastObject];
        NSInteger firstRow = 0;
        NSInteger secondRow = 0;
        for (int i = 0; i < [self.dataArr[0] count]; i++) {
            if ([firstStr isEqualToString:self.dataArr[0][i]]) {
                firstRow = i;
                break;
            }
        }
        
        for (int i = 0; i < [self.dataArr[1] count]; i++) {
            if ([lastStr isEqualToString:self.dataArr[1][i]]) {
                secondRow = i;
                break;
            }
        }
        
        [self.pickerView selectRow:firstRow inComponent:0 animated:NO];
        [self.pickerView selectRow:secondRow inComponent:1 animated:NO];
    }
    else
    {
        self.pickerView.hidden = YES;
    }
}

@end
