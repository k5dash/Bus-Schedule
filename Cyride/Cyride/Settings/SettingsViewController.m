//
//  SettingsViewController.m
//  Cyride
//
//  Created by Jiwei Xia on 12/7/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    storage = [NSUserDefaults standardUserDefaults];
    _whiteTextSwitch.on = [storage boolForKey:@"White Text"];
    _routeNumberSwitch.on = [storage boolForKey:@"Route Number"];
    _colorCodingSwitch.on = ![storage boolForKey:@"Color Coding"];
    _colorAlternateSwitch.on = [storage boolForKey:@"Color Alternate"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1&&!_colorCodingSwitch.on) {
        return 0;
    } else return [super tableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1&&!_colorCodingSwitch.on) {
        return .001;
    } else return [super tableView:tableView heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1&&!_colorCodingSwitch.on) {
        return .001;
    } else return [super tableView:tableView heightForHeaderInSection:section];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setRouteNumber {
    [storage setBool:_routeNumberSwitch.on forKey:@"Route Number"];
    [storage synchronize];
}

- (IBAction)setColorCoding {
    [storage setBool:!_colorCodingSwitch.on forKey:@"Color Coding"];
    [storage synchronize];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)setColorAlternating {
    [storage setBool:_colorAlternateSwitch.on forKey:@"Color Alternate"];
    [storage synchronize];
}

- (IBAction)setWhiteText {
    [storage setBool:_whiteTextSwitch.on forKey:@"White Text"];
    [storage synchronize];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
