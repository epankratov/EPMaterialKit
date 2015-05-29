//
//  TableCellViewController.h
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 29.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface TableCellViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
