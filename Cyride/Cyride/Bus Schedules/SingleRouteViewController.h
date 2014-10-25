//
//  RouteViewController.h
//  Cyride
//
//  Created by Anderson, Michael L on 12/5/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDivision.h"

#define miniWidth 15

@interface SingleRouteViewController : UITableViewController {
    NSUserDefaults *defaults;
    UIImageView *header;
    NSString *RouteName;
    CellDivision *cells;
}
@property NSDictionary *Data;

- (id)init __attribute__((unavailable("init not available")));
- (id)initWithDictionary:(NSDictionary *)Data andKey:(NSString *)key;
@end
