//
//  WYCalendarView.m
//  WYCalendarDemo
//
//  Created by WYRoy on 16/12/8.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "WYCalendarView.h"
#import "WYCalendarScrollView.h"
#import "NSDate+WYCalendar.h"
@interface WYCalendarView ()<WYCalendarScrollViewDelegate>

@property(nonatomic,weak)UIButton *titleBtn;
@property(nonatomic,weak)UIView *weekView;
@property(nonatomic,weak)WYCalendarScrollView *dayScrollView;

@end

@implementation WYCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //直接在frame中计算  这一步待修正－－－－－－－－－
        CGFloat selfWidth = self.frame.size.width;
        CGFloat selfHeight = self.frame.size.height;
        
        CGFloat titleH = 44;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, selfWidth, titleH)];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        NSDate *date = [NSDate date];
        [btn setTitle:[NSString stringWithFormat:@"%ld年%ld月", [date dateYear], [date dateMonth]] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        self.titleBtn = btn;
        
        CGFloat weekY = CGRectGetMaxY(self.titleBtn.frame);
//        CGFloat weekY = 0;
        CGFloat weekH = 30;
        UIView *weekView = [[UIView alloc] initWithFrame:CGRectMake(0, weekY, selfWidth, weekH)];
        [weekView setBackgroundColor:[UIColor whiteColor]];
        [self addSubviewToWeekView:weekView height:weekH];
        [self addSubview:weekView];
        self.weekView = weekView;

        CGFloat dayY = CGRectGetMaxY(self.weekView.frame);
        WYCalendarScrollView *scrollView = [[WYCalendarScrollView alloc] initWithFrame:CGRectMake(0, dayY, selfWidth, selfHeight - dayY)];
        scrollView.WyDelegate = self;
        [scrollView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:scrollView];
        self.dayScrollView = scrollView;
        
    }
    return self;
}


-(void)addSubviewToWeekView:(UIView *)view height:(CGFloat)height
{
    NSArray *weekArray = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    CGFloat subW = self.frame.size.width/7.0;
    for (int i = 0; i < 7; i++) {
        UILabel *subLab = [[UILabel alloc] initWithFrame:CGRectMake(i * subW, 0, subW, height)];
        subLab.backgroundColor = [UIColor whiteColor];
        subLab.text = weekArray[i];
        subLab.textColor = [UIColor blackColor];
        subLab.font = [UIFont systemFontOfSize:13.5];
        subLab.textAlignment = NSTextAlignmentCenter;
        [view addSubview:subLab];
    }
}

-(void)titleBtnClick
{
    
}

#pragma mark - WYCalendarScrollViewDelegate
-(void)WYCalendarScrollViewSelectDay:(NSString *)dateStr date:(NSDate *)date
{
    if ([self.delegate respondsToSelector:@selector(WYCalendarViewSelectDay:date:)]) {
        [self.delegate WYCalendarViewSelectDay:dateStr date:date];
    }
}

-(void)WYCalendarScrollViewYear:(NSInteger)year month:(NSInteger)month
{
    [self.titleBtn setTitle:[NSString stringWithFormat:@"%ld年%ld月", year, month] forState:UIControlStateNormal];
}

#pragma mark - setter and getter
-(void)refreshToCurrentMonth
{
    
    [self.dayScrollView refreshToCurrentMonth];
}

-(void)setSelectDate:(NSDate *)selectDate
{
    _selectDate = selectDate;
    
    [self.titleBtn setTitle:[NSString stringWithFormat:@"%ld年%ld月",[selectDate dateYear],[selectDate dateMonth]] forState:UIControlStateNormal];
    self.dayScrollView.selectDate = selectDate;
}
@end
