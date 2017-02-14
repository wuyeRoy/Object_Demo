//
//  IH_AddItemsRepeatTableViewController.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/19.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemEvent;
@protocol IH_AddItemsRepeatTableViewControllerDelegate <NSObject>


-(void)IH_AddItemsRepeatTableViewDidSelect:(NSString *)selectStr;

@end
@interface IH_AddItemsRepeatTableViewController : UITableViewController
@property(nonatomic,copy)NSString *navTitle;//导航栏标题
@property(nonatomic,strong)ItemEvent *item;

@property(nonatomic,weak)id<IH_AddItemsRepeatTableViewControllerDelegate> delegate;
@end
