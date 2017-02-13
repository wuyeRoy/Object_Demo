//
//  IH_QRCodeViewController.m
//  QRCodeDemo
//
//  Created by WYRoy on 17/1/12.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//
#define imageWH 52
#define titleH 30
#import "IH_QRCodeViewController.h"
#import "UIView+Extension.h"
#import "IH_ScanningQRCodeViewController.h"
#import "IH_QRCodeModel.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
@interface SCanningButton : UIButton

@end
@implementation SCanningButton

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
    return CGRectMake(0, 0, imageWH, imageWH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height - titleH , contentRect.size.width, titleH);
}
@end


@interface IH_QRCodeViewController ()
@property(nonatomic,weak)UIImageView *qrImageView;//生成的二维码
@property(nonatomic,weak)UILabel *desLab;//@"扫描二维码"
@property(nonatomic,weak)SCanningButton *scanBtn;//扫一扫按钮

@end

@implementation IH_QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"二维码";
    [self setUpBody];
    
    //生成二维码
    [self setUpGenerateQRCode];
}

#pragma mark - setUp
-(void)setUpBody
{
    //QR ImageView--
    CGFloat intervX = 50;
    CGFloat imageW = self.view.Width - intervX * 2;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(intervX, 30+64, imageW, imageW)];
    [self.view addSubview:imageView];
    self.qrImageView = imageView;
    
    //UIlab
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(intervX, CGRectGetMaxY(imageView.frame), imageW, 44)];
    lab.text = @"扫描二维码";
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    self.desLab = lab;
    
    //scanning Btn
    CGFloat btnW = 52;
    CGFloat btnH = 85;
    CGFloat btnX = (self.view.Width - btnW)/2.0;
    CGFloat btnY = self.view.Height - 30 - btnH;
    SCanningButton *scanBtn = [[SCanningButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    [scanBtn setImage:[UIImage imageNamed:@"IH_QRCodeScanning"] forState:UIControlStateNormal];
    [scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [scanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    scanBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [scanBtn addTarget:self action:@selector(scanBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
    self.scanBtn = scanBtn;
}

-(void)setUpGenerateQRCode
{
    CGFloat intervX = 50;
    CGFloat imageW = self.view.Width - intervX * 2;
    // 2、将CIImage转换成UIImage，并放大显示
    self.qrImageView.image = [IH_QRCodeModel IH_GenerateWithDefaultQRCodeData:@"https://github.com/kingsic" imageViewWidth:imageW];
    
    //模仿支付宝二维码样式（添加用户头像）
    CGFloat scale = 0.22;
    CGFloat borderW = 5;
    UIView *borderView = [[UIView alloc] init];
    CGFloat borderViewW = imageW * scale;
    CGFloat borderViewH = imageW * scale;
    CGFloat borderViewX = 0.5 * (imageW - borderViewW);
    CGFloat borderViewY = 0.5 * (imageW - borderViewH);
    borderView.frame = CGRectMake(borderViewX, borderViewY, borderViewW, borderViewH);
    borderView.layer.borderWidth = borderW;
    borderView.layer.borderColor = [UIColor purpleColor].CGColor;
    borderView.layer.cornerRadius = 10;
    borderView.layer.masksToBounds = YES;
    borderView.layer.contents = (id)[UIImage imageNamed:@"icon_image"].CGImage;
    //    [imageView addSubview:borderView];
}

-(void)scanBtnDidClick
{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        // 判断授权状态
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted) { // 因为家长控制, 导致应用无法访问相册(跟用户的选择没有关系)
            NSLog(@"因为系统原因, 无法访问相册");
        } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
            
            // 1、初始化UIAlertController
            UIAlertController *aC = [UIAlertController alertControllerWithTitle:@"⚠️ 警告" message:@"请去-> [设置 - 隐私 - 照片 - QRCodeDemo] 打开访问开关" preferredStyle:UIAlertControllerStyleAlert];
            
            // 2.设置UIAlertAction样式
            UIAlertAction *sureAc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            
            [aC addAction:sureAc];
            // 3.显示alertController:presentViewController
            [self presentViewController:aC animated:YES completion:nil];
            
        } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
            
            IH_ScanningQRCodeViewController *vc = [[IH_ScanningQRCodeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

        } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
            // 弹框请求用户授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                    
                }
            }];
        }
        
    } else {
        
        // 1、初始化UIAlertController
        UIAlertController *aC = [UIAlertController alertControllerWithTitle:@"⚠️ 警告" message:@"未检测到您的摄像头, 请在真机上测试" preferredStyle:UIAlertControllerStyleAlert];
        
        // 2.设置UIAlertAction样式
        UIAlertAction *sureAc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        
        [aC addAction:sureAc];
        // 3.显示alertController:presentViewController
        [self presentViewController:aC animated:YES completion:nil];

}
    
    
    
    
    
}
@end
