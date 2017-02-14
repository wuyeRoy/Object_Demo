//
//  IH_SelectTableViewCell.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/19.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_SelectTableViewCell.h"
#import "SelectCellModel.h"
#import "CustomRepeat.h"
@interface IH_SelectTableViewCell ()

@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UIImageView *selectImageView;

@end

@implementation IH_SelectTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"IH_SelectTableViewCell";
    IH_SelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = IHWhiteColor;

        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = IHBlackColor;
        titleLab.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:titleLab];
        self.titleLab = titleLab;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.hidden = YES;
        imageView.image = [UIImage imageNamed:@"IH_HealthItem_Checkmark"];
        [self addSubview:imageView];
        self.selectImageView = imageView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageViewW = 13;
    CGFloat imageViewX = self.Width - UITableViewCellLeftRightMargin - imageViewW;
    CGFloat imageViewH = 11;
    CGFloat imageViewY = (self.Height-imageViewH)/2.0;
    self.selectImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
    CGFloat titleX = UITableViewCellLeftRightMargin;
    CGFloat titleW = imageViewX - titleX;
    CGFloat titleH = self.Height;
    self.titleLab.frame = CGRectMake(titleX, 0, titleW, titleH);
}

#pragma mark - setter and getter
- (void)setSelectModel:(SelectCellModel *)selectModel
{
    _selectModel = selectModel;
    self.titleLab.text = selectModel.title;
    self.selectImageView.hidden = !self.selectModel.isSelect;
}

-(void)setRepeat:(CustomRepeat *)repeat
{
    _repeat = repeat;
    self.titleLab.text = repeat.title;
    self.selectImageView.hidden = !self.repeat.isSelect;
}
@end
