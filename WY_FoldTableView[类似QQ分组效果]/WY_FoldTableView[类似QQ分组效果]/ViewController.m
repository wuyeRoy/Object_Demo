//
//  ViewController.m
//  WY_FoldTableView[类似QQ分组效果]
//
//  Created by WYRoy on 17/2/9.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//

#import "ViewController.h"
#import "SectionModel.h"
#import "CellModel.h"
#import "HeadView.h"
#import "TableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"分组Demo";
    
    [self creatTableView];
}

#pragma mark - setUp
- (void)creatTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SectionModel *secModel = self.dataArr[section];
    if (secModel.open) {
        return secModel.subArray.count;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [TableViewCell cellWithTableView:tableView];
    SectionModel *secModel = self.dataArr[indexPath.section];
    CellModel *model = secModel.subArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headWithTableView:tableView];
    SectionModel *model = self.dataArr[section];
    headView.model = model;
    headView.headClickCallBack = ^(BOOL isOpen){
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    };
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

#pragma mark - setter and getter
- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        
        //这里这么写是为了简单些 实际中使用可直接使用字典转模型工具－－－－－－－
        NSString *path = [[NSBundle mainBundle] pathForResource:@"address.plist" ofType:nil];
        NSArray *addressArr = [NSDictionary dictionaryWithContentsOfFile:path][@"address"];
        
        NSMutableArray *secArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in addressArr) {
            SectionModel *secModel = [[SectionModel alloc] init];
            secModel.name = dict[@"name"];
            
            NSMutableArray *cellArr = [[NSMutableArray alloc] init];
            for (NSDictionary *subDict in dict[@"sub"]) {
                CellModel *cellModel = [[CellModel alloc] init];
                cellModel.name = subDict[@"name"];
                cellModel.zipcode = subDict[@"zipcode"];
                [cellArr addObject:cellModel];
            }
            secModel.subArray = cellArr;
            [secArray addObject:secModel];
        }
        _dataArr = secArray;
    }
    return _dataArr;
}
@end
