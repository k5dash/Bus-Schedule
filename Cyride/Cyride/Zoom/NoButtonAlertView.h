//
//  NoButtonAlertView.h
//  Table
//
//  Created by Chee Kok Aun on 11/10/2012.
//  Copyright (c) 2012 Chee Kok Aun. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface _NoButtonAlertViewCover : UIView
@property (nonatomic,assign) UIAlertView *delegate;
@end
@interface NoButtonAlertView : UIAlertView
-(id)initWithTitle:(NSString *)title message:(NSString *)message;
@end

