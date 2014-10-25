//
//  NoButtonAlertView.m
//  Table
//
//  Created by Chee Kok Aun on 11/10/2012.
//  Copyright (c) 2012 Chee Kok Aun. All rights reserved.
//

#import "NoButtonAlertView.h"
@implementation _NoButtonAlertViewCover
@synthesize delegate = _delegate;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
    [_delegate dismissWithClickedButtonIndex:0 animated:YES];
}
@end
@implementation NoButtonAlertView
-(void)show{
    [super show];
    _NoButtonAlertViewCover *cover = [[_NoButtonAlertViewCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.userInteractionEnabled = YES;
    cover.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.01];
    cover.delegate = self;
    [self.superview addSubview:cover];
}
-(id)initWithTitle:(NSString *)title message:(NSString *)message{
    if ((self = [super initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil])){
    }
    return self;
}
- (void)setFrame:(CGRect)rect {
    // Called multiple times, 4 of those times count, so to reduce height by 40
    rect.size.height -= 10;
    self.center = self.superview.center;
    [super setFrame:rect];
}
@end

