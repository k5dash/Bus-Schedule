//
//  ScheduleViewController.h
//  Cyride
//
//  Created by Anderson, Michael L on 11/27/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ScheduleViewController : UITableViewController {
    NSArray *Routes;
    NSUserDefaults *defaults;
}
@property NSDictionary *Data;

- (id)init __attribute__((unavailable("init not available")));
- (id)initWithDictionary:(NSDictionary *)Data andType:(NSString *)Type;
@end
