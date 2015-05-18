//
//  EPButton.h
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 15.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPButton : UIButton {

}

@property (nonatomic, setter=setCornerRadius:) IBInspectable CGFloat cornerRadius;
@property (nonatomic, strong, setter=setRippleLayerColor:) IBInspectable UIColor *rippleLayerColor;

@end
