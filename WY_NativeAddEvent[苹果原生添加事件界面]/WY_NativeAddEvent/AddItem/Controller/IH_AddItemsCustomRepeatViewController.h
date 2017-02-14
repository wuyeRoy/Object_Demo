//
//  IH_AddItemsCustomRepeatViewController.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/21.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemEvent;
@interface IH_AddItemsCustomRepeatViewController : UIViewController
@property(nonatomic,copy)NSString *navTitle;//导航栏标题

/**
 根据开始时间 默认选中 星期几／日期
 */
//@property(nonatomic,copy)NSString *starTime;//开始时间

@property(nonatomic,strong)ItemEvent *item;
@end
