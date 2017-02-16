//
//  ViewController.m
//  WYCalendarDemo
//
//  Created by WYRoy on 16/12/8.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "ViewController.h"
#import "WYCalendarView.h"
@interface ViewController ()
@property(nonatomic,weak)WYCalendarView *calendarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *todayBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
    [todayBtn setTitle:@"今日" forState:UIControlStateNormal];
    [todayBtn setBackgroundColor:[UIColor redColor]];
    [todayBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:todayBtn];
    
    
    WYCalendarView *calendarView = [[WYCalendarView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 400)];
    [self.view addSubview:calendarView];
    self.calendarView = calendarView;
    //
}

- (void)btnClick {
    if (self.calendarView) {
        [self.calendarView refreshToCurrentMonth];
    }
}
@end
