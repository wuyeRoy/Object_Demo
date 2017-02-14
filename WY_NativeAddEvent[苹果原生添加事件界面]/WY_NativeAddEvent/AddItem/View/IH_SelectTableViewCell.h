//
//  IH_SelectTableViewCell.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/19.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectCellModel,CustomRepeat;
@interface IH_SelectTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

/**
 提醒控制器 使用这个模型
 */
@property(nonatomic,strong)SelectCellModel *selectModel;

/**
 自定义重复控制器 使用这个模型
 */
@property(nonatomic,strong)CustomRepeat *repeat;
@end
