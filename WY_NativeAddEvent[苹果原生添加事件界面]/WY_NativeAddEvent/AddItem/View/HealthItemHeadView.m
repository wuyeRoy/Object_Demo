//
//  HealthItemHeadView.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/2.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#define selectBtnWH 160
#define selectBtnX (self.Width - selectBtnWH)/2.0
#define selectBtnY self.Height - selectBtnWH - 10

#define defaultBtnWH 50
#define defaultBtnY self.Height - defaultBtnWH - 10

#define horizontalInterva 40

#import "HealthItemHeadView.h"

@interface HealthItemHeadView()

@property(nonatomic,weak)UILabel *birthTextLab;
@property(nonatomic,weak)UILabel *dateLab;
@property(nonatomic,weak)UILabel *healthMoneyLab;
@property(nonatomic,weak)UIButton *descBtn;


@property(nonatomic,weak)UIButton *momBtn;

@property(nonatomic,weak)UIButton *babyBtn;

@end

@implementation HealthItemHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = IHColor(255, 152, 177);
        
        UILabel *birthTextLab = [[UILabel alloc] init];
        birthTextLab.text = @"距离宝宝出生";
        birthTextLab.font = [UIFont systemFontOfSize:12.0f];
        birthTextLab.textColor = IHWhiteColor;
        birthTextLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:birthTextLab];
        self.birthTextLab = birthTextLab;
        
        UILabel *dateLab = [[UILabel alloc] init];
        dateLab.text = @"100 天";
        dateLab.textAlignment = NSTextAlignmentCenter;
        dateLab.textColor = IHWhiteColor;
        [self addSubview:dateLab];
        self.dateLab = dateLab;
        
        UILabel *healthMoneyLab = [[UILabel alloc] init];
        healthMoneyLab.text = @"健康币 7000";
        healthMoneyLab.textColor = IHWhiteColor;
        healthMoneyLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:healthMoneyLab];
        self.healthMoneyLab = healthMoneyLab;
        
        UIButton *descBtn = [[UIButton alloc] init];
        [descBtn setImage:[UIImage imageNamed:@"IH_HealthItem_desc"] forState:UIControlStateNormal];
        [descBtn addTarget:self action:@selector(descBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:descBtn];
        self.descBtn = descBtn;
        

        //妈妈按钮
        UIButton *momBtn = [[UIButton alloc] init];
        [momBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Mom"] forState:UIControlStateNormal];
        [momBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Mom"] forState:UIControlStateSelected];
        [momBtn addTarget:self action:@selector(momBtnClick) forControlEvents:UIControlEventTouchUpInside];
        momBtn.selected = YES;
        [self addSubview:momBtn];
        self.momBtn = momBtn;

        //宝宝按钮
        UIButton *babyBtn = [[UIButton alloc] init];
        [babyBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Baby"] forState:UIControlStateNormal];
        [babyBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Baby"] forState:UIControlStateSelected];
        [babyBtn addTarget:self action:@selector(babyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        babyBtn.selected = NO;
        [self addSubview:babyBtn];
        self.babyBtn = babyBtn;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged:) name:@"IHThemeChanged" object:nil];;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat dateLabW = 100;
    CGFloat dateLabH = 20;
    CGFloat dateLabX = (self.Width - dateLabW)/2.0;
    CGFloat dateLabY = self.Height - 10 - selectBtnWH - dateLabH -5;
    self.dateLab.frame = CGRectMake(dateLabX, dateLabY, dateLabW, dateLabH);
    
    CGFloat birthTextY = dateLabY - dateLabH;
    self.birthTextLab.frame = CGRectMake(dateLabX, birthTextY, dateLabW, dateLabH);
    
    self.healthMoneyLab.frame = CGRectMake(10, birthTextY, dateLabX - 2*10, 40);
    
    self.descBtn.frame = CGRectMake(self.Width - 50, birthTextY, 40, 40);
    
    
    
    if (self.momBtn.selected) {
        
        self.momBtn.frame = CGRectMake(selectBtnX, selectBtnY, selectBtnWH, selectBtnWH);
        self.momBtn.layer.cornerRadius = selectBtnWH/2.0;
        
        CGFloat x = self.Width - horizontalInterva - defaultBtnWH;
        self.babyBtn.frame = CGRectMake(x, defaultBtnY, defaultBtnWH, defaultBtnWH);
        self.babyBtn.layer.cornerRadius = defaultBtnWH/2.0;
    }
    else
    {
        self.momBtn.frame = CGRectMake(horizontalInterva, defaultBtnY, defaultBtnWH,defaultBtnWH);
        self.momBtn.layer.cornerRadius = defaultBtnWH/2.0;

        self.babyBtn.frame = CGRectMake(selectBtnX, selectBtnY, selectBtnWH, selectBtnWH);
        self.babyBtn.layer.cornerRadius = selectBtnWH / 2.0;
    }
    
}

#pragma mark - event methods
- (void)momBtnClick
{
    [UIView animateWithDuration:1.0 animations:^{
        
        if (!self.momBtn.selected) {
            
            //平移 缩放
            self.momBtn.frame = CGRectMake(selectBtnX, selectBtnY, selectBtnWH, selectBtnWH);
            self.momBtn.layer.cornerRadius = selectBtnWH/2.0;
            self.momBtn.transform =  CGAffineTransformRotate(self.momBtn.transform, -M_PI);
            self.momBtn.transform =  CGAffineTransformRotate(self.momBtn.transform, -M_PI);
            
            //旋转： 通过transform 两次旋转180来完成
            CGFloat x = self.Width - horizontalInterva - defaultBtnWH;
            self.babyBtn.frame = CGRectMake(x, defaultBtnY, defaultBtnWH, defaultBtnWH);
            self.babyBtn.layer.cornerRadius = defaultBtnWH/2.0;
            self.babyBtn.transform =  CGAffineTransformRotate(self.babyBtn.transform, -M_PI);
            self.babyBtn.transform =  CGAffineTransformRotate(self.babyBtn.transform, -M_PI);
            
            //改变按钮状态
            self.momBtn.selected = YES;
            self.babyBtn.selected = NO;
        }
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)babyBtnClick
{
    [UIView animateWithDuration:1.0 animations:^{
        
        if (!self.babyBtn.selected) {
            
            //平移 缩放
            self.babyBtn.frame = CGRectMake(selectBtnX, selectBtnY, selectBtnWH, selectBtnWH);
            self.babyBtn.layer.cornerRadius = selectBtnWH/2.0;
            //旋转： 通过transform 两次旋转180来完成
            self.babyBtn.transform =  CGAffineTransformRotate(self.babyBtn.transform, -M_PI);
            self.babyBtn.transform =  CGAffineTransformRotate(self.babyBtn.transform, -M_PI);

            self.momBtn.frame = CGRectMake(40, defaultBtnY, defaultBtnWH, defaultBtnWH);
            self.momBtn.layer.cornerRadius = defaultBtnWH/2.0;
            self.momBtn.transform =  CGAffineTransformRotate(self.momBtn.transform, -M_PI);
            self.momBtn.transform =  CGAffineTransformRotate(self.momBtn.transform, -M_PI);
            
            //改变按钮状态
            self.momBtn.selected = NO;
            self.babyBtn.selected = YES;
        }
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)descBtnClick
{
    
}

#pragma mark - Noti
-(void)themeChanged:(NSNotification *)noti
{
    UIColor *color =  noti.object;
    
    if (CGColorEqualToColor(color.CGColor, IHColor(255, 122, 154).CGColor)){//粉色
        [self.momBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Mom"] forState:UIControlStateNormal];
        [self.babyBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Baby"] forState:UIControlStateNormal];
        
        [self.momBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Mom"] forState:UIControlStateSelected];
        [self.babyBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Baby"] forState:UIControlStateSelected];
    }
    else if (CGColorEqualToColor(color.CGColor, IHColor(71, 158, 239).CGColor)){//蓝色
        [self.momBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Mom_Blue"] forState:UIControlStateNormal];
        [self.babyBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Baby_Blue"] forState:UIControlStateNormal];
        
        [self.momBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Mom_Blue"] forState:UIControlStateSelected];
        [self.babyBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Baby_Blue"] forState:UIControlStateSelected];
    }
    else if (CGColorEqualToColor(color.CGColor, IHColor(0, 191, 130).CGColor)){//绿色
        [self.momBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Mom_Green"] forState:UIControlStateNormal];
        [self.babyBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Baby_Green"] forState:UIControlStateNormal];
        
        [self.momBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Mom_Green"] forState:UIControlStateSelected];
        [self.babyBtn setBackgroundImage:[UIImage imageNamed:@"IH_HealthItems_Baby_Green"] forState:UIControlStateSelected];
    }
    
   
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
