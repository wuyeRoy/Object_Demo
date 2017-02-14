//
//  IH_SelectTypeCell.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/17.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_SelectTypeCell.h"
#import "ItemEvent.h"
@interface IH_SelectTypeCell()

@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UILabel *valueLab;
@property(nonatomic,weak)UIImageView *arrowImageView;

@end
@implementation IH_SelectTypeCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"IH_SelectTypeCell";
    IH_SelectTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab.textColor = IHBlackColor;
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        

        UILabel *valueLab = [[UILabel alloc] init];
        valueLab.textColor = IHGrayTextColor;
        valueLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:valueLab];
        self.valueLab = valueLab;
        
        UIImageView *arrowImageView = [[UIImageView alloc] init];
        arrowImageView.image = [UIImage imageNamed:@"IH_HealthItem_ArrowRight"];
        [self addSubview:arrowImageView];
        self.arrowImageView = arrowImageView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageW = 8;
    CGFloat imageH = 13;
    CGFloat imageX = self.Width - UITableViewCellLeftRightMargin - imageW;
    CGFloat imageY = (self.Height-imageH)/2.0;
    self.arrowImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    CGFloat titleW = (self.Width - UITableViewCellLeftRightMargin*2 - imageW)/2.0;
    self.titleLab.frame = CGRectMake(UITableViewCellLeftRightMargin, 0, titleW, self.Height);
    
    CGFloat valueX = CGRectGetMaxX(self.titleLab.frame);
    CGFloat valueW = titleW - 10;
    self.valueLab.frame = CGRectMake(valueX, 0, valueW, self.Height);
}

#pragma setter and getter
- (void)setItemEvent:(ItemEvent *)itemEvent
{
    _itemEvent = itemEvent;
    self.titleLab.text = itemEvent.title;
    self.valueLab.text = itemEvent.value;
}
@end
