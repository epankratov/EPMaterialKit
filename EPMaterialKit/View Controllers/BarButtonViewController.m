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
    UIImage *image = [UIImage imageNamed:@"icon_menu.png"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    EPImageView *imageView = [[EPImageView alloc] initWithImage:image];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    imageView.tintColor = self.view.tintColor;
    imageView.backgroundAniEnabled = FALSE;
    imageView.rippleLocation = EPRippleLocationCenter;
    imageView.ripplePercent = 1.15;

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightButton:)];
    [tapGesture setNumberOfTapsRequired:1];
    [imageView addGestureRecognizer:tapGesture];

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:imageView];
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
    [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(animateLabelRipple:) userInfo:nil repeats:FALSE];
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
