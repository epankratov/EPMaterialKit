//
//  TableCellViewController.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 29.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "TableCellViewController.h"
#import "MyTableCell.h"

@interface TableCellViewController () {
    NSArray *_labels;
    NSArray *_rippleLocations;
    NSArray *_circleColors;
}
@end

@implementation TableCellViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _labels = [[NSArray arrayWithObjects:@"MKButton", @"MKTextField", @"MKTableViewCell", @"MKTextView", @"MKColor", @"MKLayer", @"MKAlert", @"MKCheckBox", nil] retain];
        _rippleLocations = [[NSArray arrayWithObjects:@(EPRippleLocationTapLocation), @(EPRippleLocationTapLocation),@(EPRippleLocationCenter), @(EPRippleLocationLeft), @(EPRippleLocationRight), @(EPRippleLocationTapLocation), @(EPRippleLocationTapLocation), @(EPRippleLocationTapLocation), nil] retain];
        _circleColors = [[NSArray arrayWithObjects:[UIColor LightBlue], [UIColor Grey], [UIColor LightGreen], nil] retain];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_tableView release];
    [_labels release];
    [_rippleLocations release];
    [_circleColors release];
    [super dealloc];
}

#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_labels count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyTableCell";
    MyTableCell *cell = (MyTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[MyTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setMessage:_labels[indexPath.row]];
    cell.rippleLocation = (EPRippleLocation)[[_rippleLocations objectAtIndex:indexPath.row] integerValue];
    NSInteger index = indexPath.row % _circleColors.count;
    cell.rippleLayerColor = [_circleColors objectAtIndex:index];
    return cell;
}

@end
