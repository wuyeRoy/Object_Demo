//
//  HealthItemsCell.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/2.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HealthItems;
@protocol HealthItemsCellDelegate <NSObject>

-(void)healthItemsCellStateBtnClick:(NSIndexPath *)indexPath;

-(void)healthItemsCellTimeBtnClick:(NSIndexPath *)indexPath;

@end

@interface HealthItemsCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)HealthItems *item;

@property(nonatomic,weak)id<HealthItemsCellDelegate> delegate;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end
