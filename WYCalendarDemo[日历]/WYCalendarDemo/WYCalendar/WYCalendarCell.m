//
//  WYCalendarCell.m
//  WYCalendarDemo
//
//  Created by WYRoy on 16/12/8.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "WYCalendarCell.h"
#import "WYCalendarDay.h"
@interface WYCalendarCell ()

@property (nonatomic, weak) UIView *circleView;
@property (nonatomic, weak) UILabel *dayLab;
@property (nonatomic, weak) UILabel *chinese_calendarLab;
@property(nonatomic,weak) UIView *eventView;

@end

@implementation WYCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UIView *circleView = [[UIView alloc] init];
        circleView.backgroundColor = [UIColor clearColor];
        [self addSubview:circleView];
        self.circleView = circleView;
        
        UILabel *dayLab = [[UILabel alloc] init];
        dayLab.textAlignment = NSTextAlignmentCenter;
        dayLab.font = [UIFont boldSystemFontOfSize:18.0];
        dayLab.backgroundColor = [UIColor clearColor];
        [self addSubview:dayLab];
        self.dayLab = dayLab;
        
        UILabel *chinese_calendarLab = [[UILabel alloc] init];
        chinese_calendarLab.textAlignment = NSTextAlignmentCenter;
        chinese_calendarLab.font = [UIFont boldSystemFontOfSize:10.0];
        chinese_calendarLab.backgroundColor = [UIColor clearColor];
        [self addSubview:chinese_calendarLab];
        self.chinese_calendarLab = chinese_calendarLab;
        
        UIView *eventView = [[UIView alloc] init];
        eventView.hidden = YES;
        eventView.backgroundColor = [UIColor redColor];
        [self addSubview:eventView];
        self.eventView = eventView;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat selfWidth = self.bounds.size.width;
    CGFloat selfHeight = self.bounds.size.height;
    
    
    CGFloat dayH = 22;
    CGFloat chineseH = 10;
    CGFloat dayY = 5;
    self.dayLab.frame = CGRectMake(0, dayY, selfWidth, dayH);
    
    CGFloat chineseY = CGRectGetMaxY(self.dayLab.frame);
    self.chinese_calendarLab.frame = CGRectMake(0, chineseY, selfWidth, chineseH);
    
    CGFloat radius = dayH + chineseH + dayY*2;
    CGFloat X = (self.frame.size.width - radius)/2.0;
    CGFloat Y = 0;
    self.circleView.frame = CGRectMake(X, Y, radius, radius);
    self.circleView.layer.cornerRadius = 0.5 * radius;
    
    
    CGFloat eventWH = 7;
    CGFloat eventX = (selfWidth-eventWH)/2.0;
    CGFloat eventY = selfHeight-eventWH;
    self.eventView.frame = CGRectMake(eventX, eventY, eventWH, eventWH);
    self.eventView.layer.cornerRadius = 0.5 * eventWH;
}

#pragma mark - setter and getter
- (void)setDayModel:(WYCalendarDay *)dayModel
{
    _dayModel = dayModel;
    
    self.dayLab.text = dayModel.dayTitle;
    self.chinese_calendarLab.text = [dayModel.chinese_calendar componentsSeparatedByString:@"-"][1];
    switch (dayModel.style) {
        case CellDayTypeNormal:
            self.dayLab.textColor = [UIColor darkTextColor];
            self.chinese_calendarLab.textColor = [UIColor darkTextColor];
            self.circleView.hidden = YES;
            self.userInteractionEnabled = YES;
            self.eventView.hidden = NO;
            break;
        case CellDayTypePast:
            self.dayLab.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            self.chinese_calendarLab.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            self.circleView.hidden = YES;
            self.userInteractionEnabled = NO;
            self.eventView.hidden = YES;
            break;
            
        case CellDayTypeFutur:
            self.dayLab.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            self.chinese_calendarLab.textColor = [UIColor colorWithWhite:0.85 alpha:1.0];
            self.circleView.hidden = YES;
            self.userInteractionEnabled = NO;
            self.eventView.hidden = YES;
            break;
            
        case CellDayTypeToday:
            self.dayLab.textColor = [UIColor whiteColor];
            self.chinese_calendarLab.textColor = [UIColor whiteColor];
            self.circleView.hidden = NO;
            self.circleView.backgroundColor = [UIColor redColor];
            self.userInteractionEnabled = YES;
            self.eventView.hidden = NO;
            break;
            
        case CellDayTypeClick:
            self.dayLab.textColor = [UIColor whiteColor];
            self.chinese_calendarLab.textColor = [UIColor whiteColor];
            self.circleView.hidden = NO;
            self.circleView.backgroundColor = [UIColor blueColor];
            self.userInteractionEnabled = YES;
            self.eventView.hidden = NO;
            break;
            
        case CellDayTypeEmpty:
            self.dayLab.hidden = YES;
            self.chinese_calendarLab.hidden = YES;
            self.circleView.hidden = YES;
            self.eventView.hidden = YES;
            break;
        default:
            break;
    }
}
@end
