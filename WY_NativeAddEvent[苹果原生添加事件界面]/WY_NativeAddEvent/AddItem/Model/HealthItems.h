//
//  HealthItems.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/2.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HealthItems : NSObject

@property(nonatomic,copy)NSString *time;//时间
@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,copy)NSString *content;//内容描述
@property(nonatomic,copy)NSString *state;//状态

@property(nonatomic,copy)NSString *target;//妈妈or宝宝


//0:正常状态  1：日期  2:状态
@property(nonatomic,assign)int cellType;
@end
