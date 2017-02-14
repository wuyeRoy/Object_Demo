//
//  IH_SwitchTypeCell.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/17.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemEvent;
@protocol IH_SwitchTypeCellDelegate <NSObject>

/**
 UISwitch 打开 或 关闭
 */
-(void)IH_SwitchTypeCellSwitchValueChange;

@end
@interface IH_SwitchTypeCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)ItemEvent *itemEvent;

@property(nonatomic,weak)id<IH_SwitchTypeCellDelegate> delegate;
@end
