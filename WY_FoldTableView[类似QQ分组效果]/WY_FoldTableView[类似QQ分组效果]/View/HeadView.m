//
//  HeadView.m
//  WY_FoldTableView[类似QQ分组效果]
//
//  Created by WYRoy on 17/2/9.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//

#import "HeadView.h"
#import "UIView+Extension.h"
#import "SectionModel.h"
@interface HeadView()

@property(nonatomic,weak)UILabel *nameLab;
@property(nonatomic,weak)UIImageView *imageView;

@end

@implementation HeadView

+(instancetype)headWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HeadView";
    HeadView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!view) {
        view = [[[self class] alloc] initWithReuseIdentifier:ID];
    }
    return view;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = [UIColor blackColor];
        [self addSubview:lab];
        _nameLab = lab;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"arrow_down"];
        [self addSubview:imageView];
        _imageView = imageView;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTableHeaderView:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int interv = 15;
    CGFloat imageW = 15;

    _nameLab.frame = CGRectMake(interv, 0, self.Width - 2*interv - imageW, self.Height);
    
    CGFloat imageH = 8;
    _imageView.frame = CGRectMake(CGRectGetMaxX(_nameLab.frame), (self.Height-imageH)/2.0, imageW, imageH);
}

#pragma mark - 点击HeadView
- (void)clickTableHeaderView:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击了－－－");
    _model.open = !_model.open;
    
    [UIView animateWithDuration:0.5 animations:^{
        if (_model.open) {
            _imageView.transform = CGAffineTransformIdentity;
        }
        else
        {
            _imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
    }];
    
    //block 传值
    if (_headClickCallBack) {
        _headClickCallBack(_model.open);
    }
}

#pragma mark - setter and getter
- (void)setModel:(SectionModel *)model
{
    _model = model;
    _nameLab.text = model.name;
    [UIView animateWithDuration:0.5 animations:^{
        if (_model.open) {
            _imageView.transform = CGAffineTransformIdentity;
        }
        else
        {
            _imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
    }];
}
@end
