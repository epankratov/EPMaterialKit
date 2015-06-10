//
//  TextFieldViewController.h
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 05.06.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface TextFieldViewController : UIViewController <UITextFieldDelegate> {

}

@property (nonatomic, strong) IBOutlet EPTextField *textField1;
@property (nonatomic, strong) IBOutlet EPTextField *textField2;
@property (nonatomic, strong) IBOutlet EPTextField *textField3;
@property (nonatomic, strong) IBOutlet EPTextField *textField4;
@property (nonatomic, strong) IBOutlet EPTextField *textField5;
@property (nonatomic, strong) IBOutlet EPTextField *textField6;

@end
