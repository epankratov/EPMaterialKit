//
//  MainViewController.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 23.03.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "MainViewController.h"
#import "ButtonsViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    // Do any additional setup after loading the view, typically from a nib.
    [self setTitle:@"MaterialKit demo"];
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_buttonViewController release];
    [super dealloc];
}

#pragma mark - User actions

- (IBAction)showButtonViewController:(id)sender
{
    ButtonsViewController *viewController = [[ButtonsViewController alloc] initWithNibName:@"ButtonsView" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

@end
