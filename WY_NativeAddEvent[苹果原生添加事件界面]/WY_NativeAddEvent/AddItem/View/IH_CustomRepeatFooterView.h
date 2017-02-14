//
//  IH_CustomRepeatFooterView.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/21.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IH_CustomRepeatFooterView : UITableViewHeaderFooterView
+(instancetype)footWithTableView:(UITableView *)tableView;

@property(nonatomic,copy)NSString *descripStr;
@end
