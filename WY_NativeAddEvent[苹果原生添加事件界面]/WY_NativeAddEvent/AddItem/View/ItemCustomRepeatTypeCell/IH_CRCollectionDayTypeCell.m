//
//  IH_CRCollectionDayTypeCell.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/22.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//
#define Identifer @"IH_CRCollectionCell"
#import "IH_CRCollectionDayTypeCell.h"
#import "IH_CRCollectionCell.h"
#import "NSDate+IHF.h"
#import "SelectCellModel.h"
#import "CustomRepeat.h"
@interface IH_CRCollectionDayTypeCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,IH_CRCollectionCellDelegate>
@property(nonatomic,weak)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation IH_CRCollectionDayTypeCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"IH_CRCollectionDayTypeCell";
    IH_CRCollectionDayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectView.delegate = self;
        collectView.dataSource = self;
        [collectView setBackgroundColor:IHBackGroundColor];
        [collectView registerClass:[IH_CRCollectionCell class] forCellWithReuseIdentifier:Identifer];
        [self addSubview:collectView];
        self.collectionView = collectView;

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.Width, self.Height);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IH_CRCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifer forIndexPath:indexPath];
    SelectCellModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    cell.delegate = self;
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark -  UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.typeTag == 1) {
        return CGSizeMake(self.Width/7.0, self.Width/7.0);
    }
    else
    {
        return CGSizeMake(self.Width/4.0, 44);
    }
}

#pragma mark - IH_CRCollectionCellDelegate
/**
 点击了item
 */
- (void)IH_CRCollectionCellDidClickItem:(NSIndexPath *)indexpath
{
    //遍历数组
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    for (SelectCellModel *model in self.dataArr) {
        if (model.isSelect) {
            if (self.typeTag == 1) {
                [mutArr addObject:[NSString stringWithFormat:@"%@日",model.title]];
            }
            else
            {
                [mutArr addObject:model.title];
            }
            
        }
    }
    
    if (mutArr.count == 0) {
        SelectCellModel *model = self.dataArr[indexpath.row];
        model.isSelect = YES;
        [self.collectionView reloadData];
    }
    else
    {
        NSString *dayStr = [mutArr componentsJoinedByString:@"、"];
        self.repeat.value = dayStr;
        if ([self.delegate respondsToSelector:@selector(IH_CRCollectionDayTypeCellDidClickDays:type:)]) {
            [self.delegate IH_CRCollectionDayTypeCellDidClickDays:dayStr type:self.typeTag];
        }
    }
}

#pragma mark - private method
-(void)creatDataArr
{
    _dataArr = [[NSMutableArray alloc] init];
    if (self.typeTag == 1) {
        for (int i = 1; i <= 31; i++) {
            SelectCellModel *model = [[SelectCellModel alloc] init];
            model.title = [NSString stringWithFormat:@"%d",i];
            
            [_dataArr addObject:model];
        }
    }
    else if (self.typeTag == 2)
    {
        for (int i = 1; i <= 12; i++) {
            SelectCellModel *model = [[SelectCellModel alloc] init];
            model.title = [NSString stringWithFormat:@"%d月",i];
            
            [_dataArr addObject:model];
        }
    }
}

#pragma mark - setter and getter
- (void)setRepeat:(CustomRepeat *)repeat
{
    _repeat = repeat;

    //使用懒加载存在释放不掉－－－重新创建数据源
    [self creatDataArr];
    
    //将repeat.value 的值 选中对应的btn
    NSArray *arr = [repeat.value componentsSeparatedByString:@"、"];
    for (NSString *str in arr) {
        
        NSString *dayStr;
        if (self.typeTag == 1) {
            dayStr = [str substringToIndex:[str length]-1];
        }
        else
        {
            dayStr = str;
        }
        for (SelectCellModel *model in self.dataArr) {
            if ([dayStr isEqualToString:model.title]) {
                model.isSelect = YES;
                break;
            }
        }
    }
    
    //这里如果不手动调用刷新 不会刷新
    [self.collectionView reloadData];
}
@end
