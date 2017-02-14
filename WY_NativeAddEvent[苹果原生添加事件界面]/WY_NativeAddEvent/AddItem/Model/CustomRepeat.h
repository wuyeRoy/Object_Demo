//
//  CustomRepeat.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/21.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, CustomRepeatCellStype)
{
    //easy--
    CustomRepeatSelectTypeCell,//右边打勾 类型
    CustomRepeatPickerTypeCell,// pickerView 类型
    CustomRepeatCollectionDayTypeCell,//Collection 日期（正方形）类型
    CustomRepeatCollectionMonthTypeCell,// Collection 月份（长方形）类型
    
    //complex-
    CustomRepeatLableAndPickerTypeCell,//lable + pickerView 类型
    CustomRepeatSwitchAndPickerTypeCell,//switch + pickerView 类型
};
@interface CustomRepeat : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *value;

/**
 是否展开
 */
@property(nonatomic,assign)BOOL isOpen;

/**
 是否选中
 */
@property(nonatomic,assign)BOOL isSelect;

@property(nonatomic,assign)CustomRepeatCellStype cellType;
/**
 天／周／月／年
 */
@property(nonatomic,copy)NSString *unitStr;
@end
