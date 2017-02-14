//
//  IH_TimeTypeCell.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/17.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemEvent;

@protocol IH_TimeTypeCellDelegate <NSObject>

/**
 *  timeInterval:变化的秒数 date:改变后的时间 indexPath:indexPath
 */
- (void)IH_TimeTypeCellStartTimeChange:(NSTimeInterval)timeInterval changedDate:(NSString *)dateStr indexPath:(NSIndexPath *)indexPath;

@end

@interface IH_TimeTypeCell : UITableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,weak)id<IH_TimeTypeCellDelegate> delegate;
@property(nonatomic,strong)ItemEvent *itemEvent;
@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,assign)NSInteger datePickerTypeTag;//1:UIDatePickerModeDateAndTime  2.UIDatePickerModeDate

@end
