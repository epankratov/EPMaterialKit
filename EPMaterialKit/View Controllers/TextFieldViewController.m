//
//  TextFieldViewController.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 05.06.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "TextFieldViewController.h"

@interface TextFieldViewController ()

@end

@implementation TextFieldViewController

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
    // No border, no shadow, floatPlaceHolderDisabled
    self.textField1.layer.borderColor = [UIColor clearColor].CGColor;
    self.textField1.placeholder = @"Placeholder";
    self.textField1.tintColor = [UIColor grayColor];
    
    // No border, shadow, floatPlaceHolderDisabled
    self.textField2.layer.borderColor = [UIColor clearColor].CGColor;
    self.textField2.placeholder = @"Repo name";
    self.textField2.backgroundColor = HEX_COLOR(0xE0E0E0);
    self.textField2.tintColor = [UIColor grayColor];
    
    // Border, no shadow, floatPlaceHolderDisabled
    self.textField3.layer.borderColor = [UIColor Grey].CGColor;
    self.textField3.rippleLayerColor = [UIColor Amber];
    self.textField3.tintColor = [UIColor DeepOrange];
    self.textField3.rippleLocation = EPRippleLocationLeft;
    
    // No border, no shadow, floatingPlaceholderEnabled
    self.textField4.layer.borderColor = [UIColor clearColor].CGColor;
    self.textField4.floatingPlaceholderEnabled = TRUE;
    self.textField4.placeholder = @"Github";
    self.textField4.tintColor = [UIColor Blue];
    self.textField4.rippleLocation = EPRippleLocationRight;
    self.textField4.cornerRadius = 0;
    self.textField4.bottomBorderEnabled = TRUE;
    
    // No border, shadow, floatingPlaceholderEnabled
    self.textField5.layer.borderColor = [UIColor clearColor].CGColor;
    self.textField5.floatingPlaceholderEnabled = TRUE;
    self.textField5.placeholder = @"Email account";
    self.textField5.rippleLayerColor = [UIColor LightBlue];
    self.textField5.tintColor = [UIColor Blue];
    self.textField5.backgroundColor = HEX_COLOR(0xE0E0E0);
    
    // Border, floatingPlaceholderEnabled
    self.textField6.floatingPlaceholderEnabled = TRUE;
    self.textField6.cornerRadius = 1.0;
    self.textField6.placeholder = @"Description";
    self.textField6.layer.borderColor = [UIColor Green].CGColor;
    self.textField6.rippleLayerColor = [UIColor LightGreen];
    self.textField6.tintColor = [UIColor LightGreen];
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_textField1 release];
    [_textField2 release];
    [_textField3 release];
    [_textField4 release];
    [_textField5 release];
    [_textField6 release];
    [super dealloc];
}

#pragma mark - Touches handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:TRUE];
}

@end
