//
//  IH_TextFieldTypeCell.m
//  IHealthDemo
//
//  Created by WYRoy on 16/12/17.
//  Copyright © 2016年 ihefe－0006. All rights reserved.
//

#import "IH_TextFieldTypeCell.h"
#import "ItemEvent.h"
@interface IH_TextFieldTypeCell()

@property(nonatomic,weak)UITextField *textField;
@end


@implementation IH_TextFieldTypeCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"IH_TextFieldTypeCell";
    IH_TextFieldTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = IHWhiteColor;
        
        UITextField *textField = [[UITextField alloc] init];
        [self addSubview:textField];
        self.textField = textField;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textField.frame = CGRectMake(UITableViewCellLeftRightMargin, 0, self.Width - (UITableViewCellLeftRightMargin * 2), self.Height);
}


#pragma setter and getter
- (void)setItemEvent:(ItemEvent *)itemEvent
{
    _itemEvent = itemEvent;
    self.textField.placeholder = itemEvent.title;
    
}
@end
