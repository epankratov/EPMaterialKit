//
//  EPLayer.h
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 29.04.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    Linear,
    EaseIn,
    EaseOut
} EPTimingFunction;

typedef enum {
    Center,
    Left,
    Right,
    TapLocation
} EPRippleLocation;

@interface EPLayer : NSObject {
    CALayer *_superLayer;
    CALayer *_rippleLayer;
    CALayer *_backgroundLayer;
    CAShapeLayer *_maskLayer;
}

@property (nonatomic, setter=setRippleLocation:) EPRippleLocation rippleLocation;
@property (nonatomic, setter=setRipplePercent:) CGFloat ripplePercent;

+ (CAMediaTimingFunction *)timingFunctionForFunctionType:(EPTimingFunction)functionType;
- (id)initWithSuperLayer:(CALayer *)superLayer;
- (void)setMaskLayerCornerRadius:(CGFloat)cornerRadius;
- (void)superLayerDidResize;
- (void)enableOnlyCircleLayer;
- (void)setBackgroundLayerColor:(UIColor *)color;
- (void)setCircleLayerColor:(UIColor *)color;
- (void)didChangeTapLocation:(CGPoint)location;
- (void)enableMask:(BOOL)enable;
- (void)setBackgroundLayerCornerRadius:(CGFloat)cornerRadius;
- (void)animateScaleForCircleLayer:(CGFloat)fromScale
                           toScale:(CGFloat)toScale
                withTimingFunction:(EPTimingFunction)timingFunction
                      withDuration:(CFTimeInterval)duration;
- (void)animateAlphaForBackgroundLayer:(EPTimingFunction)timingFunction
                          withduration:(CFTimeInterval)duration;
- (void)animateSuperLayerShadow:(CGFloat)fromRadius
                       toRadius:(CGFloat)toRadius
                    fromOpacity:(CGFloat)fromOpacity
                      toOpacity:(CGFloat)toOpacity
             withTimingFunction:(EPTimingFunction)timingFunction
                   withduration:(CFTimeInterval)duration;

@end