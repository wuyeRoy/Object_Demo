//
//  IH_CRFrequencyTypeCell.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/21.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomRepeat;

@protocol IH_CRFrequencyTypeCellDelegate <NSObject>

/**
 选中了频率类型

 @param typeStr 天／周／月／年
 */
- (void)IH_CRFrequencyTypeCellSelectedType:(NSString *)typeStr;


/**
 选中了数字

 @param number 1-999
 */
- (void)IH_CRFrequencyTypeCellSelectedNumber:(NSString *)number;

@end
@interface IH_CRFrequencyTypeCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)CustomRepeat *repeat;
@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,assign)NSInteger typeTag;//1:pickerView只有一列  2.两列
@property(nonatomic,weak)id<IH_CRFrequencyTypeCellDelegate> delegate;
@end
