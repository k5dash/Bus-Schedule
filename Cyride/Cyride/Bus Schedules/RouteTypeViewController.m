//
//  RouteTypeViewController.m
//  Cyride
//
//  Created by Anderson, Michael L on 2/15/13.
//  Copyright (c) 2013 A1 Steaksause. All rights reserved.
//

#import "CustomNavController.h"
#import "RouteTypeViewController.h"

@interface RouteTypeViewController ()

@end

@implementation RouteTypeViewController

- (id)init {
    self.title = @"Schedules";
    types = [NSArray arrayWithObjects:@"Weekday",@"Saturday",@"Sunday", nil];
    defaults = [NSUserDefaults standardUserDefaults];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(defaultsChanged:)
     name:NSUserDefaultsDidChangeNotification object:nil];
    return self;
}

- (void)defaultsChanged:(NSNotification *)notification {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.textLabel.text = types[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([defaults boolForKey:@"Color Alternate"]&&indexPath.row%2) {
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    CustomNavController *nav = (CustomNavController *)self.navigationController;
    [nav pushScheduleViewController:types[indexPath.row]];
}

@end
