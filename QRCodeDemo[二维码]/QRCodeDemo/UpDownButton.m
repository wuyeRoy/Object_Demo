//
//  UpDownButton.m
//  iHealth
//
//  Created by WYRoy on 16/9/29.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "UpDownButton.h"
#define imageWH 25
#define titleH 18

@implementation UpDownButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
     return CGRectMake((contentRect.size.width-imageWH)/2.0, (contentRect.size.height - (imageWH + titleH))/2.0, imageWH, imageWH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, (contentRect.size.height - (imageWH + titleH))/2.0 + imageWH, contentRect.size.width, titleH);
}
@end
