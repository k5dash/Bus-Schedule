//
//  ScheduleViewController.m
//  Cyride
//
//  Created by Anderson, Michael L on 11/27/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import "ScheduleViewController.h"
#import "SingleRouteViewController.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

- (id)initWithDictionary:(NSDictionary *)Data andType:(NSString *)Type {
    self.Data = Data;
    self.title = Type;
    self.tableView.rowHeight = 44;
    Routes = [_Data objectForKey:Type];
    defaults = [NSUserDefaults standardUserDefaults];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(defaultsChanged:)
     name:NSUserDefaultsDidChangeNotification object:nil];
    return self;
}

- (void)defaultsChanged:(NSNotification *)notification {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return Routes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [self tableViewCellWithReuseIdentifier:CellIdentifier];
    // Configure the cell...
    UIColor *textColor = (/*If*/![defaults boolForKey:@"Color Coding"]&&[defaults boolForKey:@"White Text"]?
                       /*Then*/[UIColor whiteColor]:
                       /*Else*/[UIColor blackColor]);
    NSString *key = [Routes objectAtIndex:indexPath.row];
    NSString *routeNumber = [key stringByReplacingOccurrencesOfString:@"#(\\d+\\w?) [^\\d]+"
                                                           withString:@"$1"
                                                               options:NSRegularExpressionSearch
                                                               range:NSMakeRange(0, key.length)];
    NSString *routeName = [key stringByReplacingOccurrencesOfString:@"#\\d+\\w? "
                                                         withString:@""
                                                            options:NSRegularExpressionSearch
                                                              range:NSMakeRange(0, key.length)];
    cell.textLabel.text = key;
    
    UILabel *text = (UILabel *)[cell viewWithTag:2];
    UILabel *number = (UILabel *)[cell viewWithTag:1];
    if (![defaults boolForKey:@"Color Coding"]&&[defaults boolForKey:@"Route Number"]) {
        text.text = routeName;
        number.text = routeNumber;
        number.textColor = textColor;
        number.backgroundColor = [self colorForKey:key];
        cell.textLabel.textColor = [UIColor clearColor];
    } else {
        text.text = @"";
        number.text = @"";
        number.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = textColor;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![defaults boolForKey:@"Color Coding"]&&![defaults boolForKey:@"Route Number"]) {
        cell.backgroundColor = [self colorForKey:[Routes objectAtIndex:indexPath.row]];
    } else if ([defaults boolForKey:@"Color Alternate"]&&indexPath.row%2) {
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
}

- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.text = @"";
    
    UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 34, 34)];
    number.tag = 1;
    number.textAlignment = NSTextAlignmentCenter;
    number.font = [UIFont boldSystemFontOfSize:20];
    number.textColor = [UIColor blackColor];
    number.layer.cornerRadius = 7;
    [cell.contentView addSubview:number];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(44, 0, 275, 44)];
    text.tag = 2;
    text.font = [UIFont boldSystemFontOfSize:20];
    text.textColor = [UIColor blackColor];
    text.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:text];
    
    cell.userInteractionEnabled = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIColor *)colorForKey:(NSString *)key {
    NSDictionary *color = [[_Data objectForKey:key] objectForKey:@"Color"];
    return [UIColor colorWithRed:[[color objectForKey:@"Red"] floatValue]
                           green:[[color objectForKey:@"Green"] floatValue]
                            blue:[[color objectForKey:@"Blue"] floatValue]
                           alpha:1];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SingleRouteViewController *detailVC = [[SingleRouteViewController alloc]
                                           initWithDictionary:_Data andKey:[Routes objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
