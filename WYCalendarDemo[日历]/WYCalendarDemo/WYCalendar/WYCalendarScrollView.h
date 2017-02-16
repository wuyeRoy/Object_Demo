//
//  WYCalendarScrollView.h
//  WYCalendarDemo
//
//  Created by WYRoy on 16/12/8.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WYCalendarScrollViewDelegate <NSObject>

//选中具体的某一天
- (void)WYCalendarScrollViewSelectDay:(NSString *)dateStr date:(NSDate *)date;

//当前页面的年份 月份
- (void)WYCalendarScrollViewYear:(NSInteger)year month:(NSInteger)month;

@end
@interface WYCalendarScrollView : UIScrollView

@property(nonatomic,weak)id<WYCalendarScrollViewDelegate> WyDelegate;

-(void)refreshToCurrentMonth;

@property(nonatomic,strong)NSDate *selectDate;
@end
