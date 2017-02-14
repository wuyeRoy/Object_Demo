//
//  NSString+Extension.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/21.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
/**
 *  得到 字体 size
 */
- (CGSize) sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize{
    
    NSDictionary *attr = @{NSFontAttributeName : font };
    
    return   [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}
@end
