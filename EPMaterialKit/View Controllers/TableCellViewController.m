//
//  TableCellViewController.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 29.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "TableCellViewController.h"
#import "MyTableCell.h"

static NSString *cellIdentifier = @"MyTableCell";

@interface TableCellViewController () {
    NSArray *_labels;
    NSArray *_rippleLocations;
    NSArray *_circleColors;
}
@end

@implementation TableCellViewController

#pragma mark - ViewController lifetime methods

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

#pragma mark - Memory management

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
    MyTableCell *cell = (MyTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = (MyTableCell *)[nibs objectAtIndex:0];
    }
    [cell setMessage:_labels[indexPath.row]];
    EPRippleLocation rippleLocation = (EPRippleLocation)[[_rippleLocations objectAtIndex:indexPath.row] integerValue];
    cell.rippleLocation = rippleLocation;
    NSInteger index = indexPath.row % _circleColors.count;
    cell.rippleLayerColor = [_circleColors objectAtIndex:index];
    return cell;
}

@end
