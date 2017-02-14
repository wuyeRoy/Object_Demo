//
//  IH_AddItemsRepeatTableViewController.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/19.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_AddItemsRepeatTableViewController.h"
#import "ItemEvent.h"
#import "IH_AddItemsCustomRepeatViewController.h"
#import "IH_CustomRepeatFooterView.h"
#import "NSString+Extension.h"
@interface IH_AddItemsRepeatTableViewController ()
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation IH_AddItemsRepeatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.navTitle;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView setBackgroundColor:IHBackGroundColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSString *selectStr = self.dataArr[indexPath.section][indexPath.row];
    cell.textLabel.text = selectStr;
    cell.imageView.image = [UIImage imageNamed:@"IH_HealthItem_Checkmark"];
    if (self.item.value) {
        if ([selectStr isEqualToString:self.item.value]) {
            cell.imageView.hidden = NO;
        }
        else
        {
            cell.imageView.hidden = YES;
        }
    }
    else
    {
        cell.imageView.hidden = YES;
    }
    
    if (indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        CGFloat labW = self.view.Width-(UITableViewCellLeftRightMargin*2);
        CGSize size = [self.item.describeValue sizeWithFont:[UIFont systemFontOfSize:12] andMaxSize:CGSizeMake(labW, MAXFLOAT)];
        return size.height+10;
    }
    else
    {
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *selectStr = self.dataArr[indexPath.section][indexPath.row];
    self.item.value = selectStr;
    
    if (indexPath.section == 0) {
        
        self.item.describeValue = nil;
        [self.item.customRepeatArray removeAllObjects];
        self.item.customRepeatArray = nil;
        
        if ([self.delegate respondsToSelector:@selector(IH_AddItemsRepeatTableViewDidSelect:)]) {
            [self.delegate IH_AddItemsRepeatTableViewDidSelect:selectStr];
        }
        //返回上一页
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {//点击自定义
        IH_AddItemsCustomRepeatViewController *vc = [[IH_AddItemsCustomRepeatViewController alloc] init];
        vc.navTitle = selectStr;
        vc.item = self.item;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - setter and getter
- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        
        NSArray *array = @[@"永不",@"每天",@"每周",@"每两周",@"每月",@"每年"];
        NSArray *array1 = @[@"自定义"];
        _dataArr = [[NSMutableArray alloc] initWithObjects:array,array1, nil];
    }
    return _dataArr;
}

- (void)setItem:(ItemEvent *)item
{
    _item = item;
}
@end
