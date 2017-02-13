//
//  IH_QRCodeModel.h
//  QRCodeDemo
//
//  Created by WYRoy on 17/1/12.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

@interface IH_QRCodeModel : NSObject

/** 生成一张普通的二维码 */
+ (UIImage *)IH_GenerateWithDefaultQRCodeData:(NSString *)data imageViewWidth:(CGFloat)imageViewWidth;

/** 生成一张带有logo的二维码（logoScaleToSuperView：相对于父视图的缩放比取值范围0-1；0，不显示，1，代表与父视图大小相同） */
+ (UIImage *)IH_GenerateWithLogoQRCodeData:(NSString *)data logoImageName:(NSString *)logoImageName logoScaleToSuperView:(CGFloat)logoScaleToSuperView;
/** 生成一张彩色的二维码 */
+ (UIImage *)IH_GenerateWithColorQRCodeData:(NSString *)data backgroundColor:(CIColor *)backgroundColor mainColor:(CIColor *)mainColor;

@end
