//
//  TextFieldViewController.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 05.06.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "TextFieldViewController.h"

const CGFloat kViewGapDistance = 50.0;

@interface TextFieldViewController () {

}

@property (nonatomic, assign) CGFloat defaultOriginY;
@property (nonatomic, assign) BOOL isKeyboardVisible;

@end

@interface TextFieldViewController (NotificationHandling)

- (void)keyboardWillShowHandler:(NSNotification *)notification;
- (void)keyboardWillHideHandler:(NSNotification *)notification;

@end

@interface TextFieldViewController (PrivateMethods)

- (CGFloat)viewPositionForCurrentResponder;
- (void)changeFocusPositionWithDuration:(NSTimeInterval)animationDuration;
- (void)restoreFocusPositionWithDuration:(NSTimeInterval)animationDuration;

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
    self.defaultOriginY = 0;
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
    self.textField3.layer.borderColor = [UIColor Gray].CGColor;
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

    // Set all the text fields delegates
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            EPTextField *textField = (EPTextField *)view;
            textField.delegate = self;
        }
    }

    // Subscribe onto keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowHandler:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideHandler:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Memory management

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - UITextField delegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    NSInteger tag = theTextField.tag;
    if (++tag > 5) {
        tag = 0;
    }
    EPTextField *nextTextField = nil;
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            EPTextField *textField = (EPTextField *)view;
            if (textField.tag == tag) {
                nextTextField = textField;
                break;
            }
        }
    }
    if (nextTextField != nil) {
        [nextTextField becomeFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.25;
    [self changeFocusPositionWithDuration:animationDuration];
}

#pragma mark - Touches handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isKeyboardVisible = FALSE;
    [self.view endEditing:TRUE];
}

@end

#pragma mark - Keyboard event notifications handlers

@implementation TextFieldViewController (NotificationHandling)

- (void)keyboardWillShowHandler:(NSNotification *)notification
{
    if (!self.isKeyboardVisible) {
        self.isKeyboardVisible = TRUE;
        self.defaultOriginY = self.view.frame.origin.y;
    }
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self changeFocusPositionWithDuration:animationDuration];
}

- (void)keyboardWillHideHandler:(NSNotification *)notification
{
    // Set flag only when any of the textfield is not focused
    if (!self.isKeyboardVisible) {
        NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        [self restoreFocusPositionWithDuration:animationDuration];
    }
}

@end

#pragma mark - Private methods

@implementation TextFieldViewController (PrivateMethods)

- (CGFloat)viewPositionForCurrentResponder
{
    CGFloat gap = 0;
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            EPTextField *textField = (EPTextField *)view;
            if ([textField isFirstResponder]) {
                gap = textField.tag * kViewGapDistance;
                break;
            }
        }
    }
    return gap;
}

- (void)changeFocusPositionWithDuration:(NSTimeInterval)animationDuration
{
    CGRect frame = self.view.frame;
    CGFloat newOrigin = [self viewPositionForCurrentResponder];
    frame.origin.y = -newOrigin;
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.view.frame = frame;
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)restoreFocusPositionWithDuration:(NSTimeInterval)animationDuration
{
    CGRect frame = self.view.frame;
    frame.origin.y = self.defaultOriginY;
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.view.frame = frame;
                     }
                     completion:^(BOOL finished){
                     }];
}

@end
