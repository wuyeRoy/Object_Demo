//
//  HealthItemsScreenView.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/7.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "HealthItemsScreenView.h"

@interface HealthItemsScreenView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UILabel *leftTitleLab;
@property(nonatomic,weak)UILabel *rightTitleLab;
@property(nonatomic,weak)UITableView *leftTabView;
@property(nonatomic,weak)UITableView *rightTabView;
@property(nonatomic,weak)UIView *lineView;
@property(nonatomic,weak)UIButton *sureBtn;

@property(nonatomic,strong)NSArray *leftDataArr;
@property(nonatomic,strong)NSArray *rightDataArr;

@property(nonatomic,copy)NSString *selectFamilyStr;
@property(nonatomic,copy)NSString *selectTypeStr;
@end

@implementation HealthItemsScreenView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = IHWhiteColor;
        
        UILabel *leftTitleLab = [[UILabel alloc] init];
        leftTitleLab.text = @"家属";
        leftTitleLab.font = [UIFont systemFontOfSize:18.0f];
        leftTitleLab.textColor = IHBlackColor;
        leftTitleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:leftTitleLab];
        self.leftTitleLab = leftTitleLab;
        
        UILabel *rightTitleLab = [[UILabel alloc] init];
        rightTitleLab.text = @"类型";
        rightTitleLab.font = [UIFont systemFontOfSize:18.0f];
        rightTitleLab.textColor = IHBlackColor;
        rightTitleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:rightTitleLab];
        self.rightTitleLab = rightTitleLab;

        UITableView *leftTab = [[UITableView alloc] init];
        leftTab.delegate = self;
        leftTab.dataSource = self;
        leftTab.tableFooterView = [[UIView alloc] init];
        [self addSubview:leftTab];
        self.leftTabView = leftTab;
        
        UITableView *rightTab = [[UITableView alloc] init];
        rightTab.delegate = self;
        rightTab.dataSource = self;
        rightTab.tableFooterView = [[UIView alloc] init];
        [self addSubview:rightTab];
        self.rightTabView = rightTab;
        
        
        UIView *lineView = [[UIView alloc] init];
        [lineView setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:lineView];
        self.lineView = lineView;
        
        UIButton *sureBtn = [[UIButton alloc] init];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:IHWhiteColor forState:UIControlStateNormal];
        [sureBtn setBackgroundColor:IHBaseColor];
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.layer.cornerRadius = 5;
        [self addSubview:sureBtn];
        self.sureBtn = sureBtn;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat labH = 44;
    self.leftTitleLab.frame = CGRectMake(0, 0, self.Width/2.0, labH);
    self.rightTitleLab.frame = CGRectMake(self.Width/2.0, 0, self.Width/2.0, labH);
    
    CGFloat sureY = self.Height - 30 - 15;
    self.sureBtn.frame = CGRectMake((self.Width - 80)/2.0, sureY, 80, 30);
    
    CGFloat lineW = 3;
    CGFloat lineX = (self.Width - lineW)/2.0;
    CGFloat lineY = CGRectGetMaxY(self.leftTitleLab.frame);
    CGFloat lineH = sureY - 15 - labH;
    self.lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat leftTabY = lineY;
    CGFloat leftTabH = lineH;
    CGFloat leftTabW = (self.Width - lineW)/2.0;
    self.leftTabView.frame = CGRectMake(0, leftTabY, leftTabW, leftTabH);
    
    self.rightTabView.frame = CGRectMake(leftTabW + lineW, leftTabY, leftTabW, leftTabH);
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTabView) {
        return self.leftDataArr.count;
    }
    else
    {
        return self.rightDataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if (tableView == self.leftTabView) {
        cell.textLabel.text = self.leftDataArr[indexPath.row];
    }
    else
    {
        cell.textLabel.text = self.rightDataArr[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTabView) {
        self.selectFamilyStr = self.leftDataArr[indexPath.row];
    }
    else
    {
        self.selectTypeStr = self.rightDataArr[indexPath.row];
    }
}

#pragma mark - event methods
- (void)sureBtnClick
{
    if ([self.delegate respondsToSelector:@selector(healthItemsScreenViewSureBtnClick:type:)]) {
        [self.delegate healthItemsScreenViewSureBtnClick:self.selectFamilyStr type:self.selectTypeStr];
    }
}

#pragma mark - setter and getter
- (NSArray *)leftDataArr
{
    if (_leftDataArr == nil) {
        _leftDataArr = @[@"全部",@"妈妈",@"宝宝"];
    }
    return _leftDataArr;
}

- (NSArray *)rightDataArr
{
    if (_rightDataArr == nil) {
        _rightDataArr = @[@"全部",@"随访",@"饮食",@"康复",@"运动",@"服药",];
    }
    return _rightDataArr;
}


@end
