//
//  EPTableViewCell.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 29.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "EPTableViewCell.h"

@interface EPTableViewCell () {

}

@property (nonatomic, strong) EPLayer *epLayer;
@property (nonatomic, assign) BOOL contentViewResized;

@end

@interface EPTableViewCell (PrivateMethods)

- (void)setupLayer;

@end

@implementation EPTableViewCell

#pragma mark - Designated initializers

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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

- (void)setRippleLocation:(EPRippleLocation)rippleLocation
{
    _rippleLocation = rippleLocation;
    self.epLayer.rippleLocation = rippleLocation;
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

#pragma mark - Touches handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *firstTouch = [touches anyObject];
    if (firstTouch != nil) {
        if (!self.contentViewResized) {
            [self.epLayer superLayerDidResize];
            self.contentViewResized = TRUE;
        }
        [self.epLayer didChangeTapLocation:[firstTouch locationInView:self.contentView]];
        [self.epLayer animateScaleForCircleLayer:0.65 toScale:1.0 withTimingFunction:self.rippleAniTimingFunction withDuration:self.rippleAniDuration];
        [self.epLayer animateAlphaForBackgroundLayer:EPTimingFunctionLinear withDuration:self.backgroundAniDuration];
    }
}

#pragma mark - Private methods

- (void)setupLayer
{
    self.epLayer = [[EPLayer alloc] initWithSuperLayer:self.layer];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentViewResized = FALSE;
    self.rippleLocation = EPRippleLocationTapLocation;
    self.rippleAniDuration = 0.75;
    self.backgroundAniDuration = 1.0;
    self.rippleAniTimingFunction = EPTimingFunctionLinear;
    self.shadowAniEnabled = TRUE;
    self.rippleLayerColor = [UIColor colorWithWhite:0.45f alpha:0.5];
    self.backgroundLayerColor = [UIColor colorWithWhite:0.75 alpha:0.25];
    self.epLayer.ripplePercent = 1.2;
}

@end
