//
//  HealthItemsCell.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/2.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "HealthItemsCell.h"
#import "HealthItems.h"
@interface HealthItemsCell()

//@property(nonatomic,weak)UIView *lineColor;
@property(nonatomic,weak)UIButton *timeBtn;
@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UILabel *contentLab;
@property(nonatomic,weak)UIButton *stateBtn;

@end

@implementation HealthItemsCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"HealthItemsCell";
    HealthItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[HealthItemsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = IHWhiteColor;
        
        UIButton *timeBtn = [[UIButton alloc] init];
        [timeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        timeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [timeBtn addTarget:self action:@selector(timeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:timeBtn];
        self.timeBtn = timeBtn;
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = IHBlackColor;
        titleLab.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:titleLab];
        self.titleLab = titleLab;
        
        UILabel *contentLab = [[UILabel alloc] init];
        contentLab.textColor = [UIColor lightGrayColor];
        contentLab.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:contentLab];
        self.contentLab = contentLab;
        
        UIButton *stateBtn = [[UIButton alloc] init];
        [stateBtn setTitleColor:IHBlackColor forState:UIControlStateNormal];
        stateBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        stateBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [stateBtn addTarget:self action:@selector(stateBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:stateBtn];
        self.stateBtn = stateBtn;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat timeW = 80;
    self.timeBtn.frame = CGRectMake(0, 0, timeW, self.Height);
    
    CGFloat stateW = 80;
    self.stateBtn.frame = CGRectMake(self.Width - stateW, 0, stateW, self.Height);
    
    CGFloat titleW = self.Width - timeW - stateW;
    CGFloat titleX = CGRectGetMaxX(self.timeBtn.frame);
    CGFloat titleH = (self.Height-40)/2.0;
    CGFloat titleY = 20;
    self.titleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat contentX = titleX;
    CGFloat contentW = titleW;
    CGFloat contentH = titleH;
    CGFloat contentY = CGRectGetMaxY(self.titleLab.frame);
    self.contentLab.frame = CGRectMake(contentX, contentY, contentW, contentH);
}

#pragma mark- event methods
- (void)stateBtnClick
{
    if ([self.delegate respondsToSelector:@selector(healthItemsCellStateBtnClick:)]) {
        [self.delegate healthItemsCellStateBtnClick:self.indexPath];
    }
}

-(void)timeBtnClick
{
    if ([self.delegate respondsToSelector:@selector(healthItemsCellTimeBtnClick:)]) {
        [self.delegate healthItemsCellTimeBtnClick:self.indexPath];
    }
}
#pragma mark - setter and getter
- (void)setItem:(HealthItems *)item
{
    _item = item;
    NSString *timeStr = [item.time substringWithRange:NSMakeRange(11, 5)];
    [self.timeBtn setTitle:timeStr forState:UIControlStateNormal];
    self.titleLab.text = item.title;
    self.contentLab.text = item.content;
    [self.stateBtn setTitle:item.state forState:UIControlStateNormal];
}









@end
