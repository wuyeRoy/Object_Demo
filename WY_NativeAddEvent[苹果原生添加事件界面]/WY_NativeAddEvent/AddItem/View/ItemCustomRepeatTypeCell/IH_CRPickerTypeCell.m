//
//  IH_CRPickerTypeCell.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/22.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_CRPickerTypeCell.h"
#import "CustomRepeat.h"
@interface IH_CRPickerTypeCell ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,weak)UIPickerView *pickerView;

@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation IH_CRPickerTypeCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"IH_CRPickerTypeCell";
    IH_CRPickerTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
    
    self.pickerView.frame = CGRectMake(0, 0, self.Width, self.Height);
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
    
    if ([self.delegate respondsToSelector:@selector(IH_CRPickerTypeCellSelectValue:)]) {
        [self.delegate IH_CRPickerTypeCellSelectValue:self.repeat.value];
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
//    if (!repeat.value) {
//        repeat.value = @"第一个 星期日";
//    }
    
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
@end
