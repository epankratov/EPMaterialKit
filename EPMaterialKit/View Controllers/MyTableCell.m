//
//  MyTableCell.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 29.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "MyTableCell.h"

@implementation MyTableCell

- (void)awakeFromNib
{
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setLayoutMargins:(UIEdgeInsets)layoutMargins
{
    [super setLayoutMargins:layoutMargins];
}

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

- (void)setMessage:(NSString *)messageString
{
    self.messageLabel.text = messageString;
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [_messageLabel release];
    [super dealloc];
}

@end
