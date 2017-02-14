//
//  HealthItemsScreenView.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/7.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HealthItemsScreenViewDelegate <NSObject>

- (void) healthItemsScreenViewSureBtnClick:(NSString *)selectFamily type:(NSString *)typeStr;
@end

@interface HealthItemsScreenView : UIView

@property(nonatomic,weak)id<HealthItemsScreenViewDelegate> delegate;

@end
