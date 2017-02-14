//
//  IH_CRPickerTypeCell.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/22.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomRepeat;

@protocol IH_CRPickerTypeCellDelegate <NSObject>


/**
 选中了第几个星期
 */
- (void) IH_CRPickerTypeCellSelectValue:(NSString *)value;

@end
@interface IH_CRPickerTypeCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)CustomRepeat *repeat;

@property(nonatomic,weak)id<IH_CRPickerTypeCellDelegate> delegate;
@end
