//
//  MapScrollView.m
//  Cyride
//
//  Created by Jiwei Xia on 11/20/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import "MapScrollView.h"

@implementation MapScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init {
    self = [super init];
    
    self.minimumZoomScale=1.0;
    self.maximumZoomScale=10.0;
    
    UIImageView *myMap = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 260)];
    [myMap setImage:[UIImage imageNamed:@"Map Ames Fall 12.png"]];
    [self  addSubview:myMap];
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
