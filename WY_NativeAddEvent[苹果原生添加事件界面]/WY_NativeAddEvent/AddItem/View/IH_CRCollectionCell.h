//
//  IH_CRCollectionTypeCell.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/22.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectCellModel;

@protocol IH_CRCollectionCellDelegate <NSObject>

/**
  点击了item
 */
- (void)IH_CRCollectionCellDidClickItem:(NSIndexPath *)indexpath;

@end
@interface IH_CRCollectionCell : UICollectionViewCell

@property(nonatomic,strong)SelectCellModel *model;

@property(nonatomic,weak)id<IH_CRCollectionCellDelegate> delegate;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end
