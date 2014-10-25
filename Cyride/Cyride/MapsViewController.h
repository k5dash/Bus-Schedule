//
//  MapsViewController.h
//  Cyride
//
//  Created by Michael Anderson on 11/20/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapsViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *pagingScrollView;
    NSArray *maps;
}

@end
