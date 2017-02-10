//
//  TableViewCell.h
//  WY_FoldTableView[类似QQ分组效果]
//
//  Created by WYRoy on 17/2/9.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellModel;
@interface TableViewCell : UITableViewCell

+(instancetype) cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)CellModel *model;
@end
