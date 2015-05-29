//
//  MyTableCell.h
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 29.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface MyTableCell : EPTableViewCell {

}

@property (nonatomic, strong) IBOutlet UILabel *labelMessage;

- (void)setMessage:(NSString *)messageString;

@end
