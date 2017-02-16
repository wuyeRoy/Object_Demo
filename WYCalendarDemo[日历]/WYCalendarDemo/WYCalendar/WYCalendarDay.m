//
//  WYCalendarDay.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/14.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "WYCalendarDay.h"

@implementation WYCalendarDay

+(WYCalendarDay *)calendarDayWithDay:(NSString *)day
{
    WYCalendarDay *calendar = [[WYCalendarDay alloc] init];
    calendar.dayTitle = day;
    
    return calendar;
}
@end
