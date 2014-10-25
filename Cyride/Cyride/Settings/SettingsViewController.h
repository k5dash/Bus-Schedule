//
//  SettingsViewController.h
//  Cyride
//
//  Created by Jiwei Xia on 12/7/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SettingsViewController : UITableViewController {
    NSUserDefaults *storage;
    BOOL showOptions;}

@property (weak, nonatomic) IBOutlet UISwitch *routeNumberSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *colorCodingSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *colorAlternateSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *whiteTextSwitch;
- (IBAction)setRouteNumber;
- (IBAction)setColorCoding;
- (IBAction)setColorAlternating;
- (IBAction)setWhiteText;
@end
