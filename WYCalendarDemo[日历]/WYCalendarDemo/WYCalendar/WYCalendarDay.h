//
//  WYCalendarDay.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/14.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CollectionViewCellDayType)
{
    CellDayTypeNormal,  //当月的日期
    CellDayTypePast,    //上个月的日期
    CellDayTypeFutur,   //下个月的日期
    CellDayTypeToday,   //今天的日期
    CellDayTypeClick,   //被点击的日期
    CellDayTypeEmpty,   //不显示
};


@interface WYCalendarDay : NSObject

@property (assign, nonatomic) CollectionViewCellDayType style;//显示的样式

@property(nonatomic,copy)NSString *dayTitle;// 几号
@property(nonatomic,copy)NSString *chinese_calendar; //农历

@property(nonatomic,assign)BOOL isEvent;// 是否含有事件
@property(nonatomic,assign)BOOL isSelectDate; // 是否被选中

+(WYCalendarDay *)calendarDayWithDay:(NSString *)day;
@end
