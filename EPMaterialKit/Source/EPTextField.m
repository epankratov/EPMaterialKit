//
//  EPTextField.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 05.06.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "EPTextField.h"
#import "Global.h"

@interface EPTextField () {
}

@property (nonatomic, strong) EPLayer *epLayer;
@property (nonatomic, strong) UILabel *floatingLabel;
@property (nonatomic, strong) CALayer *bottomBorderLayer;

@end

@interface EPTextField (PrivateMethods)

- (void)setupLayer;
- (void)setFloatingLabelOverlapTextField;
- (void)showFloatingLabel;
- (void)hideFloatingLabel;

@end

@implementation EPTextField

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

#pragma mark - Public methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.floatingPlaceholderEnabled) {
        return;
    }
    
    if (self.text.length) {
        self.floatingLabel.textColor = [self isFirstResponder] ? self.tintColor : self.floatingLabelTextColor;
        if (self.floatingLabel.alpha == 0) {
            [self showFloatingLabel];
        }
    } else {
        [self hideFloatingLabel];
    }

    self.bottomBorderLayer.backgroundColor = [self isFirstResponder] ? self.tintColor.CGColor : self.bottomBorderColor.CGColor;
    CGFloat borderWidth = [self isFirstResponder] ? self.bottomBorderHighlightWidth : self.bottomBorderWidth;
    self.bottomBorderLayer.frame = CGRectMake(0, self.layer.bounds.size.height - borderWidth, self.layer.bounds.size.width, borderWidth);
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    CGRect newRect = CGRectMake(rect.origin.x + self.padding.width, rect.origin.y, rect.size.width - 2 * self.padding.width, rect.size.height);
    
    if (!self.floatingPlaceholderEnabled) {
        return newRect;
    }
    
    if (self.text.length) {
        CGFloat dTop = self.floatingLabel.font.lineHeight + self.floatingLabelBottomMargin;
        newRect = UIEdgeInsetsInsetRect(newRect, UIEdgeInsetsMake(dTop, 0.0, 0.0, 0.0));
    }
    return newRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

#pragma mark - Setters

- (void)setRippleLocation:(EPRippleLocation)rippleLocation
{
    _rippleLocation = rippleLocation;
    [self.epLayer setRippleLocation:rippleLocation];
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

- (void)setFloatingLabelFont:(UIFont *)floatingLabelFont
{
    _floatingLabelFont = floatingLabelFont;
    self.floatingLabel.font = floatingLabelFont;
}

- (void)setFloatingLabelTextColor:(UIColor *)floatingLabelTextColor
{
    _floatingLabelTextColor = floatingLabelTextColor;
    self.floatingLabel.textColor = floatingLabelTextColor;
}

- (void)setBottomBorderEnabled:(BOOL)bottomBorderEnabled
{
    _bottomBorderEnabled = bottomBorderEnabled;
    [self.bottomBorderLayer removeFromSuperlayer];
    self.bottomBorderLayer = nil;
    if (self.bottomBorderEnabled) {
        self.bottomBorderLayer = [CALayer layer];
        self.bottomBorderLayer.frame = CGRectMake(0, self.layer.bounds.size.height - 1, self.bounds.size.width, 1);
        self.bottomBorderLayer.backgroundColor = [UIColor Grey].CGColor;
        [self.layer addSublayer:self.bottomBorderLayer];
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    if (placeholder && placeholder.length) {
        [super setPlaceholder:placeholder];
        self.floatingLabel.text = placeholder;
        [self.floatingLabel sizeToFit];
        [self setFloatingLabelOverlapTextField];
    }
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
    [self.epLayer didChangeTapLocation:[touch locationInView:self]];
    [self.epLayer animateScaleForCircleLayer:0.45 toScale:1.0 withTimingFunction:EPTimingFunctionLinear withDuration:0.75];
    [self.epLayer animateAlphaForBackgroundLayer:EPTimingFunctionLinear withDuration:0.75];
    return [super beginTrackingWithTouch:touch withEvent:event];
}

#pragma mark - Private methods

- (void)setupLayer
{
    self.epLayer = [[EPLayer alloc] initWithSuperLayer:self.layer];
    self.padding = CGSizeMake(5, 5);
    self.floatingLabelBottomMargin = 2.0;
    self.floatingPlaceholderEnabled = FALSE;
    self.rippleLocation = EPRippleLocationTapLocation;
    self.aniDuration = 0.65f;
    self.rippleAniTimingFunction = EPTimingFunctionLinear;
    self.shadowAniEnabled = TRUE;
    self.cornerRadius = 2.5;
    self.rippleLayerColor = [UIColor colorWithWhite:0.45f alpha:0.5f];
    self.backgroundLayerColor = [UIColor colorWithWhite:0.75f alpha:0.25f];
    self.floatingLabelFont = [UIFont boldSystemFontOfSize:10.0];
    self.floatingLabelTextColor = [UIColor lightGrayColor];
    self.bottomBorderEnabled = FALSE;
    self.bottomBorderWidth = 1.0;
    self.bottomBorderColor = [UIColor lightGrayColor];
    self.bottomBorderHighlightWidth = 1.75;
    self.layer.borderWidth = 1.0;
    self.borderStyle = UITextBorderStyleNone;
    self.epLayer.ripplePercent = 1.0;
    [self.epLayer setCircleLayerColor:self.rippleLayerColor];

    // Add floating label view
    self.floatingLabel = [[UILabel alloc] init];
    self.floatingLabel.font = self.floatingLabelFont;
    self.floatingLabel.alpha = 0.0;
    [self addSubview:self.floatingLabel];
}

- (void)setFloatingLabelOverlapTextField
{
    CGRect textRect = [self textRectForBounds:self.bounds];
    CGFloat originX = textRect.origin.x;
    switch (self.textAlignment)
    {
        case NSTextAlignmentCenter:
            originX += textRect.size.width / 2 - self.floatingLabel.bounds.size.width / 2;
            break;
        case NSTextAlignmentRight:
            originX += textRect.size.width - self.floatingLabel.bounds.size.width;
            break;
        default:
            break;
    }
    self.floatingLabel.frame = CGRectMake(originX, self.padding.height, self.floatingLabel.frame.size.width, self.floatingLabel.frame.size.height);
}

- (void)showFloatingLabel
{
    CGRect curFrame = self.floatingLabel.frame;
    self.floatingLabel.frame = CGRectMake(curFrame.origin.x, self.bounds.size.height / 2, curFrame.size.width, curFrame.size.height);
    [UIView animateWithDuration:0.45
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.floatingLabel.alpha = 1.0;
                         self.floatingLabel.frame = curFrame;
                     }
                     completion: nil];
}

- (void)hideFloatingLabel
{
    self.floatingLabel.alpha = 0.0;
}

#pragma mark - Memory management


@end
