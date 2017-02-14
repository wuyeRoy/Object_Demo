//
//  IH_CustomRepeatFooterView.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/21.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_CustomRepeatFooterView.h"

@interface IH_CustomRepeatFooterView ()

@property(nonatomic,weak)UILabel *textLab;

@end

@implementation IH_CustomRepeatFooterView

+(instancetype)footWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"IH_CustomRepeatFooterView";
    IH_CustomRepeatFooterView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (footView == nil) {
        footView = [[IH_CustomRepeatFooterView alloc] initWithReuseIdentifier:ID];
    }
    return footView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.tintColor = IHBackGroundColor;
        
        UILabel *textLab = [[UILabel alloc] init];
        textLab.textAlignment = NSTextAlignmentLeft;
        textLab.textColor = IHGrayTextColor;
        textLab.font = [UIFont systemFontOfSize:12];
        textLab.numberOfLines = 0;
        [textLab setBackgroundColor:IHBackGroundColor];
        [self addSubview:textLab];
        self.textLab = textLab;

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat labW = self.Width-(UITableViewCellLeftRightMargin*2);
    self.textLab.frame = CGRectMake(UITableViewCellLeftRightMargin, 0, labW, self.Height);
}

-(void)setDescripStr:(NSString *)descripStr
{
    _descripStr = descripStr;
    self.textLab.text = descripStr;
}
@end
