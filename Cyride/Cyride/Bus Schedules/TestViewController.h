//
//  TestViewController.h
//  Cyride
//
//  Created by Anderson, Michael L on 12/7/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDivision.h"

@interface TestViewController : UITableViewController {
    NSUserDefaults *defaults;
    NSArray *titles;
    NSString *key;
    CellDivision *cells;
    int mins;
}
@property NSDictionary *Data;

@end
