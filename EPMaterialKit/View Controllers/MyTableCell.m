//
//  MyTableCell.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 29.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "MyTableCell.h"

@implementation MyTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setLayoutMargins:(UIEdgeInsets)layoutMargins
{
    [super setLayoutMargins:layoutMargins];
}

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

#pragma mark - Public methods

- (void)setMessage:(NSString *)messageString
{
    self.labelMessage.text = messageString;
    [self setNeedsDisplay];
}

@end
