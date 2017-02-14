//
//  HealthItemCenterView.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/5.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HealthItemCenterViewDelegate <NSObject>

@optional
- (void) healthItemCenterViewScreenBtnClick;

- (void) healthItemCenterViewDateBtnClick;

- (void) healthItemCenterViewAddBtnClick;

- (void) healthItemCenterViewTodayBtnClick;

@end

@interface HealthItemCenterView : UIView

@property(nonatomic,weak)id<HealthItemCenterViewDelegate> delegate;

//设置screenBtn title
@property(nonatomic,copy)NSString *screenStr;

////设置dateBtn title
@property(nonatomic,copy)NSString *dateStr;

//日期按钮和添加按钮 隐藏
@property(nonatomic,assign)BOOL dateAndAddBtnHidden;

//筛选按钮和添加按钮 隐藏
@property(nonatomic,assign)BOOL screenAndAddBtnHidden;
@end
