//
//  EPButton.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 15.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "EPButton.h"
#import "EPLayer.h"

@interface EPButton () {
    EPLayer *_epLayer;
}

@end

@interface EPButton (PrivateMethods)

- (void)setupLayer;

@end

@implementation EPButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayer];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupLayer];
    }
    return self;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    [_epLayer setMaskLayerCornerRadius:cornerRadius];
}

- (void)setRippleLayerColor:(UIColor *)rippleLayerColor
{
    [_epLayer setCircleLayerColor:rippleLayerColor];
}

#pragma mark - Private methods

- (void)setupLayer
{
    self.adjustsImageWhenHighlighted = FALSE;
    self.cornerRadius = 2.5;
    _epLayer = [[EPLayer alloc] initWithSuperLayer:self.layer];
//    [_epLayer setBackgroundLayerColor:self.backgroundLayerColor];
    [_epLayer setCircleLayerColor:self.rippleLayerColor];
}

@end
