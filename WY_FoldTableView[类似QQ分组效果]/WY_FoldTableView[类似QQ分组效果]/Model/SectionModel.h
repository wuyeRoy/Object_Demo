//
//  SectionModel.h
//  WY_FoldTableView[类似QQ分组效果]
//
//  Created by WYRoy on 17/2/9.
//  Copyright © 2017年 ihefe－0006. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSArray *subArray;
@property(nonatomic,assign)BOOL open;
@end
