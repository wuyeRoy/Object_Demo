//
//  ItemEvent.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/15.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ItemEventTableViewCellStype)
{
    ItemEventTextFieldTypeCell,//输入框 类型
    ItemEventSelectTypeCell,//从下一个页面选择 类型
    ItemEventSwitchTypeCell,//开关按钮 类型
    ItemEventTimeTypeCell,//时间 类型
};
@interface ItemEvent : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *value;

/**
 [重复－自定义]才有: 关于重复的描述
 */
@property(nonatomic,copy)NSString *describeValue;
/**
 [重复－自定义]才有: 自定义重复页面的数据源
 */
@property(nonatomic,strong)NSMutableArray *customRepeatArray;

//[结束 重复] 才有: 记录开始时间
@property(nonatomic,copy)NSString *starTimeValue;

@property(nonatomic,assign)ItemEventTableViewCellStype type;

@property(nonatomic,copy)NSString *pushToVC;//前往哪个页面

@property(nonatomic,assign)BOOL isOpen;//是否展开datePicker

@property(nonatomic,copy)NSString *format;//时间格式

@end
