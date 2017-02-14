//
//  IH_SwitchTypeCell.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/17.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_SwitchTypeCell.h"
#import "ItemEvent.h"
@interface IH_SwitchTypeCell()

@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UISwitch *rightSwitch;

@end
@implementation IH_SwitchTypeCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"IH_SwitchTypeCell";
    IH_SwitchTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        
        UISwitch *rightSwitch = [[UISwitch alloc] init];
        [rightSwitch addTarget:self action:@selector(rightSwitchChange) forControlEvents:UIControlEventValueChanged];
        [self addSubview:rightSwitch];
        self.rightSwitch = rightSwitch;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat titleW = self.Width - UITableViewCellLeftRightMargin*2 - 55;
    self.titleLab.frame = CGRectMake(UITableViewCellLeftRightMargin, 0, titleW, self.Height);
    
    CGFloat switchX = CGRectGetMaxX(self.titleLab.frame);
    CGFloat switchY = (self.Height-31)/2.0;
    self.rightSwitch.frame = CGRectMake(switchX, switchY, 55, 31);
}

-(void)rightSwitchChange
{
    self.itemEvent.isOpen = !self.itemEvent.isOpen;
    
    if ([self.delegate respondsToSelector:@selector(IH_SwitchTypeCellSwitchValueChange)]) {
        [self.delegate IH_SwitchTypeCellSwitchValueChange];
    }
}

#pragma setter and getter
- (void)setItemEvent:(ItemEvent *)itemEvent
{
    _itemEvent = itemEvent;
    self.titleLab.text = itemEvent.title;
    
}
@end
