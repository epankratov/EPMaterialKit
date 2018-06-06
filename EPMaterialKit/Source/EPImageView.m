//
//  EPImageView.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 05.06.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "EPImageView.h"

@interface EPImageView () {

}

@property (nonatomic, strong) EPLayer *epLayer;

@end

@interface EPImageView (PrivateMethods)

- (void)setupLayer;

@end

@implementation EPImageView

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

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        [self setupLayer];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    self = [super initWithImage:image highlightedImage:highlightedImage];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *firstTouch = [touches anyObject];
    if (firstTouch != nil) {
        CGPoint location = [firstTouch locationInView:self];
        [self animateRipple:location];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - Public methods

- (void)animateRipple:(CGPoint)location
{
    if (!CGPointEqualToPoint(location, CGPointZero)) {
        [self.epLayer didChangeTapLocation:location];
    }
    
    [self.epLayer animateScaleForCircleLayer:0.65f toScale:1.0f withTimingFunction:self.rippleAniTimingFunction withDuration:self.aniDuration];
    [self.epLayer animateAlphaForBackgroundLayer:self.backgroundAniTimingFunction withDuration:self.aniDuration];
}

#pragma mark - Private methods

- (void)setupLayer
{
    self.epLayer = [[EPLayer alloc] initWithSuperLayer:self.layer];
    self.maskEnabled = TRUE;
    self.rippleLocation = EPRippleLocationTapLocation;
    self.ripplePercent = 0.9f;
    self.backgroundAniEnabled = TRUE;
    self.aniDuration = 0.65f;
    self.rippleAniTimingFunction = EPTimingFunctionLinear;
    self.backgroundAniTimingFunction = EPTimingFunctionLinear;
    self.cornerRadius = 2.5;
    self.rippleLayerColor = [UIColor colorWithWhite:0.45f alpha:0.5f];
    self.backgroundLayerColor = [UIColor colorWithWhite:0.75f alpha:0.25f];
    [self.epLayer setMaskLayerCornerRadius:self.cornerRadius];
}

@end
