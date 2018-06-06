//
//  EPButton.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 15.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "EPButton.h"

@interface EPButton () {

}

@property (nonatomic, strong) EPLayer *epLayer;

@end

@interface EPButton (PrivateMethods)

- (void)setupLayer;

@end

@implementation EPButton

#pragma mark - Designated initializers

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

#pragma mark - Setters

- (void)setMaskEnabled:(BOOL)maskEnabled
{
    _maskEnabled = maskEnabled;
    [self.epLayer enableMask:maskEnabled];
}

- (void)setRippleLocation:(EPRippleLocation)rippleLocation
{
    _rippleLocation = rippleLocation;
    [self.epLayer setRippleLocation:rippleLocation];
}

- (void)setRipplePercent:(CGFloat)ripplePercent
{
    _ripplePercent = ripplePercent;
    [self.epLayer setRipplePercent:ripplePercent];
}

- (void)setBackgroundLayerCornerRadius:(CGFloat)backgroundLayerCornerRadius
{
    _backgroundLayerCornerRadius = backgroundLayerCornerRadius;
    [self.epLayer setBackgroundLayerCornerRadius:backgroundLayerCornerRadius];
}

- (void)setBackgroundAniEnabled:(BOOL)backgroundAniEnabled
{
    _backgroundAniEnabled = backgroundAniEnabled;
    if (!backgroundAniEnabled) {
        [self.epLayer enableOnlyCircleLayer];
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    [self.epLayer setMaskLayerCornerRadius:cornerRadius];
}

- (void)setRippleLayerColor:(UIColor *)rippleLayerColor
{
    _rippleLayerColor = rippleLayerColor;
    [self.epLayer setCircleLayerColor:rippleLayerColor];
}

- (void)setBackgroundLayerColor:(UIColor *)backgroundLayerColor
{
    _backgroundLayerColor = backgroundLayerColor;
    [self.epLayer setBackgroundLayerColor:backgroundLayerColor];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.epLayer superLayerDidResize];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    [self.epLayer superLayerDidResize];
}

#pragma mark - Touches handling

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.rippleLocation == EPRippleLocationTapLocation) {
        [self.epLayer didChangeTapLocation:[touch locationInView:self]];
    }
    
    // rippleLayer animation
    [self.epLayer animateScaleForCircleLayer:0.45 toScale:1.0 withTimingFunction:self.rippleAniTimingFunction withDuration:self.aniDuration];
    
    // backgroundLayer animation
    if (self.backgroundAniEnabled) {
        [self.epLayer animateAlphaForBackgroundLayer:self.backgroundAniTimingFunction withDuration:self.aniDuration];
    }
    
    // shadow animation for self
    if (self.shadowAniEnabled) {
        CGFloat shadowRadius = self.layer.shadowRadius;
        CGFloat shadowOpacity = self.layer.shadowOpacity;
        [self.epLayer animateSuperLayerShadow:10 toRadius:shadowRadius fromOpacity:0 toOpacity:shadowOpacity withTimingFunction:self.shadowAniTimingFunction withDuration:self.aniDuration];
    }
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}

#pragma mark - Private methods

- (void)setupLayer
{
    self.epLayer = [[EPLayer alloc] initWithSuperLayer:self.layer];
    self.adjustsImageWhenHighlighted = FALSE;
    self.maskEnabled = TRUE;
    self.rippleLocation = EPRippleLocationTapLocation;
    self.ripplePercent = 0.9f;
    self.backgroundLayerCornerRadius = 0.0f;
    self.shadowAniEnabled = TRUE;
    self.backgroundAniEnabled = TRUE;
    self.aniDuration = 0.65f;
    self.rippleAniTimingFunction = EPTimingFunctionLinear;
    self.backgroundAniTimingFunction = EPTimingFunctionLinear;
    self.shadowAniTimingFunction = EPTimingFunctionEaseOut;
    self.cornerRadius = 2.5;
    self.rippleLayerColor = [UIColor colorWithWhite:0.45f alpha:0.5f];
    self.backgroundLayerColor = [UIColor colorWithWhite:0.75f alpha:0.25f];
}

@end
