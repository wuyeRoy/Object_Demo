//
//  WYCalendarMonth.m
//  WYCalendarDemo
//
//  Created by WYRoy on 16/12/8.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "WYCalendarMonth.h"
#import "NSDate+WYCalendar.h"
#import "WYCalendarDay.h"
@implementation WYCalendarMonth
- (instancetype)initWithDate:(NSDate *)date {
    
    if (self = [super init]) {
        
        _monthDate = date;
        _totalDays = [self setupTotalDays];
        _firstWeekday = [self setupFirstWeekday];
        _year = [self setupYear];
        _month = [self setupMonth];
        
        _dayArr = [self setUpDayArr];
    }
    return self;
}


- (NSInteger)setupTotalDays {
    return [_monthDate totalDaysInMonth];
}

- (NSInteger)setupFirstWeekday {
    return [_monthDate firstWeekDayInMonth];
}

- (NSInteger)setupYear {
    return [_monthDate dateYear];
}

- (NSInteger)setupMonth {
    return [_monthDate dateMonth];
}

-(NSMutableArray *)setUpDayArr
{
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
//    获取 dayModel
//    NSDate *selectDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"KSelectDate"];
    
    NSInteger lastMonthTotalDays = [_monthDate totalDaysInPreviousMonth];
    NSLog(@"lastMonthTotalDays:   %ld",lastMonthTotalDays);
    //固定6*7
    for (int i = 0; i < 6*7; i++) {
        if (i < _firstWeekday) {
            WYCalendarDay *dayModel = [WYCalendarDay calendarDayWithDay:[NSString stringWithFormat:@"%ld",(lastMonthTotalDays-_firstWeekday+1)+i]];
            dayModel.style = CellDayTypePast;
            dayModel.chinese_calendar = [self LunarForSolarYear:_year Month:_month Day:(lastMonthTotalDays-_firstWeekday+1)+i];
            [mutArr addObject:dayModel];
        }
        else if (i >= _firstWeekday && i < _firstWeekday + _totalDays)
        {
            NSString *dayStr = [NSString stringWithFormat:@"%ld",i-_firstWeekday+1];
            WYCalendarDay *dayModel = [WYCalendarDay calendarDayWithDay:dayStr];
            if (_year == [[NSDate date] dateYear] && _month == [[NSDate date] dateMonth] && [dayStr integerValue] == [[NSDate date] dateDay]) {//判断是当天
                dayModel.style = CellDayTypeToday;
            }
            else
            {
                dayModel.style = CellDayTypeNormal;
            }
            
            dayModel.chinese_calendar = [self LunarForSolarYear:_year Month:_month Day:i-_firstWeekday+1];
            [mutArr addObject:dayModel];
        }
        else if (i >= _firstWeekday + _totalDays)
        {
            WYCalendarDay *dayModel = [WYCalendarDay calendarDayWithDay:[NSString stringWithFormat:@"%ld",i-(_firstWeekday + _totalDays)+1]];
            dayModel.style = CellDayTypeFutur;
            dayModel.chinese_calendar = [self LunarForSolarYear:_year Month:_month Day:i-(_firstWeekday + _totalDays)+1];
            [mutArr addObject:dayModel];
        }
    }
    return mutArr;
}

-(void)setCalendarDayCellTypeClick:(NSDate *)selectDate
{
    for (WYCalendarDay *dayModel in self.dayArr) {
        if (_year == [selectDate dateYear] && _month == [selectDate dateMonth] && [dayModel.dayTitle integerValue] == [selectDate dateDay]) {//判断选中的天
            if ([selectDate dateDay] == [[NSDate date] dateDay]) {
                return;
            }
            dayModel.style = CellDayTypeClick;
            break;
        }
    }
}

//农历转化函数－－－
-(NSString *)LunarForSolarYear:(NSInteger)wCurYear Month:(NSInteger)wCurMonth Day:(NSInteger)wCurDay{
    
    
    
    //农历日期名
    NSArray *cDayName =  [NSArray arrayWithObjects:@"*",@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                          @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                          @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    
    //农历月份名
    NSArray *cMonName =  [NSArray arrayWithObjects:@"*",@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"腊",nil];
    
    //公历每月前面的天数
    const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    
    //农历数据
    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
        ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
        ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
        ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
        ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
        ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
        ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
        ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
        ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
        ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
    
    static int nIsEnd,m,k,n,i,nBit;
    static NSInteger nTheDate;
    
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    
    if((!(wCurYear % 4)) && (wCurMonth > 2))
        nTheDate = nTheDate + 1;
    
    //计算农历天干、地支、月、日
    nIsEnd = 0;
    m = 0;
    while(nIsEnd != 1)
    {
        if(wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while(n>=0)
        {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            for(i=1;i<n+1;i++)
                nBit = nBit/2;
            
            nBit = nBit % 2;
            
            if (nTheDate <= (29 + nBit))
            {
                nIsEnd = 1;
                break;
            }
            
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }
        if(nIsEnd)
            break;
        m = m + 1;
    }
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    if (k == 12)
    {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            wCurMonth = 1 - wCurMonth;
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }
    
    
    //生成农历月
    NSString *szNongliMonth;
    if (wCurMonth < 1){
        szNongliMonth = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
    }else{
        szNongliMonth = (NSString *)[cMonName objectAtIndex:wCurMonth];
    }
    
    //生成农历日
    NSString *szNongliDay = [cDayName objectAtIndex:wCurDay];
    
    //合并
    NSString *lunarDate = [NSString stringWithFormat:@"%@-%@",szNongliMonth,szNongliDay];
    
    return lunarDate;
}
@end
