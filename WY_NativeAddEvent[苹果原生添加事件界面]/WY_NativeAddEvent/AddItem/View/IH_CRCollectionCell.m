//
//  IH_CRCollectionTypeCell.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/22.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_CRCollectionCell.h"
#import "UIColor+Extension.h"
#import "SelectCellModel.h"
@interface IH_CRCollectionCell()

@property(nonatomic,weak)UIButton *titleBtn;

/**
 横线
 */
@property(nonatomic,weak)UIView *horizLineView;

/**
 竖线
 */
@property(nonatomic,weak)UIView *vertLineView;
@end

@implementation IH_CRCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = IHWhiteColor;
        
        UIButton *titleBtn = [[UIButton alloc] init];
        [titleBtn setTitleColor:IHBlackColor forState:UIControlStateNormal];
        [titleBtn setTitleColor:IHWhiteColor forState:UIControlStateSelected];
        [titleBtn setBackgroundImage:[UIColor createImageWithColor:IHWhiteColor] forState:UIControlStateNormal];
        [titleBtn setBackgroundImage:[UIColor createImageWithColor:[UIColor redColor]] forState:UIControlStateSelected];
        titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [titleBtn addTarget:self action:@selector(titleBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titleBtn];
        self.titleBtn = titleBtn;
        
        UIView *horizLineView = [[UIView alloc] init];
        horizLineView.backgroundColor = IHBackGroundColor;
        [self addSubview:horizLineView];
        self.horizLineView = horizLineView;
        
        UIView *vertLineView = [[UIView alloc] init];
        vertLineView.backgroundColor = IHBackGroundColor;
        [self addSubview:vertLineView];
        self.vertLineView = vertLineView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.vertLineView.frame = CGRectMake(self.Width - 1, 0, 1, self.Height);
    self.horizLineView.frame = CGRectMake(0, self.Height - 1, self.Width, 1);
    self.titleBtn.frame = CGRectMake(0, 0, self.Width-1, self.Height-1);
}

-(void)titleBtnDidClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    self.model.isSelect = !self.model.isSelect;
    if ([self.delegate respondsToSelector:@selector(IH_CRCollectionCellDidClickItem:)]) {
        [self.delegate IH_CRCollectionCellDidClickItem:self.indexPath];
    }
    NSLog(@"btn.currentTitle:  %@",btn.currentTitle);
}

#pragma mark - setter and getter
- (void)setModel:(SelectCellModel *)model
{
    _model = model;
    [self.titleBtn setTitle:model.title forState:UIControlStateNormal];
    [self.titleBtn setTitle:model.title forState:UIControlStateSelected];
    self.titleBtn.selected = model.isSelect;
}

@end
