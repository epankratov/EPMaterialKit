//
//  ButtonsViewController.h
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 22.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface ButtonsViewController : UIViewController {

}

@property (nonatomic, strong) IBOutlet EPButton *raisedButton;
@property (nonatomic, strong) IBOutlet EPButton *flatButton1;
@property (nonatomic, strong) IBOutlet EPButton *flatButton2;
@property (nonatomic, strong) IBOutlet EPButton *imageButton1;
@property (nonatomic, strong) IBOutlet EPButton *imageButton2;
@property (nonatomic, strong) IBOutlet EPButton *floatButton1;
@property (nonatomic, strong) IBOutlet EPButton *floatButton2;

@end
