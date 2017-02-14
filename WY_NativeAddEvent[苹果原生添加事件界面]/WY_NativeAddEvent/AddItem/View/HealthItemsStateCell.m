//
//  HealthItemsStateCell.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/7.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

NSString *const UNProcessItem    = @"未进行";
NSString *const ProcessItem    = @"进行中";
NSString *const CancleItem    = @"已取消";
NSString *const DoneItem    = @"已完成";

#import "HealthItemsStateCell.h"
#import "UpDownButton.h"
#import "HealthItems.h"
@interface HealthItemsStateCell()

@property(nonatomic,weak)UpDownButton *unProcessBtn;//未进行
@property(nonatomic,weak)UpDownButton *processBtn;//进行中
@property(nonatomic,weak)UpDownButton *cancleBtn;//已取消
@property(nonatomic,weak)UpDownButton *doneBtn;//已完成

@end

@implementation HealthItemsStateCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"HealthItemsStateCell";
    HealthItemsStateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[HealthItemsStateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = IHColor(238, 238, 238);
        
        UpDownButton *unProcessBtn = [[UpDownButton alloc] init];
        [self setCommonBtn:unProcessBtn title:UNProcessItem];
        [unProcessBtn addTarget:self action:@selector(unProcessBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:unProcessBtn];
        self.unProcessBtn = unProcessBtn;
        
        
        UpDownButton *processBtn = [[UpDownButton alloc] init];
        [self setCommonBtn:processBtn title:ProcessItem];
        [processBtn addTarget:self action:@selector(processBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:processBtn];
        self.processBtn = processBtn;
        
        UpDownButton *cancleBtn = [[UpDownButton alloc] init];
        [self setCommonBtn:cancleBtn title:CancleItem];
        [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:cancleBtn];
        self.cancleBtn = cancleBtn;
        
        UpDownButton *doneBtn = [[UpDownButton alloc] init];
        [self setCommonBtn:doneBtn title:DoneItem];
        [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:doneBtn];
        self.doneBtn = doneBtn;
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat btnW = self.Width / 4.0;
    self.unProcessBtn.frame = CGRectMake(0, 0, btnW, self.Height);
    self.processBtn.frame = CGRectMake(CGRectGetMaxX(self.unProcessBtn.frame), 0, btnW, self.Height);
    self.cancleBtn.frame = CGRectMake(CGRectGetMaxX(self.processBtn.frame), 0, btnW, self.Height);
    self.doneBtn.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), 0, btnW, self.Height);
}

#pragma mark - private methods
- (void)setCommonBtn:(UpDownButton *)btn title:(NSString *)title
{
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"IH_HealthItem_White"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:@"IH_HealthItem_Blue"] forState:UIControlStateSelected];
    [btn setTitleColor:IHColor(80, 144, 240) forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
}

-(void)setBtnNormal
{
    self.unProcessBtn.selected = NO;
    self.processBtn.selected = NO;
    self.cancleBtn.selected = NO;
    self.doneBtn.selected = NO;
}

-(void)setCumtomDelegate
{
    if ([self.delegate respondsToSelector:@selector(healthItemsStateCellSelected:)]) {
        [self.delegate healthItemsStateCellSelected:self.indexPath];
    }
}

#pragma mark - event methods
- (void)unProcessBtnClick
{
    [self setBtnNormal];
    self.unProcessBtn.selected = YES;
    self.item.state = UNProcessItem;
    
    [self setCumtomDelegate];
}

-(void)processBtnClick
{
    [self setBtnNormal];
    self.processBtn.selected = YES;
    self.item.state = ProcessItem;
    
    [self setCumtomDelegate];
}

-(void)cancleBtnClick
{
    [self setBtnNormal];
    self.cancleBtn.selected = YES;
    self.item.state = CancleItem;
    
    [self setCumtomDelegate];
}

-(void)doneBtnClick
{
    [self setBtnNormal];
    self.doneBtn.selected = YES;
    self.item.state = DoneItem;
    
    [self setCumtomDelegate];
}

#pragma mark - setter and getter
- (void)setItem:(HealthItems *)item
{
    _item = item;
    
    [self setBtnNormal];
    if ([item.state isEqualToString:UNProcessItem]) {
        self.unProcessBtn.selected = YES;
    }
    else if ([item.state isEqualToString:ProcessItem])
    {
        self.processBtn.selected = YES;
    }
    else if ([item.state isEqualToString:CancleItem])
    {
        self.cancleBtn.selected = YES;
    }
    else if ([item.state isEqualToString:DoneItem])
    {
        self.doneBtn.selected = YES;
    }
}

@end
