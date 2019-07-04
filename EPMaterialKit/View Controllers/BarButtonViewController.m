//
//  BarButtonViewController.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 05.06.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "BarButtonViewController.h"

@interface BarButtonViewController ()

- (void)handleRightButton:(id)sender;
- (void)animateLabelRipple:(id)sender;
- (void)animateImageRipple:(id)sender;

@end

@implementation BarButtonViewController

#pragma mark - ViewController lifetime methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    EPButton *button = [[EPButton alloc] initWithFrame:CGRectMake(0, 0, 44, 32)];
    [button setImage:[UIImage imageNamed:@"uibaritem_icon.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleRightButton:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundAniEnabled = FALSE;
    button.rippleLocation = EPRippleLocationCenter;
    button.ripplePercent = 1.15;

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.label.rippleLocation = EPRippleLocationTapLocation;
    self.label.rippleLayerColor = [UIColor LightGreen];
    self.label.backgroundLayerColor = [UIColor clearColor];
    self.label.userInteractionEnabled = TRUE;
    
    self.imageView.layer.borderColor = [UIColor Gray].CGColor;
    self.imageView.layer.borderWidth = 1.0;
    self.imageView.ripplePercent = 1.2;
    self.imageView.rippleLocation = EPRippleLocationTapLocation;
    self.imageView.userInteractionEnabled = TRUE;
}

#pragma mark - Private methods and user actions handling

- (void)handleRightButton:(id)sender
{
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(animateLabelRipple:) userInfo:nil repeats:FALSE];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(animateImageRipple:) userInfo:nil repeats:FALSE];
}

- (void)animateLabelRipple:(id)sender
{
    [self.label animateRipple:CGPointZero];
}

- (void)animateImageRipple:(id)sender
{
    [self.imageView animateRipple:CGPointZero];
}

@end
