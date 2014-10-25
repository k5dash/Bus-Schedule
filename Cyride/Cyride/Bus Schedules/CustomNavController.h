//
//  CustomNavController.h
//  Cyride
//
//  Created by Anderson, Michael L on 12/12/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScheduleViewController;

@interface CustomNavController : UINavigationController {
    ScheduleViewController *schedule;
    NSDictionary *Data;
}

- (void)pushScheduleViewController:(NSString *)type;
@end
