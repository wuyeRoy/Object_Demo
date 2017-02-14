//
//  IH_CRCollectionDayTypeCell.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/22.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomRepeat;
@protocol IH_CRCollectionDayTypeCellDelegate <NSObject>
/**
 选中了哪几天/那几个月
 */
-(void)IH_CRCollectionDayTypeCellDidClickDays:(NSString *)dayStr type:(NSInteger)typeTag;

@end

@interface IH_CRCollectionDayTypeCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

/**
 根据开始时间 默认选中 日期
 */
//@property(nonatomic,copy)NSString *starTime;//开始时间

@property(nonatomic,strong)CustomRepeat *repeat;

@property(nonatomic,weak)id<IH_CRCollectionDayTypeCellDelegate> delegate;

@property(nonatomic,assign)NSInteger typeTag;//1:天数（eg:"1日"）   2:月份数(eg:"1月")
@end
