//
//  IH_ScanSuccessJumpViewController.h
//  QRCodeDemo
//
//  Created by WYRoy on 17/1/12.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IH_ScanSuccessJumpViewController : UIViewController

/** 接收扫描的二维码信息 */
@property (nonatomic, copy) NSString *jump_URL;
/** 接收扫描的条形码信息 */
@property (nonatomic, copy) NSString *jump_bar_code;

@end
