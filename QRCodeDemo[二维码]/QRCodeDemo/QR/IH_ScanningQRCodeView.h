//
//  IH_ScanningQRCodeView.h
//  QRCodeDemo
//
//  Created by WYRoy on 17/1/12.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IH_ScanningQRCodeView : UIView

- (instancetype)initWithFrame:(CGRect)frame outsideViewLayer:(CALayer *)outsideViewLayer;

+ (instancetype)scanningQRCodeViewWithFrame:(CGRect )frame outsideViewLayer:(CALayer *)outsideViewLayer;

/** 移除定时器(切记：一定要在Controller视图消失的时候，停止定时器) */
- (void)removeTimer;
@end
