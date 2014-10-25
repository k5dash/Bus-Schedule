//
//  RouteViewController.m
//  Cyride
//
//  Created by Anderson, Michael L on 12/5/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import "SingleRouteViewController.h"

@interface SingleRouteViewController ()

@end

@implementation SingleRouteViewController

- (id)initWithDictionary:(NSDictionary *)Data andKey:(NSString *)Key {
    _Data = Data;
    self.title = Key;
    RouteName = Key;
    super.tableView.separatorColor = [UIColor blackColor];
    cells = [[CellDivision alloc] initWithDictionary:_Data andKey:RouteName];
    defaults = [NSUserDefaults standardUserDefaults];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(defaultsChanged:)
     name:NSUserDefaultsDidChangeNotification object:nil];
    return self;
}

- (void)defaultsChanged:(NSNotification *)notification {
    [self.tableView reloadData];
}

#pragma mark - Table view data source (TableView Cell)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [self tableViewCellWithReuseIdentifier:CellIdentifier];
    // Configure the cell...
    
    static int mins = 0;
    UIColor *color = (/*If*/[defaults boolForKey:@"Color Alternate"]&&indexPath.row%2?
                      /*Then*/[UIColor colorWithWhite:0.9 alpha:1]:
                      /*Else*/[UIColor whiteColor]);
    NSMutableArray *td = [NSMutableArray arrayWithCapacity:cells.columns];
    for (int i = 0; i<cells.columns; i++) {
        [td addObject:[NSString stringWithFormat:@"%d:%02d",indexPath.row%11+1, mins++%60]];
    }
    for (int i = 0; i<cells.columns; i++) {
        UILabel *label = (UILabel *)[cell viewWithTag:i+1];
        label.text = td[i];
        label.backgroundColor = color;
    }
    if ([cell viewWithTag:-1]) {
        UILabel *label = (UILabel *)[cell viewWithTag:-1];
        label.backgroundColor = color;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor blackColor];
}

- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    [cells generateRowOfLabelsForCell:cell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view data source (TableView Header)

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 77;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *test = [tableView viewWithTag:1337];
    if (test) NSLog(@"View found");
    
    UIView *headerView = [[UIView alloc] initWithFrame:[tableView rectForHeaderInSection:section]];
    headerView.backgroundColor = [UIColor blackColor];
    headerView.tag = 1337;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(1,1,318,15)];
    title.text = RouteName;
    title.textAlignment = NSTextAlignmentCenter;
    NSDictionary *color = [[_Data objectForKey:RouteName] objectForKey:@"Color"];
    title.backgroundColor = [UIColor colorWithRed:[[color objectForKey:@"Red"] floatValue]
                                            green:[[color objectForKey:@"Green"] floatValue]
                                             blue:[[color objectForKey:@"Blue"] floatValue]
                                            alpha:1];
    [headerView addSubview:title];
    
    UILabel *duration = [[UILabel alloc] initWithFrame:CGRectMake(1,17,318,15)];
    duration.text = [_Data objectForKey:@"Duration"];
    duration.textAlignment = NSTextAlignmentCenter;
    duration.backgroundColor = [UIColor yellowColor];
    [headerView addSubview:duration];
    
    [cells generateRowOfLabelsForHeader:headerView];
    return headerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
