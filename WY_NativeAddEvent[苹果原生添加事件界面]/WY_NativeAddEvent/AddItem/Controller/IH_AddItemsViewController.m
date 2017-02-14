//
//  IH_AddItemsViewController.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/15.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_AddItemsViewController.h"
#import "ItemEvent.h"
#import "IH_TextFieldTypeCell.h"
#import "IH_SelectTypeCell.h"
#import "IH_SwitchTypeCell.h"
#import "IH_TimeTypeCell.h"
#import "IH_SelectTableViewController.h"
#import "IH_AddItemsRepeatTableViewController.h"
#import "IH_AddItemsEndRepeatViewController.h"
#import "NSDate+IHF.h"
#import "MJExtension.h"
@interface IH_AddItemsViewController ()<UITableViewDelegate,UITableViewDataSource,IH_TimeTypeCellDelegate,IH_AddItemsRepeatTableViewControllerDelegate,IH_SwitchTypeCellDelegate>

@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation IH_AddItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpTab];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark - setUp
-(void)setUpNav
{
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarBtnClick)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    self.title = @"新建事件";
    
}

-(void)setUpTab
{
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.Width, self.view.Height)];
    table.delegate = self;
    table.dataSource = self;
    table.tableFooterView = [[UIView alloc] init];
    [table setBackgroundColor:IHBackGroundColor];
    [self.view addSubview:table];
    self.tableView = table;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemEvent *item = self.dataArr[indexPath.section][indexPath.row];
    
    if (item.type == ItemEventTextFieldTypeCell) {
        IH_TextFieldTypeCell *cell = [IH_TextFieldTypeCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.itemEvent = item;
        return cell;
    }
    else if (item.type == ItemEventSelectTypeCell) {
        IH_SelectTypeCell *cell = [IH_SelectTypeCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.itemEvent = item;
        return cell;
    }
    else if (item.type == ItemEventSwitchTypeCell) {
        IH_SwitchTypeCell *cell = [IH_SwitchTypeCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.itemEvent = item;
        cell.delegate = self;
        return cell;
    }
    else if (item.type == ItemEventTimeTypeCell) {
        IH_TimeTypeCell *cell = [IH_TimeTypeCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ItemEvent *allDayItem = [self getAllDayItemModel];
        cell.datePickerTypeTag = allDayItem.isOpen ? 2 : 1;
        cell.itemEvent = item;
        cell.delegate = self;
        cell.indexPath = indexPath;
        return cell;
    }
    else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = IHBackGroundColor;//set backGroundColor is Unavailable
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = IHBackGroundColor;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemEvent *item = self.dataArr[indexPath.section][indexPath.row];
    if (item.type == ItemEventTimeTypeCell) {
        if (item.isOpen) {
            return 208;
        }
        else
        {
            return 44;
        }
    }
    else
    {
        return 44;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemEvent *item = self.dataArr[indexPath.section][indexPath.row];
    
    //根据indexPath 来进行跳转
    if (indexPath.section == 0 || indexPath.section == 2) {
        IH_SelectTableViewController *vc = [[IH_SelectTableViewController alloc] init];
        vc.item = item;
        vc.navTitle = item.title;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.section == 1)
    {
        if ([item.title isEqualToString:@"重复"]) {
            IH_AddItemsRepeatTableViewController *vc = [[IH_AddItemsRepeatTableViewController alloc] init];
            //开始时间
            ItemEvent *startTimeItem = self.dataArr[indexPath.section][1];
            item.starTimeValue = startTimeItem.value;
            item.format = startTimeItem.format;
            vc.item = item;
            vc.navTitle = item.title;
            vc.delegate = self;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if([item.title isEqualToString:@"结束重复"])
        {
            IH_AddItemsEndRepeatViewController *vc = [[IH_AddItemsEndRepeatViewController alloc] init];
            //开始时间
            ItemEvent *startTimeItem = self.dataArr[indexPath.section][1];
            item.starTimeValue = startTimeItem.value;
            item.format = startTimeItem.format;
            vc.item = item;
            vc.navTitle = item.title;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if([item.title isEqualToString:@"开始"] || [item.title isEqualToString:@"结束"])
        {

            for (ItemEvent *selectItem in self.dataArr[indexPath.section]) {
                if ([selectItem.title isEqualToString:item.title]) {
                    selectItem.isOpen = !selectItem.isOpen;
                }
                else
                {
                    if (![selectItem.title isEqualToString:@"全天"]) {
                        selectItem.isOpen = NO;
                    }
                }
            }
            
            //设置刷新动画
            [UIView transitionWithView:self.tableView
                              duration:1.0f
                               options:UIViewAnimationOptionLayoutSubviews|UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear
                            animations:^{
                                [self.tableView reloadData];
                            } completion:^(BOOL finished) {
                                
                            }];
        }
    }

}

#pragma mark - IH_TimeTypeCellDelegate

/**
 开始时间 发生变化
 @param timeInterval 变化的秒数
 @param dateStr 变化后的开始时间
 @param indexPath indexPath
 */
- (void)IH_TimeTypeCellStartTimeChange:(NSTimeInterval)timeInterval changedDate:(NSString *)dateStr indexPath:(NSIndexPath *)indexPath
{
    ItemEvent *item = self.dataArr[indexPath.section][indexPath.row+1];
    NSDate *oldDate = [NSDate dateFromString:item.value format:item.format];
    NSDate *nowDate = [oldDate dateByAddingTimeInterval:timeInterval];
    item.value = [nowDate stringWithFormat:item.format];
    item.starTimeValue = dateStr;
    
    [self.tableView reloadData];
}

#pragma mark - IH_AddItemsRepeatTableViewControllerDelegate
- (void)IH_AddItemsRepeatTableViewDidSelect:(NSString *)selectStr
{
    if (![selectStr isEqualToString:@"永不"]) {
        ItemEvent *item = [[ItemEvent alloc] init];
        item.value = @"永不";
        item.title = @"结束重复";
        item.type = ItemEventSelectTypeCell;
        [self.dataArr[1] insertObject:item atIndex:[self.dataArr[1] count]];
    }
    else
    {
        for (ItemEvent *item in self.dataArr[1]) {
            if ([item.title isEqualToString:@"结束重复"]) {
                
                [self.dataArr[1] removeObject:item];
                break;
            }
        }
    }
}

#pragma mark - IH_SwitchTypeCellDelegate - UISwitch
-(void)IH_SwitchTypeCellSwitchValueChange
{
    ItemEvent *allDayItem = [self getAllDayItemModel];
    ItemEvent *startItem = self.dataArr[1][1];
    ItemEvent *endItem = self.dataArr[1][2];
    if (allDayItem.isOpen) {
        //eg:  "2016年12月23日 上午10:19" -> "2016年12月23日"
        startItem.value = [NSDate stringFromString:startItem.value form_format:IHDateFormate_yMd_ahm to_tormat:IHDateFormate_yMd];
        startItem.format = IHDateFormate_yMd;
        
        endItem.value = [NSDate stringFromString:endItem.value form_format:IHDateFormate_yMd_ahm to_tormat:IHDateFormate_yMd];
        endItem.starTimeValue = [NSDate stringFromString:endItem.starTimeValue form_format:IHDateFormate_yMd_ahm to_tormat:IHDateFormate_yMd];
        endItem.format = IHDateFormate_yMd;
    }
    else
    {
        //eg:  "2016年12月23日" -> "2016年12月23日 上午10:19"
        startItem.value = [NSDate stringFromString:startItem.value form_format:IHDateFormate_yMd to_tormat:IHDateFormate_yMd_ahm];
        startItem.format = IHDateFormate_yMd_ahm;
        endItem.value = [NSDate stringFromString:endItem.value form_format:IHDateFormate_yMd to_tormat:IHDateFormate_yMd_ahm];
        endItem.starTimeValue = [NSDate stringFromString:endItem.starTimeValue form_format:IHDateFormate_yMd to_tormat:IHDateFormate_yMd_ahm];
        endItem.format = IHDateFormate_yMd_ahm;
    }
    
    NSLog(@"switch is change");
    [self.tableView reloadData];
}

#pragma mark - private
- (void)leftBarBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarBtnClick
{
    
}


/**
 获取全天 对应的model
 */
-(ItemEvent *)getAllDayItemModel
{
    return self.dataArr[1][0];
}

#pragma mark - setter and getter
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        NSMutableArray *mutArr = [[NSMutableArray alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ItemEvent.plist" ofType:nil];
        NSArray *array = [NSDictionary dictionaryWithContentsOfFile:path][@"ItemEvent"];
        for (NSArray *arr in array) {
            NSArray *itemArr = [ItemEvent mj_objectArrayWithKeyValuesArray:arr];
            [mutArr addObject:itemArr];
        }
        
        //给开始／结束时间 设置初始值
        NSString *timeStr = [[NSDate date] stringWithFormat:IHDateFormate_yMd_ahm];
        NSString *oneHourLaterTimeStr = [[[NSDate alloc] initWithTimeIntervalSinceNow:60*60] stringWithFormat:IHDateFormate_yMd_ahm];
        
        for (ItemEvent *item in mutArr[1]) {
            
            if ([item.title isEqualToString:@"开始"]) {
                item.value = timeStr;
                item.format = IHDateFormate_yMd_ahm;
            }
            else if ([item.title isEqualToString:@"结束"])
            {
                item.value = oneHourLaterTimeStr;
                item.starTimeValue = timeStr;
                item.format = IHDateFormate_yMd_ahm;
            }
        }
        
        _dataArr = mutArr;
    }
    return _dataArr;
}
@end
