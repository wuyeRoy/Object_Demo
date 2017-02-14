//
//  IH_SelectTableViewController.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/19.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_SelectTableViewController.h"
#import "IH_SelectTableViewCell.h"
#import "SelectCellModel.h"
#import "ItemEvent.h"
@interface IH_SelectTableViewController ()

@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation IH_SelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.navTitle;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IH_SelectTableViewCell *cell = [IH_SelectTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectModel = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    SelectCellModel *model = self.dataArr[indexPath.row];
    self.item.value = model.title;
    //返回上一页
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setter and getter
- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        
        if ([self.item.title isEqualToString:@"分类"]) {
            NSArray *array = @[@"饮食",@"康复",@"健康",@"服药"];
            NSMutableArray *mutArr = [[NSMutableArray alloc] init];
            for (NSString *str in array) {
                SelectCellModel *select = [[SelectCellModel alloc] init];
                select.title = str;
                [mutArr addObject:select];
            }
            _dataArr = mutArr;
        }
        else if([self.item.title isEqualToString:@"监护人"])
        {
            NSArray *array = @[@"妈妈",@"宝宝"];
            NSMutableArray *mutArr = [[NSMutableArray alloc] init];
            for (NSString *str in array) {
                SelectCellModel *select = [[SelectCellModel alloc] init];
                select.title = str;
                [mutArr addObject:select];
            }
            _dataArr = mutArr;
        }
        else if([self.item.title isEqualToString:@"提醒"])
        {
            NSArray *array = @[@"无",@"事件发生时",@"5分钟前",@"15分钟前",@"30分钟前",@"1小时前",@"2小时前",@"一天前",@"2天前",@"1周前"];
            NSMutableArray *mutArr = [[NSMutableArray alloc] init];
            for (NSString *str in array) {
                SelectCellModel *select = [[SelectCellModel alloc] init];
                select.title = str;
                [mutArr addObject:select];
            }
            _dataArr = mutArr;
        }
    }
    return _dataArr;
}

- (void)setItem:(ItemEvent *)item
{
    _item = item;
    if (item.value) {
        for (SelectCellModel *model in self.dataArr) {
            if ([model.title isEqualToString:item.value]) {
                model.isSelect = YES;
                break;
            }
        }
    }
    else
    {
        
    }
}
@end
