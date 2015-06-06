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
    EPImageView *imgView = [[EPImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 32)];
    imgView.image = [UIImage imageNamed:@"uibaritem_icon.png"];
    imgView.backgroundAniEnabled = FALSE;
    imgView.rippleLocation = EPRippleLocationCenter;
    imgView.ripplePercent = 1.15;
    imgView.userInteractionEnabled = TRUE;

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(handleRightButton:)];
    [rightButton setCustomView:imgView];
    self.navigationItem.rightBarButtonItem = rightButton;
    [rightButton release];
    [imgView release];
    
    self.label.rippleLocation = EPRippleLocationTapLocation;
    self.label.rippleLayerColor = [UIColor LightGreen];
    self.label.backgroundLayerColor = [UIColor clearColor];
    self.label.userInteractionEnabled = TRUE;
    [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(animateLabelRipple:) userInfo:nil repeats:FALSE];
    
    self.imageView.layer.borderColor = [UIColor Grey].CGColor;
    self.imageView.layer.borderWidth = 1.0;
    self.imageView.ripplePercent = 1.2;
    self.imageView.rippleLocation = EPRippleLocationTapLocation;
    self.imageView.userInteractionEnabled = TRUE;
    [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(animateImageRipple:) userInfo:nil repeats:FALSE];
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_label release];
    [_imageView release];
    [super dealloc];
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
