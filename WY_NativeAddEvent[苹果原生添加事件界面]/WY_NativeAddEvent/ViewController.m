//
//  ViewController.m
//  WY_NativeAddEvent
//
//  Created by WYRoy on 17/2/14.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//

#import "ViewController.h"
#import "IH_AddItemsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"首页";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnClick)];
}

- (void)rightBarBtnClick{
 
    IH_AddItemsViewController *vc = [[IH_AddItemsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
