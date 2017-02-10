//
//  HeadView.h
//  WY_FoldTableView[类似QQ分组效果]
//
//  Created by WYRoy on 17/2/9.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SectionModel;

typedef void(^HeadViewClickCallBack)(BOOL isOpen);
@interface HeadView : UITableViewHeaderFooterView
+(instancetype)headWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)SectionModel *model;
@property(nonatomic,copy)HeadViewClickCallBack headClickCallBack;
@end
