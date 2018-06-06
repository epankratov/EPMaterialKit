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
}

@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) NSArray *rippleLocations;
@property (nonatomic, strong) NSArray *circleColors;

@end

@implementation TableCellViewController

#pragma mark - ViewController lifetime methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.labels = [NSArray arrayWithObjects:@"MKButton", @"MKTextField", @"MKTableViewCell", @"MKTextView", @"MKColor", @"MKLayer", @"MKAlert", @"MKCheckBox", nil];
        self.rippleLocations = [NSArray arrayWithObjects:@(EPRippleLocationTapLocation), @(EPRippleLocationTapLocation),@(EPRippleLocationCenter), @(EPRippleLocationLeft), @(EPRippleLocationRight), @(EPRippleLocationTapLocation), @(EPRippleLocationTapLocation), @(EPRippleLocationTapLocation), nil];
        self.circleColors = [NSArray arrayWithObjects:[UIColor LightBlue], [UIColor Grey], [UIColor LightGreen], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews
{
    [self.tableView setFrame:self.view.bounds];
}

#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.labels count];
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
    [cell setMessage:self.labels[indexPath.row]];
    EPRippleLocation rippleLocation = (EPRippleLocation)[[self.rippleLocations objectAtIndex:indexPath.row] integerValue];
    cell.rippleLocation = rippleLocation;
    NSInteger index = indexPath.row % self.circleColors.count;
    cell.rippleLayerColor = [self.circleColors objectAtIndex:index];
    return cell;
}

@end
