//
//  HealthItemCenterView.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/5.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "HealthItemCenterView.h"
#import "LeftRightButton.h"
@interface HealthItemCenterView()

@property(nonatomic,weak)UIButton *screenBtn;
@property(nonatomic,weak)LeftRightButton *dateBtn;
@property(nonatomic,weak)UIButton *todayBtn;
@property(nonatomic,weak)UIButton *addBtn;

@end

@implementation HealthItemCenterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = IHColor(244, 244, 244);

        UIButton *screenBtn = [[UIButton alloc] init];
        [screenBtn setImage:[UIImage imageNamed:@"IH_HealthItem_screen"] forState:UIControlStateNormal];
        [screenBtn setTitle:@"全部-运动" forState:UIControlStateNormal];
        [screenBtn setTitleColor:IHBlackColor forState:UIControlStateNormal];
        screenBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        screenBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [screenBtn addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:screenBtn];
        self.screenBtn = screenBtn;
        
        
        UIButton *todayBtn = [[UIButton alloc] init];
        [todayBtn setTitle:@"今日" forState:UIControlStateNormal];
        [todayBtn setTitleColor:IHWhiteColor forState:UIControlStateNormal];
        todayBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        todayBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [todayBtn setImage:[UIImage imageNamed:@"IH_HealthItem_Today"] forState:UIControlStateNormal];
        [todayBtn addTarget:self action:@selector(todayBtnClick) forControlEvents:UIControlEventTouchUpInside];
        todayBtn.hidden = YES;
        [self addSubview:todayBtn];
        self.todayBtn = todayBtn;
        
        //
        LeftRightButton *dateBtn = [[LeftRightButton alloc] init];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy.MM.dd";
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        [dateBtn setTitle:[NSString stringWithFormat:@"今日%@",dateStr] forState:UIControlStateNormal];
        [dateBtn setTitleColor:IHBlackColor forState:UIControlStateNormal];
        dateBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        dateBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [dateBtn setImage:[UIImage imageNamed:@"IH_HealthItem_ArrowDown"] forState:UIControlStateNormal];
        [dateBtn addTarget:self action:@selector(dateBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dateBtn];
        self.dateBtn = dateBtn;
        
        //
        UIButton *addBtn = [[UIButton alloc] init];
        [addBtn setImage:[UIImage imageNamed:@"IH_HealthItem_Add"] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        addBtn.selected = NO;
        [self addSubview:addBtn];
        self.addBtn = addBtn;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat dateW = 140;
    CGFloat dateX = (self.Width - dateW) / 2.0;
    self.dateBtn.frame = CGRectMake(dateX, 0, dateW, self.Height);
    
    self.screenBtn.frame = CGRectMake(0, 0, dateX, self.Height);
    self.todayBtn.frame = CGRectMake(0, 0, dateX, self.Height);
    
    CGFloat addW = 50;
    self.addBtn.frame = CGRectMake(self.Width - addW, 0, addW, self.Height);

}

#pragma mark - event methods
-(void)screenBtnClick
{
    if ([self.delegate respondsToSelector:@selector(healthItemCenterViewScreenBtnClick)]) {
        [self.delegate healthItemCenterViewScreenBtnClick];
    }
}

-(void)dateBtnClick
{
    if ([self.delegate respondsToSelector:@selector(healthItemCenterViewDateBtnClick)]) {
        [self.delegate healthItemCenterViewDateBtnClick];
    }
}

-(void)addBtnClick
{
    if ([self.delegate respondsToSelector:@selector(healthItemCenterViewAddBtnClick)]) {
        [self.delegate healthItemCenterViewAddBtnClick];
    }
}

-(void)todayBtnClick
{
    if ([self.delegate respondsToSelector:@selector(healthItemCenterViewTodayBtnClick)]) {
        [self.delegate healthItemCenterViewTodayBtnClick];
    }
}
#pragma mark - setter and getter 
- (void)setScreenStr:(NSString *)screenStr
{
    [self.screenBtn setTitle:screenStr forState:UIControlStateNormal];
}

- (void)setDateStr:(NSString *)dateStr
{
    [self.dateBtn setTitle:dateStr forState:UIControlStateNormal];
}

- (void)setDateAndAddBtnHidden:(BOOL)dateAndAddBtnHidden
{
    self.dateBtn.hidden = dateAndAddBtnHidden;
    self.addBtn.hidden = dateAndAddBtnHidden;
}

-(void)setScreenAndAddBtnHidden:(BOOL)screenAndAddBtnHidden
{
    self.screenBtn.hidden = screenAndAddBtnHidden;
    self.addBtn.hidden = screenAndAddBtnHidden;
    self.todayBtn.hidden = !screenAndAddBtnHidden;
}
@end
