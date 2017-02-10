//
//  TableViewCell.m
//  WY_FoldTableView[类似QQ分组效果]
//
//  Created by WYRoy on 17/2/9.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//

#import "TableViewCell.h"
#import "CellModel.h"
@interface TableViewCell()

@end
@implementation TableViewCell

+(instancetype) cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TableViewCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

#pragma mark - setter and getter
-(void)setModel:(CellModel *)model
{
    _model = model;
    self.textLabel.text = model.name;
}

@end
