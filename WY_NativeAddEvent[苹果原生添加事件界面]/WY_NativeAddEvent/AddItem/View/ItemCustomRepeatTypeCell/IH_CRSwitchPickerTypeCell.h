//
//  IH_CRSwitchPickerTypeCell.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/22.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomRepeat;

@protocol IH_CRSwitchPickerTypeCellDelegate <NSObject>


/**
 选中第几个星期几

 @param selectStr 第几个星期几
 */
-(void)IH_CRSwitchPickerTypeCellSelectValue:(NSString *)selectStr;

/**
 Switch  打开 或 关闭
 */
- (void)IH_CRSwitchPickerTypeCellSwitchValueChange;

@end
@interface IH_CRSwitchPickerTypeCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)CustomRepeat *repeat;

@property(nonatomic,weak)id<IH_CRSwitchPickerTypeCellDelegate> delegate;
@end
