//
//  IH_AddItemsCustomRepeatViewController.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/21.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_AddItemsCustomRepeatViewController.h"
#import "CustomRepeat.h"
#import "IH_CRFrequencyTypeCell.h"
#import "IH_SelectTableViewCell.h"
#import "NSDate+IHF.h"
#import "NSString+Extension.h"
#import "IH_CustomRepeatFooterView.h"
#import "IH_CRCollectionDayTypeCell.h"
#import "IH_CRCollectionMonthTypeCell.h"
#import "IH_CRSwitchPickerTypeCell.h"
#import "IH_CRPickerTypeCell.h"
#import "ItemEvent.h"
@interface IH_AddItemsCustomRepeatViewController ()<UITableViewDelegate,UITableViewDataSource,IH_CRFrequencyTypeCellDelegate,IH_CRCollectionDayTypeCellDelegate,IH_CRPickerTypeCellDelegate,IH_CRSwitchPickerTypeCellDelegate>
@property(nonatomic,weak)UITableView *tableView;


/**
 dataSource
 */
@property(nonatomic,strong)NSMutableArray *dataArr;

/**
 具体的用文字描述重复的日期
 */
//@property(nonatomic,copy)NSString *describeStr;


/**
 存放星期模型
 */
@property(nonatomic,strong)NSMutableArray *weekArray;

/**
 存放月份模型
 */
@property(nonatomic,strong)NSMutableArray *monthArray;

/**
 存放年份模型
 */
@property(nonatomic,strong)NSMutableArray *yearArray;
@end

@implementation IH_AddItemsCustomRepeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.navTitle;
    
    [self setUpBody];
}

#pragma mark- setUpTab
- (void)setUpBody
{
    [self.view setBackgroundColor:IHBackGroundColor];
    
//    CGFloat tableH = (44*2 + 40) + 44 + 20;//这里的高度有点奇怪－－－－
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.Width, self.view.Height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [tableView setBackgroundColor:IHBackGroundColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - Table view data source
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
    CustomRepeat *repeat = self.dataArr[indexPath.section][indexPath.row];
    if (repeat.cellType == CustomRepeatLableAndPickerTypeCell) {
        IH_CRFrequencyTypeCell *cell = [IH_CRFrequencyTypeCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.repeat = repeat;
        cell.delegate = self;
        if ([repeat.title isEqualToString:@"频率"]) {
            cell.typeTag = 1;
        }
        else if ([repeat.title isEqualToString:@"每"])
        {
            cell.typeTag = 2;
        }
        
        return cell;
    }
    else if(repeat.cellType == CustomRepeatSelectTypeCell)
    {
        IH_SelectTableViewCell *cell = [IH_SelectTableViewCell cellWithTableView:tableView];
        cell.repeat = repeat;
        return cell;
    }
    else if(repeat.cellType == CustomRepeatPickerTypeCell)
    {
        IH_CRPickerTypeCell *cell = [IH_CRPickerTypeCell cellWithTableView:tableView];
        cell.repeat = repeat;
        cell.delegate = self;
        return cell;
    }
    else if(repeat.cellType == CustomRepeatCollectionDayTypeCell)
    {
        IH_CRCollectionDayTypeCell *cell = [IH_CRCollectionDayTypeCell cellWithTableView:tableView];
        cell.typeTag = 1;
        cell.repeat = repeat;
        cell.delegate = self;
        return cell;
    }
    else if(repeat.cellType == CustomRepeatCollectionMonthTypeCell)
    {
        IH_CRCollectionDayTypeCell *cell = [IH_CRCollectionDayTypeCell cellWithTableView:tableView];
        cell.typeTag = 2;
        cell.repeat = repeat;
        cell.delegate = self;
        return cell;
    }
    else if(repeat.cellType == CustomRepeatSwitchAndPickerTypeCell)
    {
        IH_CRSwitchPickerTypeCell *cell = [IH_CRSwitchPickerTypeCell cellWithTableView:tableView];
        cell.repeat = repeat;
        cell.delegate = self;
        return cell;
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        CGFloat labW = self.view.Width-(UITableViewCellLeftRightMargin*2);
        CGSize size = [self.item.describeValue sizeWithFont:[UIFont systemFontOfSize:12] andMaxSize:CGSizeMake(labW, MAXFLOAT)];
        NSLog(@"width:%f height:%f",size.width,size.height);
        
        return size.height+10;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        
        IH_CustomRepeatFooterView *foot = [IH_CustomRepeatFooterView footWithTableView:tableView];
        foot.descripStr = self.item.describeValue;
        return foot;
    }
    else
        return nil;
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
    CustomRepeat *repeat =  self.dataArr[indexPath.section][indexPath.row];
    if (repeat.cellType == CustomRepeatLableAndPickerTypeCell) {
        if (repeat.isOpen) {
            return 208;
        }
        else
        {
            return 44;
        }
    }
    else if(repeat.cellType == CustomRepeatSelectTypeCell)
    {
        return 44;
    }
    else if(repeat.cellType == CustomRepeatPickerTypeCell)
    {
        return 162;
    }
    else if(repeat.cellType == CustomRepeatCollectionDayTypeCell)
    {
        return self.view.Width/7.0 * 5;
    }
    else if(repeat.cellType == CustomRepeatCollectionMonthTypeCell)
    {
        return 44 * 3 + 20;
    }
    else if(repeat.cellType == CustomRepeatSwitchAndPickerTypeCell)
    {
        if (repeat.isOpen) {
            return 208;
        }
        else
        {
            return 44;
        }
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomRepeat *selectRepeat =  self.dataArr[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0) {
        for (CustomRepeat *repeat in self.dataArr[0]) {
            if ([repeat.title isEqualToString:selectRepeat.title]) {
                repeat.isOpen = !repeat.isOpen;
            }
            else
            {
                repeat.isOpen = NO;
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
    else if (indexPath.section == 1)
    {
        //将第一个section中展开的收起来
        [self noExpandFirstSectionCell];
        
        CustomRepeat *unitRepeat = self.dataArr[0][1];
        if ([unitRepeat.unitStr isEqualToString:@"周"]) {
            //获取选中的星期的数组
            NSMutableArray *selectWeekTitleArr = [self getSelectWeekTitleArray:selectRepeat];
            if (selectWeekTitleArr.count == 0) {
                selectRepeat.isSelect = YES;
            }
            else if (selectWeekTitleArr.count == [self.dataArr[1] count])
            {
                self.item.describeValue = @"事件将每天重复";
            }
            else{
                self.item.describeValue = [NSString stringWithFormat:@"事件将每%@于%@重复一次",[self getUnitValue],[selectWeekTitleArr componentsJoinedByString:@"、"]];
            }
        }
        else if ([unitRepeat.unitStr isEqualToString:@"月"])
        {
            //判断点击的是日期还是星期
            if ([selectRepeat.title isEqualToString:@"日期"]) {
                if (!selectRepeat.isSelect) {
                    selectRepeat.isSelect = YES;
                    
                    CustomRepeat *weekRepeat = self.dataArr[indexPath.section][1];//星期模型
                    weekRepeat.isSelect = NO;
                    
                    CustomRepeat *thirdRepeat = self.dataArr[indexPath.section][2];//模型
                    thirdRepeat.cellType = CustomRepeatCollectionDayTypeCell;
                    thirdRepeat.value = selectRepeat.value;
                    
                    self.item.describeValue = [NSString stringWithFormat:@"事件将每%@于%@重复一次",[self getUnitValue],thirdRepeat.value];
                }
            }
            else if([selectRepeat.title isEqualToString:@"星期"])
            {
                if (!selectRepeat.isSelect) {
                    selectRepeat.isSelect = YES;
                    
                    CustomRepeat *dayRepeat = self.dataArr[indexPath.section][0];//日期模型
                    dayRepeat.isSelect = NO;
                    
                    CustomRepeat *thirdRepeat = self.dataArr[indexPath.section][2];//模型
                    thirdRepeat.cellType = CustomRepeatPickerTypeCell;
                    thirdRepeat.value = selectRepeat.value;
                    
                   self.item.describeValue = [NSString stringWithFormat:@"事件将每%@于%@重复一次",[self getUnitValue],thirdRepeat.value];
                }
            }
        }
        else if ([unitRepeat.unitStr isEqualToString:@"年"])
        {
            
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

#pragma mark - IH_CRFrequencyTypeCellDelegate - Section=0

/**
 选中了频率类型
 @param typeStr 天／周／月／年
 */
-(void)IH_CRFrequencyTypeCellSelectedType:(NSString *)typeStr
{
    typeStr = [typeStr isEqualToString:@"月"] ? @"个月" : typeStr;
    
    //修改单位
    CustomRepeat *repeat =  self.dataArr[0][1];
    if ([repeat.value containsString:@"月"]) {
        repeat.value = [NSString stringWithFormat:@"%@%@",[repeat.value substringToIndex:[repeat.value length]-2],typeStr];
    }
    else
    {
        repeat.value = [NSString stringWithFormat:@"%@%@",[repeat.value substringToIndex:[repeat.value length]-1],typeStr];
    }
    repeat.unitStr = typeStr;
    
    self.item.describeValue = [NSString stringWithFormat:@"事件将每%@重复一次",repeat.value];
    
    //根据不同的单位 改变数据源
    [self changeDataSourceByUnit:typeStr];
    
    [self.tableView reloadData];
}

/**
 选中了数字
 @param number 1-999
 */
-(void)IH_CRFrequencyTypeCellSelectedNumber:(NSString *)number
{
    self.item.describeValue = [NSString stringWithFormat:@"事件将每%@重复一次",number];
    [self.tableView reloadData];
}

#pragma mark - IH_CRCollectionDayTypeCellDelegate － 月
/**
 选中了哪几天

 @param dayStr string
 */
- (void)IH_CRCollectionDayTypeCellDidClickDays:(NSString *)dayStr type:(NSInteger)typeTag
{
    //将第一个section中展开的收起来
    [self noExpandFirstSectionCell];
    
    if (typeTag == 1) {
        CustomRepeat *repeat = self.dataArr[1][0];// 日期对应的模型 改变value值
        repeat.value = dayStr;
        self.item.describeValue = [NSString stringWithFormat:@"事件将每%@于%@重复一次",[self getUnitValue],dayStr];
    }
    else
    {
        //年类型 describeStr
        [self dealWithDescribeStrForYearType];
    }
    
    [self.tableView reloadData];
}

#pragma mark - IH_CRPickerTypeCellDelegate - 月

/**
 选中了第几个星期几
 */
- (void)IH_CRPickerTypeCellSelectValue:(NSString *)value
{
    //将第一个section中展开的收起来
    [self noExpandFirstSectionCell];
    
    CustomRepeat *repeat = self.dataArr[1][1];// 星期对应的模型 改变value值
    repeat.value = value;
    
    self.item.describeValue = [NSString stringWithFormat:@"事件将每%@于%@重复一次",[self getUnitValue],value];
    [self.tableView reloadData];
}

#pragma mark - IH_CRSwitchPickerTypeCellDelegate - 年
/**
 Switch  打开 或 关闭
 */
- (void)IH_CRSwitchPickerTypeCellSwitchValueChange
{
    //将第一个section中展开的收起来
    [self noExpandFirstSectionCell];
    
    //年类型 describeStr
    [self dealWithDescribeStrForYearType];
    
    [self.tableView reloadData];
}

/**
 选中第几个星期几
 @param selectStr 第几个星期几
 */
-(void)IH_CRSwitchPickerTypeCellSelectValue:(NSString *)selectStr
{
    //将第一个section中展开的收起来
    [self noExpandFirstSectionCell];
    
    //年类型 describeStr
    [self dealWithDescribeStrForYearType];
    
    [self.tableView reloadData];
}

#pragma mark - private methods
/**
 根据不同的单位 改变数据源

 @param type 天／周／月／年
 */
-(void)changeDataSourceByUnit:(NSString *)type
{
    if ([type isEqualToString:@"天"]) {
        [self cleanTheDateSourceLastOne];
    }
    else if([type isEqualToString:@"周"])
    {
        [self cleanTheDateSourceLastOne];
        [self.dataArr addObject:self.weekArray];
    }
    else if([type isEqualToString:@"个月"])
    {
        [self cleanTheDateSourceLastOne];
        [self.dataArr addObject:self.monthArray];
    }
    else if([type isEqualToString:@"年"])
    {
        [self cleanTheDateSourceLastOne];
        [self.dataArr addObject:self.yearArray];
    }
}


/**
 清空第二个section的数据源 和 界面元素
 */
-(void)cleanTheDateSourceLastOne
{
    if (self.dataArr.count != 1) {
        [self.dataArr removeLastObject];
//        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        self.weekArray = nil;
        self.monthArray = nil;
        self.yearArray = nil;
    }
}


/**
 获取选中的星期的数组
 */
-(NSMutableArray *)getSelectWeekTitleArray:(CustomRepeat *)repeat
{
    repeat.isSelect = !repeat.isSelect;
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    for (CustomRepeat *cusR in self.dataArr[1]) {
        if (cusR.isSelect) {
            [mutArr addObject:cusR.title];
        }
    }
    return mutArr;
}


/**
 获得 第一个section中第二个row 位置的value值

 @return NSString
 */
-(NSString *)getUnitValue
{
    CustomRepeat *cusR = self.dataArr[0][1];
    return cusR.value;
}


/**
 将第一个section中展开的收起来
 */
-(void)noExpandFirstSectionCell
{
    for (CustomRepeat *repeat in self.dataArr[0])
    {
        if (repeat.isOpen) {
            repeat.isOpen = NO;
            break;//只有一个展开的
        }
    }
}


/**
 处理 年类型 describeStr
 */
- (void)dealWithDescribeStrForYearType
{
    CustomRepeat *monthRepeat = self.dataArr[1][0];//
    
    CustomRepeat *weekRepeat = self.dataArr[1][1];//
    if (weekRepeat.isOpen) {
        self.item.describeValue = [NSString stringWithFormat:@"事件将每%@于%@的%@重复一次",[self getUnitValue],monthRepeat.value,weekRepeat.value];
    }
    else
    {
        self.item.describeValue = [NSString stringWithFormat:@"事件将每%@于%@重复一次",[self getUnitValue],monthRepeat.value];
    }
}

#pragma mark - setter and getter
- (void)setItem:(ItemEvent *)item
{
    _item = item;
    
    if (!self.item.describeValue) {
        self.item.describeValue = [NSString stringWithFormat:@"事件将每天重复"];
    }
    
    if (!self.item.customRepeatArray) {
        CustomRepeat *repeat = [[CustomRepeat alloc] init];
        repeat.title = @"频率";
        repeat.value = @"每天";
        repeat.isOpen = NO;
        repeat.cellType = CustomRepeatLableAndPickerTypeCell;
        
        CustomRepeat *repeat1 = [[CustomRepeat alloc] init];
        repeat1.title = @"每";
        repeat1.value = @"1天";
        repeat1.unitStr = @"天";
        repeat1.isOpen = NO;
        repeat1.cellType = CustomRepeatLableAndPickerTypeCell;
        
        _dataArr = [[NSMutableArray alloc] initWithObjects:@[repeat,repeat1], nil];
        self.item.customRepeatArray = _dataArr;
    }
    else
    {
        _dataArr = self.item.customRepeatArray;
    }
    
}

- (NSMutableArray *)weekArray
{
    if (_weekArray == nil) {
        
        //从日期字符串 得到是星期几
        NSString *weekStr = [NSDate weekStringFromString:self.item.starTimeValue format:self.item.format];
        NSLog(@"weekday:  %@",weekStr);
        NSArray *arr = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
        NSMutableArray *mutArr = [[NSMutableArray alloc] init];
        for (NSString *str in arr) {
            CustomRepeat *repeat = [[CustomRepeat alloc] init];
            repeat.title = str;
            repeat.cellType = CustomRepeatSelectTypeCell;
            if ([weekStr isEqualToString:str]) {
                repeat.isSelect = YES;
            }
            [mutArr addObject:repeat];
        }
        _weekArray = mutArr;
    }
    return _weekArray;
}

- (NSMutableArray *)monthArray
{
    if (_monthArray == nil) {
        CustomRepeat *repeat = [[CustomRepeat alloc] init];
        repeat.title = @"日期";
        repeat.cellType = CustomRepeatSelectTypeCell;
        repeat.isSelect = YES;
        //从日期字符串 得到几号
        NSDate *date = [NSDate dateFromString:self.item.starTimeValue format:self.item.format];
        repeat.value = [NSString stringWithFormat:@"%ld号",date.day];
        
        CustomRepeat *repeat1 = [[CustomRepeat alloc] init];
        repeat1.title = @"星期";
        repeat1.cellType = CustomRepeatSelectTypeCell;
        repeat1.value = @"第一个 星期日";
        
        CustomRepeat *repeat2 = [[CustomRepeat alloc] init];
        repeat2.cellType = CustomRepeatCollectionDayTypeCell;
        repeat2.value = repeat.value;
        
        _monthArray = [[NSMutableArray alloc] initWithObjects:repeat,repeat1,repeat2, nil];
    }
    return _monthArray;
}

- (NSMutableArray *)yearArray
{
    if (_yearArray == nil) {
        CustomRepeat *repeat = [[CustomRepeat alloc] init];
        repeat.cellType = CustomRepeatCollectionMonthTypeCell;
        //获取开始时间的月份
        NSDate *date = [NSDate dateFromString:self.item.starTimeValue format:self.item.format];
        repeat.value = [NSString stringWithFormat:@"%ld月",[date month]];
        
        CustomRepeat *repeat1 = [[CustomRepeat alloc] init];
        repeat1.title = @"星期";
        repeat1.cellType = CustomRepeatSwitchAndPickerTypeCell;
        repeat1.isOpen = NO;//默认不选中
        repeat1.value = @"第一个 星期日";
        
        _yearArray = [[NSMutableArray alloc] initWithObjects:repeat,repeat1, nil];
    }
    return _yearArray;
}
@end
