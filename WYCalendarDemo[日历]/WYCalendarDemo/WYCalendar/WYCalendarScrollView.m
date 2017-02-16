//
//  WYCalendarScrollView.m
//  WYCalendarDemo
//
//  Created by WYRoy on 16/12/8.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#define kCellIdentifier @"WYCalendarCell"

#import "WYCalendarScrollView.h"
#import "WYCalendarCell.h"
#import "WYCalendarMonth.h"
#import "WYCalendarDay.h"
#import "NSDate+WYCalendar.h"
@interface WYCalendarScrollView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionViewL;
@property (nonatomic, weak) UICollectionView *collectionViewM;
@property (nonatomic, weak) UICollectionView *collectionViewR;

@property (nonatomic, strong) NSDate *currentMonthDate;
@property (nonatomic, strong) NSMutableArray *monthArray;
//@property(nonatomic,strong)NSDate *selectDate;

@end

@implementation WYCalendarScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.delegate = self;
        
        NSLog(@"aaaaa: %f",self.bounds.size.width);
        self.contentSize = CGSizeMake(3 * self.bounds.size.width, self.bounds.size.height);
        [self setContentOffset:CGPointMake(self.bounds.size.width, 0.0) animated:NO];
        self.currentMonthDate = [NSDate date];
        [self setupCollectionViews];
    }
    return self;
}

-(void)setupCollectionViews
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.frame.size.width/7.0, self.frame.size.height/6.0);
    flowLayout.minimumLineSpacing = 0.0;
    flowLayout.minimumInteritemSpacing = 0.0;
    
    CGFloat selfWidth = self.bounds.size.width;
    CGFloat selfHeight = self.bounds.size.height;
    
    UICollectionView *leftCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, selfWidth, selfHeight) collectionViewLayout:flowLayout];
    leftCV.dataSource = self;
    leftCV.delegate = self;
    leftCV.backgroundColor = [UIColor clearColor];
    [leftCV registerClass:[WYCalendarCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self addSubview:leftCV];
    self.collectionViewL = leftCV;
    
    UICollectionView *middleCV = [[UICollectionView alloc] initWithFrame:CGRectMake(selfWidth, 0.0, selfWidth, selfHeight) collectionViewLayout:flowLayout];
    middleCV.dataSource = self;
    middleCV.delegate = self;
    middleCV.backgroundColor = [UIColor clearColor];
    [middleCV registerClass:[WYCalendarCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self addSubview:middleCV];
    self.collectionViewM = middleCV;
    
    UICollectionView *rightCV = [[UICollectionView alloc] initWithFrame:CGRectMake(2 * selfWidth, 0.0, selfWidth, selfHeight) collectionViewLayout:flowLayout];
    rightCV.dataSource = self;
    rightCV.delegate = self;
    rightCV.backgroundColor = [UIColor clearColor];
    [rightCV registerClass:[WYCalendarCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self addSubview:rightCV];
    self.collectionViewR = rightCV;
}

#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42; // 7 * 6
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WYCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    if (collectionView == self.collectionViewL) {
        
        WYCalendarMonth *monthInfo = self.monthArray[0];
        cell.dayModel = monthInfo.dayArr[indexPath.row];
    }
    else if(collectionView == self.collectionViewM)
    {
        WYCalendarMonth *monthInfo = self.monthArray[1];
        cell.dayModel = monthInfo.dayArr[indexPath.row];
    }
    else if(collectionView == self.collectionViewR)
    {
        WYCalendarMonth *monthInfo = self.monthArray[2];
        cell.dayModel = monthInfo.dayArr[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WYCalendarMonth *monthInfo = self.monthArray[1];
    for (WYCalendarDay *dayInfo in monthInfo.dayArr) {
        if (dayInfo.style == CellDayTypeClick) {
            dayInfo.style = CellDayTypeNormal;
        }
    }
    WYCalendarDay *dayInfo = monthInfo.dayArr[indexPath.row];
    dayInfo.style = CellDayTypeClick;
    
    [self.collectionViewM reloadData];
    
    if ([self.WyDelegate respondsToSelector:@selector(WYCalendarScrollViewSelectDay:date:)]) {
        NSString *dateStr = [NSString stringWithFormat:@"%ld.%ld.%@",monthInfo.year,monthInfo.month,dayInfo.dayTitle];
        NSDate *date = [self getDate:monthInfo dayInfo:dayInfo];
        [self.WyDelegate WYCalendarScrollViewSelectDay:dateStr date:date];
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView != self) {
        return;
    }
    
    // 向右滑动
    NSLog(@"%f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x < self.bounds.size.width) {
        
        _currentMonthDate = [_currentMonthDate previousMonthDate];
        
        
        NSDate *previousDate = [_currentMonthDate previousMonthDate];
        // 数组中最左边的月份现在作为中间的月份，中间的作为右边的月份，新的左边的需要重新获取
        WYCalendarMonth *currentMothInfo = self.monthArray[0];
        WYCalendarMonth *nextMonthInfo = self.monthArray[1];
        
        //可以考虑 复用WYCalendarMonth 对象
        
        WYCalendarMonth *previousMonthInfo = [[WYCalendarMonth alloc] initWithDate:previousDate];
        
        NSNumber *prePreviousMonthDays = [self previousMonthDaysForPreviousDate:[_currentMonthDate previousMonthDate]];
        
        [self.monthArray removeAllObjects];
        [self.monthArray addObject:previousMonthInfo];
        
        [self.monthArray addObject:currentMothInfo];
        if (self.selectDate && [self.selectDate dateYear] == _currentMonthDate.dateYear && [self.selectDate dateMonth] == _currentMonthDate.dateMonth) {
            [self.monthArray[1] setCalendarDayCellTypeClick:self.selectDate];
        }
        
        [self.monthArray addObject:nextMonthInfo];
        
        [self.monthArray addObject:prePreviousMonthDays];
        
    }
    // 向左滑动
    else if (scrollView.contentOffset.x > self.bounds.size.width) {
        
        _currentMonthDate = [_currentMonthDate nextMonthDate];
        NSDate *nextDate = [_currentMonthDate nextMonthDate];
        
        // 数组中最右边的月份现在作为中间的月份，中间的作为左边的月份，新的右边的需要重新获取
        WYCalendarMonth *previousMonthInfo = self.monthArray[1];
        WYCalendarMonth *currentMothInfo = self.monthArray[2];
        
        WYCalendarMonth *olderPreviousMonthInfo = self.monthArray[0];
        NSNumber *prePreviousMonthDays = [[NSNumber alloc] initWithInteger:olderPreviousMonthInfo.totalDays]; // 先保存 olderPreviousMonthInfo 的月天数
        
       //可以考虑 复用WYCalendarMonth 对象
        
        WYCalendarMonth *nextMonthInfo = [[WYCalendarMonth alloc] initWithDate:nextDate];
        
        [self.monthArray removeAllObjects];
        [self.monthArray addObject:previousMonthInfo];
        
        [self.monthArray addObject:currentMothInfo];
        if (self.selectDate && [self.selectDate dateYear] == _currentMonthDate.dateYear && [self.selectDate dateMonth] == _currentMonthDate.dateMonth) {
            [self.monthArray[1] setCalendarDayCellTypeClick:self.selectDate];
        }
        
        [self.monthArray addObject:nextMonthInfo];
        
        [self.monthArray addObject:prePreviousMonthDays];
    }
    
    [_collectionViewM reloadData]; // 中间的 collectionView 先刷新数据
    [scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0.0) animated:NO]; // 然后变换位置
    [_collectionViewL reloadData]; // 最后两边的 collectionView 也刷新数据
    [_collectionViewR reloadData];
    
    //更改当前月份标题
    if ([self.WyDelegate respondsToSelector:@selector(WYCalendarScrollViewYear:month:)]) {
        WYCalendarMonth *currentMothInfo = self.monthArray[1];
        [self.WyDelegate WYCalendarScrollViewYear:currentMothInfo.year month:currentMothInfo.month];
    }
}

#pragma mark - private
- (NSNumber *)previousMonthDaysForPreviousDate:(NSDate *)date {
    return [[NSNumber alloc] initWithInteger:[[date previousMonthDate] totalDaysInMonth]];
}

//回到当前的月份
- (void)refreshToCurrentMonth {
    
    // 如果现在就在当前月份，则不执行操作
    WYCalendarMonth *currentMonthInfo = self.monthArray[1];
    if ((currentMonthInfo.month == [[NSDate date] dateMonth]) && (currentMonthInfo.year == [[NSDate date] dateYear])) {
        return;
    }
    
    _currentMonthDate = [NSDate date];
    
    NSDate *previousMonthDate = [_currentMonthDate previousMonthDate];
    NSDate *nextMonthDate = [_currentMonthDate nextMonthDate];
    
    [self.monthArray removeAllObjects];
    [self.monthArray addObject:[[WYCalendarMonth alloc] initWithDate:previousMonthDate]];
    [self.monthArray addObject:[[WYCalendarMonth alloc] initWithDate:_currentMonthDate]];
    if (self.selectDate && [self.selectDate dateYear] == _currentMonthDate.dateYear && [self.selectDate dateMonth] == _currentMonthDate.dateMonth) {
        [self.monthArray[1] setCalendarDayCellTypeClick:self.selectDate];
    }
    
    
    [self.monthArray addObject:[[WYCalendarMonth alloc] initWithDate:nextMonthDate]];
    [self.monthArray addObject:[self previousMonthDaysForPreviousDate:previousMonthDate]];
    
    // 刷新数据
    [_collectionViewM reloadData];
    [_collectionViewL reloadData];
    [_collectionViewR reloadData];
    
    //更改当前月份标题
    if ([self.WyDelegate respondsToSelector:@selector(WYCalendarScrollViewYear:month:)]) {
        WYCalendarMonth *currentMothInfo = self.monthArray[1];
        [self.WyDelegate WYCalendarScrollViewYear:currentMothInfo.year month:currentMothInfo.month];
    }
}

-(NSDate *)getDate:(WYCalendarMonth *)monthInfo dayInfo:(WYCalendarDay *)dayInfo
{
    NSString *month = monthInfo.month < 10 ? [NSString stringWithFormat:@"0%ld",monthInfo.month] : [NSString stringWithFormat:@"%ld",monthInfo.month];
    NSString *day = [dayInfo.dayTitle length] < 2 ? [NSString stringWithFormat:@"0%@",dayInfo.dayTitle] : dayInfo.dayTitle;
    NSString *dateStr = [NSString stringWithFormat:@"%ld.%@.%@",monthInfo.year,month,day];
    NSDate *date = [NSDate wy_dateFromString:dateStr format:@"yyyy.MM.dd"];
    
    return date;
}

#pragma mark - setter and getter
- (NSMutableArray *)monthArray {
    
    if (_monthArray == nil) {
        
        _monthArray = [NSMutableArray arrayWithCapacity:4];
        
        NSDate *previousMonthDate = [self.currentMonthDate previousMonthDate];
        NSDate *nextMonthDate = [_currentMonthDate nextMonthDate];
        
        [_monthArray addObject:[[WYCalendarMonth alloc] initWithDate:previousMonthDate]];
        [_monthArray addObject:[[WYCalendarMonth alloc] initWithDate:_currentMonthDate]];
        [_monthArray addObject:[[WYCalendarMonth alloc] initWithDate:nextMonthDate]];
        [_monthArray addObject:[self previousMonthDaysForPreviousDate:previousMonthDate]]; // 存储左边的月份的前一个月份的天数，用来填充左边月份的首部
    }
    
    return _monthArray;
}

-(void)setSelectDate:(NSDate *)selectDate
{
    _selectDate = selectDate;
    WYCalendarMonth *calendar = self.monthArray[1];
    if ([selectDate dateYear] == calendar.year && [selectDate dateMonth] == calendar.month) {//选中的日期是在当前月
        NSLog(@"选中的当前月－－－－");
        [_monthArray[1] setCalendarDayCellTypeClick:selectDate];
        [_collectionViewM reloadData];
    }
    else
    {
        _currentMonthDate = selectDate;
        NSDate *previousMonthDate = [_currentMonthDate previousMonthDate];
        NSDate *nextMonthDate = [_currentMonthDate nextMonthDate];
        
        [_monthArray removeAllObjects];
        [_monthArray addObject:[[WYCalendarMonth alloc] initWithDate:previousMonthDate]];
        
        [_monthArray addObject:[[WYCalendarMonth alloc] initWithDate:_currentMonthDate]];
        [_monthArray[1] setCalendarDayCellTypeClick:selectDate];
        
        [_monthArray addObject:[[WYCalendarMonth alloc] initWithDate:nextMonthDate]];
        [_monthArray addObject:[self previousMonthDaysForPreviousDate:previousMonthDate]]; // 存储左边的月份的前一个月份的天数，用来填充左边月份的首部
        
        [_collectionViewM reloadData];
        [_collectionViewL reloadData];
        [_collectionViewR reloadData];
    }
}
@end
