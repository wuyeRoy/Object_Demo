//
//  ViewController.m
//  QRCodeDemo
//
//  Created by WYRoy on 17/1/12.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//

#import "ViewController.h"
#import "IH_QRCodeViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    

    [self setQRCode];
}

-(void)setQRCode
{
    //1.生成二维码
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 150, 50)];
    [btn1 setTitle:@"点我点我！！！" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1DidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

}

-(void)btn1DidClick
{
    IH_QRCodeViewController *vc = [[IH_QRCodeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
