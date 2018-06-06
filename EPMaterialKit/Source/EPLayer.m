//
//  EPLayer.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 29.04.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "EPLayer.h"

@interface EPLayer () {

}

@property (nonatomic, strong) CALayer *superLayer;
@property (nonatomic, strong) CALayer *rippleLayer;
@property (nonatomic, strong) CALayer *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@interface EPLayer (PrivateMethods)

- (void)setCircleLayerLocationAt:(CGPoint)center;
- (void)animateShadowForLayer:(CALayer *)layer
                   fromRadius:(CGFloat)fromRadius
                     toRadius:(CGFloat)toRadius
                  fromOpacity:(CGFloat)fromOpacity
                    toOpacity:(CGFloat)toOpacity
           withTimingFunction:(EPTimingFunction)timingFunction
                 withDuration:(CFTimeInterval)duration;

@end

@implementation EPLayer

#pragma mark - Static methods

+ (CAMediaTimingFunction *)timingFunctionForFunctionType:(EPTimingFunction)functionType
{
    switch (functionType) {
        case EPTimingFunctionLinear:
            return [CAMediaTimingFunction functionWithName:@"linear"];
        case EPTimingFunctionEaseIn:
            return [CAMediaTimingFunction functionWithName:@"easeIn"];
        case EPTimingFunctionEaseOut:
            return [CAMediaTimingFunction functionWithName:@"easeOut"];
        default:
            return nil;
    }
}

#pragma mark - Instance and view lifetime methods

- (id)initWithSuperLayer:(CALayer *)superLayer
{
    self = [super init];
    if (self) {
        self.superLayer = superLayer;
        
        CGFloat superLayerWidth = CGRectGetWidth(superLayer.bounds);
        CGFloat superLayerHeight = CGRectGetHeight(superLayer.bounds);
        
        // Background layer
        self.backgroundLayer = [CALayer layer];
        self.backgroundLayer.frame = superLayer.bounds;
        self.backgroundLayer.opacity = 0.0;
        [self.superLayer addSublayer:self.backgroundLayer];
        
        // Circle layer
        self.ripplePercent = 0.9;
        self.rippleLocation = EPRippleLocationTapLocation;
        CGFloat circleSize = (CGFloat)(MAX(superLayerWidth, superLayerHeight) * self.ripplePercent);
        CGFloat circleCornerRadius = circleSize / 2;
        
        self.rippleLayer = [CALayer layer];
        self.rippleLayer.opacity = 0.0;
        self.rippleLayer.cornerRadius = circleCornerRadius;
        [self setCircleLayerLocationAt:CGPointMake(superLayerWidth / 2, superLayerHeight / 2)];
        [self.backgroundLayer addSublayer:self.rippleLayer];
        
        // Mask layer
        self.maskLayer = [CAShapeLayer layer];
        [self setMaskLayerCornerRadius:superLayer.cornerRadius];
        [self.backgroundLayer setMask:self.maskLayer];
    }
    return self;
}

#pragma mark - Setters

- (void)setMaskLayerCornerRadius:(CGFloat)cornerRadius
{
    self.maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.backgroundLayer.bounds cornerRadius:cornerRadius].CGPath;
}

- (void)setRippleLocation:(EPRippleLocation)rippleLocation
{
    _rippleLocation = rippleLocation;
    CGPoint origin = CGPointZero;
    switch (self.rippleLocation)
    {
        case EPRippleLocationCenter:
            origin = CGPointMake(self.superLayer.bounds.size.width / 2, self.superLayer.bounds.size.height / 2);
            break;
        case EPRippleLocationLeft:
            origin = CGPointMake(self.superLayer.bounds.size.width * 0.25, self.superLayer.bounds.size.height / 2);
            break;
        case EPRippleLocationRight:
            origin = CGPointMake(self.superLayer.bounds.size.width * 0.75, self.superLayer.bounds.size.height / 2);
            break;
        default:
            break;
    }
    if (!CGPointEqualToPoint(origin, CGPointZero)) {
        [self setCircleLayerLocationAt:origin];
    }
}

- (void)setRipplePercent:(CGFloat)ripplePercent
{
    _ripplePercent = ripplePercent;
    if (self.ripplePercent > 0) {
        CGFloat width = CGRectGetWidth(self.superLayer.bounds);
        CGFloat height = CGRectGetHeight(self.superLayer.bounds);
        CGFloat circleSize = (CGFloat)(MAX(width, height) * self.ripplePercent);
        self.rippleLayer.cornerRadius = circleSize / 2;
        [self setCircleLayerLocationAt:CGPointMake(width / 2, height / 2)];
    }
}

- (void)superLayerDidResize
{
    [CATransaction begin];
    [CATransaction setDisableActions:true];
    self.backgroundLayer.frame = self.superLayer.bounds;
    [self setMaskLayerCornerRadius:self.superLayer.cornerRadius];
    [CATransaction commit];
    [self setRippleLocation:self.rippleLocation];
//    [self setCircleLayerLocationAt:CGPointMake(self.superLayer.bounds.size.width / 2, self.superLayer.bounds.size.height / 2)];
}

- (void)enableOnlyCircleLayer
{
    [self.backgroundLayer removeFromSuperlayer];
    [self.superLayer addSublayer:self.rippleLayer];
}

- (void)setBackgroundLayerColor:(UIColor *)color
{
    self.backgroundLayer.backgroundColor = color.CGColor;
}

- (void)setCircleLayerColor:(UIColor *)color
{
    self.rippleLayer.backgroundColor = color.CGColor;
}

- (void)didChangeTapLocation:(CGPoint)location
{
    if (self.rippleLocation == EPRippleLocationTapLocation) {
        [self setCircleLayerLocationAt:location];
    }
}

- (void)enableMask:(BOOL)enable
{
    self.backgroundLayer.mask = enable ? self.maskLayer : nil;
}

- (void)setBackgroundLayerCornerRadius:(CGFloat)cornerRadius
{
    self.backgroundLayer.cornerRadius = cornerRadius;
}

- (void)animateScaleForCircleLayer:(CGFloat)fromScale
                           toScale:(CGFloat)toScale
                withTimingFunction:(EPTimingFunction)timingFunction
                      withDuration:(CFTimeInterval)duration
{
    CABasicAnimation *rippleLayerAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    rippleLayerAnim.fromValue = @(fromScale);
    rippleLayerAnim.toValue = @(toScale);
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = @(1.0);
    opacityAnim.toValue = @(0.0);
    
    CAAnimationGroup *groupAnim = [CAAnimationGroup animation];
    groupAnim.duration = duration;
    groupAnim.timingFunction = [EPLayer timingFunctionForFunctionType:timingFunction];
    groupAnim.removedOnCompletion = FALSE;
    groupAnim.fillMode = kCAFillModeForwards;
    groupAnim.animations = [NSArray arrayWithObjects:rippleLayerAnim, opacityAnim, nil];
    [self.rippleLayer addAnimation:groupAnim forKey: nil];
}

- (void)animateAlphaForBackgroundLayer:(EPTimingFunction)timingFunction
                          withDuration:(CFTimeInterval)duration
{
    CABasicAnimation *backgroundLayerAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    backgroundLayerAnim.fromValue = @(1.0);
    backgroundLayerAnim.toValue = @(0.0);
    backgroundLayerAnim.duration = duration;
    backgroundLayerAnim.timingFunction = [EPLayer timingFunctionForFunctionType:timingFunction];
    [self.backgroundLayer addAnimation:backgroundLayerAnim forKey: nil];
}

- (void)animateSuperLayerShadow:(CGFloat)fromRadius
                       toRadius:(CGFloat)toRadius
                    fromOpacity:(CGFloat)fromOpacity
                      toOpacity:(CGFloat)toOpacity
             withTimingFunction:(EPTimingFunction)timingFunction
                   withDuration:(CFTimeInterval)duration
{
    [self animateShadowForLayer:self.superLayer
                     fromRadius:fromRadius
                       toRadius:toRadius
                    fromOpacity:fromOpacity
                      toOpacity:toOpacity
             withTimingFunction:timingFunction
                   withDuration:duration];
}

@end

#pragma mark - Private methods

@implementation EPLayer (PrivateMethods)

- (void)setCircleLayerLocationAt:(CGPoint)center
{
    CGFloat width = CGRectGetWidth(self.superLayer.bounds);
    CGFloat height = CGRectGetHeight(self.superLayer.bounds);
    CGFloat subSize = (CGFloat)(MAX(width, height) * self.ripplePercent);
    CGFloat subX = center.x - subSize/2;
    CGFloat subY = center.y - subSize/2;
    
    // disable animation when changing layer frame
    [CATransaction begin];
    [CATransaction setDisableActions:true];
    self.rippleLayer.cornerRadius = subSize / 2;
    self.rippleLayer.frame = CGRectMake(subX, subY, subSize, subSize);
    [CATransaction commit];
}

- (void)animateShadowForLayer:(CALayer *)layer
                   fromRadius:(CGFloat)fromRadius
                     toRadius:(CGFloat)toRadius
                  fromOpacity:(CGFloat)fromOpacity
                    toOpacity:(CGFloat)toOpacity
           withTimingFunction:(EPTimingFunction)timingFunction
                 withDuration:(CFTimeInterval)duration
{
    CABasicAnimation *radiusAnimation = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
    radiusAnimation.fromValue = @(fromRadius);
    radiusAnimation.toValue = @(toRadius);
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    opacityAnimation.fromValue = @(fromOpacity);
    opacityAnimation.toValue = @(toOpacity);
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = duration;
    groupAnimation.timingFunction = [EPLayer timingFunctionForFunctionType:timingFunction];
    groupAnimation.removedOnCompletion = FALSE;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.animations = [NSArray arrayWithObjects:radiusAnimation, opacityAnimation, nil];
    [layer addAnimation:groupAnimation forKey:nil];
}

@end
