//
//  IH_SelectTableViewController.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/19.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemEvent;
@protocol IH_SelectTableViewControllerDelegate <NSObject>

- (void) selectTableViewControllerSelect:(NSString *)selectStr;

@end
@interface IH_SelectTableViewController : UITableViewController

@property(nonatomic,copy)NSString *navTitle;//导航栏标题

@property(nonatomic,weak)id<IH_SelectTableViewControllerDelegate> delegate;

@property(nonatomic,strong)ItemEvent *item;

@end
