//
//  HealthItemTimeCell.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/7.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HealthItems;

@protocol HealthItemsTimeCellDelegate <NSObject>

- (void) healthItemsTimeCellSureBtnClick:(NSIndexPath *)indexPath;

- (void) healthItemsTimeCellCancleBtnClick:(NSIndexPath *)indexPath;

@end
@interface HealthItemsTimeCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)HealthItems *item;
@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,weak)id<HealthItemsTimeCellDelegate> delegate;
@end
