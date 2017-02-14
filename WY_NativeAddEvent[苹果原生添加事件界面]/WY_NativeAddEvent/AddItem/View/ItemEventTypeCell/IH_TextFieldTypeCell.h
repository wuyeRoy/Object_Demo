//
//  IH_TextFieldTypeCell.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/17.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemEvent;
@interface IH_TextFieldTypeCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)ItemEvent *itemEvent;

@end
