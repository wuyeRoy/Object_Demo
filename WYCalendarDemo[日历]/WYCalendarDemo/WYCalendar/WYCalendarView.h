//
//  WYCalendarView.h
//  WYCalendarDemo
//
//  Created by WYRoy on 16/12/8.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WYCalendarViewDelegate <NSObject>

@optional
//选中具体的某一天
- (void)WYCalendarViewSelectDay:(NSString *)dateStr date:(NSDate *)date;

@end
@interface WYCalendarView : UIView

@property(nonatomic,assign)id<WYCalendarViewDelegate> delegate;

//选中的时间
@property(nonatomic,strong)NSDate *selectDate;

-(void)refreshToCurrentMonth;
@end
