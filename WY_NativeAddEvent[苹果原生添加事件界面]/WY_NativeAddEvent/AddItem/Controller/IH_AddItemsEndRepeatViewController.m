//
//  IH_AddItemsEndRepeatViewController.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/19.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//
#define KNeverNo @"永不"

#import "IH_AddItemsEndRepeatViewController.h"
#import "ItemEvent.h"
#import "IH_SelectTableViewCell.h"
#import "SelectCellModel.h"
#import "NSDate+IHF.h"
@interface IH_AddItemsEndRepeatViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)UIDatePicker *datePicker;

@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation IH_AddItemsEndRepeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.navTitle;
    
    [self setUpBody];
    
}

#pragma mark- setUpTab
- (void)setUpBody
{
    [self.view setBackgroundColor:IHBackGroundColor];
    
    CGFloat tableH = (44*2 + 20) + 44 + 20;//这里的高度有点奇怪－－－－
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.Width, tableH) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    tableView.rowHeight = 44;
    tableView.tableFooterView = [[UIView alloc] init];
    [tableView setBackgroundColor:IHBackGroundColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    CGFloat pickerY = CGRectGetMaxY(self.tableView.frame);
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, pickerY, self.view.Width, 162)];
    [datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate dateFromString:self.item.starTimeValue format:self.item.format]];
    [datePicker addTarget:self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
    [datePicker setBackgroundColor:IHWhiteColor];
    if ([self.item.value length] && ![self.item.value isEqualToString:KNeverNo]) {
        datePicker.hidden = NO;
    }
    else
    {
        datePicker.hidden = YES;
    }
    
    [self.view addSubview:datePicker];
    self.datePicker = datePicker;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IH_SelectTableViewCell *cell = [IH_SelectTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectModel = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = IHBackGroundColor;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //让选中行打勾
    for (int i = 0; i < self.dataArr.count; i++) {
        if (indexPath.row == i) {
            SelectCellModel *model = self.dataArr[i];
            model.isSelect = YES;
        }
        else
        {
            SelectCellModel *model = self.dataArr[i];
            model.isSelect = NO;
        }
    }
    
    //隐藏显示datePicker
    if (indexPath.row == 1) {
        self.datePicker.hidden = NO;
    }
    else
    {
        self.datePicker.hidden = YES;
        self.item.value = KNeverNo;
    }
    
    [self.tableView reloadData];
}

#pragma mark - private
-(void)datePickerChange:(UIDatePicker *)datePicker
{
    NSDate *startDate = [NSDate dateFromString:self.item.starTimeValue format:self.item.format];
    if ([datePicker.date timeIntervalSinceDate:startDate] < 0) {//表示选中的时间小于开始时间
        [datePicker setDate:startDate animated:YES];
    }
    self.item.value = [datePicker.date stringWithFormat:IHDateFormate_yMd];
}

#pragma mark - setter and getter
- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        
        NSArray *array = @[KNeverNo,@"于日期"];
        NSMutableArray *mutArr = [[NSMutableArray alloc] init];
        for (NSString *str in array) {
            SelectCellModel *select = [[SelectCellModel alloc] init];
            select.title = str;
            [mutArr addObject:select];
        }
        _dataArr = mutArr;
    }
    return _dataArr;
}

- (void)setItem:(ItemEvent *)item
{
    _item = item;
    if ([item.value length]) {
        if ([item.value isEqualToString:KNeverNo]) {
            SelectCellModel *model = self.dataArr[0];
            model.isSelect = YES;
        }
        else
        {
            SelectCellModel *model = self.dataArr[1];
            model.isSelect = YES;
        }
    }
    else
    {
        
    }
}
@end
