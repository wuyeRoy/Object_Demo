//
//  LeftRightButton.m
//  iHealth
//
//  Created by WYRoy on 16/9/29.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "LeftRightButton.h"
#define imageWH 8
#define titleH 18

@implementation LeftRightButton
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    
//    return CGRectMake((contentRect.size.width-imageWH)/2.0, (contentRect.size.height - (imageWH + titleH))/2.0, imageWH, imageWH);
//}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect titleF = self.titleLabel.frame;
    CGRect imageF = self.imageView.frame;
    titleF.origin.x = (self.frame.size.width - (titleF.size.width + imageF.size.width + 2))/2.0;
    self.titleLabel.frame = titleF;
    imageF.origin.x = CGRectGetMaxX(titleF) + 2;
    self.imageView.frame = imageF;
}
@end
