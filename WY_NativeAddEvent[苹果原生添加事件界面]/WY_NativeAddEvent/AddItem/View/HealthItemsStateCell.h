//
//  HealthItemsStateCell.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/7.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HealthItems;
@protocol HealthItemsStateCellDelegate <NSObject>

-(void)healthItemsStateCellSelected:(NSIndexPath *)indexPath;
@end

@interface HealthItemsStateCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)HealthItems *item;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,weak)id<HealthItemsStateCellDelegate> delegate;
@end
