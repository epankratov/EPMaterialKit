//
//  TextFieldViewController.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 05.06.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "TextFieldViewController.h"

const CGFloat kViewGapDistance = 35.0;

@interface TextFieldViewController () {
    CGFloat _prevOriginY;
}

- (CGFloat)gapDistanceForFirstResponder;

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
    _prevOriginY = 0;
    [super viewDidLoad];
    // No border, no shadow, floatPlaceHolder enabled
    self.textField1.layer.borderColor = [UIColor clearColor].CGColor;
    self.textField1.placeholder = @"Placeholder";
    self.textField1.floatingPlaceholderEnabled = TRUE;
    self.textField1.tintColor = [UIColor grayColor];
    self.textField1.tag = 0;
    
    // No border, shadow, floatPlaceHolder enabled
    self.textField2.layer.borderColor = [UIColor clearColor].CGColor;
    self.textField2.placeholder = @"Repo name";
    self.textField2.floatingPlaceholderEnabled = TRUE;
    self.textField2.backgroundColor = HEX_COLOR(0xE0E0E0);
    self.textField2.tintColor = [UIColor grayColor];
    self.textField2.tag = 1;
    
    // Border, no shadow, floatPlaceHolder disabled
    self.textField3.layer.borderColor = [UIColor Grey].CGColor;
    self.textField3.rippleLayerColor = [UIColor Amber];
    self.textField3.tintColor = [UIColor DeepOrange];
    self.textField3.rippleLocation = EPRippleLocationLeft;
    self.textField3.tag = 2;
    
    // No border, no shadow, floatingPlaceholder enabled
    self.textField4.layer.borderColor = [UIColor clearColor].CGColor;
    self.textField4.placeholder = @"Github";
    self.textField4.floatingPlaceholderEnabled = TRUE;
    self.textField4.tintColor = [UIColor Blue];
    self.textField4.rippleLocation = EPRippleLocationRight;
    self.textField4.cornerRadius = 0;
    self.textField4.bottomBorderEnabled = TRUE;
    self.textField4.tag = 3;

    // No border, shadow, floatingPlaceholder enabled
    self.textField5.layer.borderColor = [UIColor clearColor].CGColor;
    self.textField5.placeholder = @"Email account";
    self.textField5.floatingPlaceholderEnabled = TRUE;
    self.textField5.rippleLayerColor = [UIColor LightBlue];
    self.textField5.tintColor = [UIColor Blue];
    self.textField5.backgroundColor = HEX_COLOR(0xE0E0E0);
    self.textField5.tag = 4;
    
    // Border, floatingPlaceholder enabled
    self.textField6.cornerRadius = 1.0;
    self.textField6.placeholder = @"Description";
    self.textField6.floatingPlaceholderEnabled = TRUE;
    self.textField6.layer.borderColor = [UIColor Green].CGColor;
    self.textField6.rippleLayerColor = [UIColor LightGreen];
    self.textField6.tintColor = [UIColor LightGreen];
    self.textField6.tag = 5;

    // Subscribe onto keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

    [_textField1 release];
    [_textField2 release];
    [_textField3 release];
    [_textField4 release];
    [_textField5 release];
    [_textField6 release];
    [super dealloc];
}

#pragma mark - Keyboard event notifications

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    _prevOriginY = frame.origin.y;
    frame.origin.y -= [self gapDistanceForFirstResponder];
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.view.frame = frame;
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.origin.y = _prevOriginY;
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.view.frame = frame;
                     }
                     completion:^(BOOL finished){
                     }];
}

#pragma mark - Touches handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:TRUE];
}

#pragma mark - Private methods

- (CGFloat)gapDistanceForFirstResponder
{
    CGFloat gap = 0;
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            EPTextField *textField = (EPTextField *)view;
            if ([textField isFirstResponder]) {
                gap = textField.tag * kViewGapDistance;
            }
        }
    }
    return gap;
}

@end
