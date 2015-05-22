//
//  ButtonsViewController.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 22.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "ButtonsViewController.h"

@interface ButtonsViewController ()

@end

@implementation ButtonsViewController

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
    [self setTitle:@"Buttons demo"];

    self.raisedButton.layer.shadowOpacity = 0.55;
    self.raisedButton.layer.shadowRadius = 5.0;
    self.raisedButton.layer.shadowColor = [UIColor grayColor].CGColor;
    self.raisedButton.layer.shadowOffset = CGSizeMake(0, 2.5);

    self.flatButton1.backgroundLayerColor = [UIColor Lime];
    self.flatButton1.layer.shadowOpacity = 0.5;
    self.flatButton1.layer.shadowRadius = 5.0;
    self.flatButton1.layer.shadowColor = [UIColor blackColor].CGColor;
    self.flatButton1.layer.shadowOffset = CGSizeMake(0, 2.5);

    self.flatButton2.maskEnabled = false;
    self.flatButton2.ripplePercent = 0.5;
    self.flatButton2.backgroundAniEnabled = false;
    self.flatButton2.rippleLocation = EPRippleLocationCenter;

    self.imageButton1.rippleLayerColor = [UIColor DeepOrange];

    self.imageButton2.maskEnabled = false;
    self.imageButton2.ripplePercent = 1.2;
    self.imageButton2.backgroundAniEnabled = false;
    self.imageButton2.rippleLocation = EPRippleLocationCenter;

    self.floatButton1.cornerRadius = 40.0;
    self.floatButton1.backgroundLayerCornerRadius = 40.0;
    self.floatButton1.maskEnabled = false;
    self.floatButton1.ripplePercent = 1.75;
    self.floatButton1.rippleLocation = EPRippleLocationCenter;
    self.floatButton1.aniDuration = 0.85;

    self.floatButton1.layer.shadowOpacity = 0.75;
    self.floatButton1.layer.shadowRadius = 3.5;
    self.floatButton1.layer.shadowColor = [UIColor blackColor].CGColor;
    self.floatButton1.layer.shadowOffset = CGSizeMake(1.0, 5.5);

    self.floatButton2.cornerRadius = 40.0;
    self.floatButton2.layer.shadowOpacity = 0.75;
    self.floatButton2.layer.shadowRadius = 3.5;
    self.floatButton2.layer.shadowColor = [UIColor blackColor].CGColor;
    self.floatButton2.layer.shadowOffset = CGSizeMake(1.0, 5.5);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_raisedButton release];
    [_flatButton1 release];
    [_flatButton2 release];
    [_imageButton1 release];
    [_imageButton2 release];
    [_floatButton1 release];
    [_floatButton2 release];
    [super dealloc];
}

@end
