//
//  NSString+Extension.h
//  IHealthDemo
//
//  Created by WYRoy on 16/12/21.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  得到 字体 size
 */
- (CGSize) sizeWithFont : (UIFont *) font andMaxSize :(CGSize) maxSize;

@end
