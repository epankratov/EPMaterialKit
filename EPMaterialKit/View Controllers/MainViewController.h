//
//  MainViewController.h
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 23.03.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface MainViewController : UIViewController {

}

@property (nonatomic, strong) IBOutlet EPButton *buttonViewController;

- (IBAction)showButtonViewController:(id)sender;

@end
