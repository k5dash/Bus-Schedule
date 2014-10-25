//
//  TestViewController.m
//  Cyride
//
//  Created by Anderson, Michael L on 12/7/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import "TestViewController.h"
#import "ScheduleViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    super.tableView.rowHeight = 20;
    super.tableView.separatorColor = [UIColor blackColor];
    mins = 0;
    
    key = [[_Data objectForKey:@"Weekday Routes"] objectAtIndex:1];
    titles = [[_Data objectForKey:key] objectForKey:@"Stops"];
    cells = [[CellDivision alloc] initWithDictionary:_Data andKey:key];
    defaults = [NSUserDefaults standardUserDefaults];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(defaultsChanged:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self tableViewCellWithReuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    UIColor *color = (/*If*/[defaults boolForKey:@"Color Alternate"]&&indexPath.row%2?
                      /*Then*/[UIColor colorWithWhite:0.9 alpha:1]:
                      /*Else*/[UIColor whiteColor]);
    NSMutableArray *td = [NSMutableArray arrayWithCapacity:titles.count];
    for (int i = 0; i<titles.count; i++) {
        [td addObject:[NSString stringWithFormat:@"%d:%02d",indexPath.row%11+1, mins++%60]];
    }
    for (int i = 0; i<titles.count; i++) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 77;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *test = [tableView viewWithTag:1337];
    if (test) NSLog(@"Previous headerView found");
    
    UIView *headerView = [[UIView alloc] initWithFrame:[tableView rectForHeaderInSection:section]];
    headerView.backgroundColor = [UIColor blackColor];
    headerView.tag = 1337;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(1,1,318,15)];
    title.text = key;
    title.textAlignment = NSTextAlignmentCenter;
    NSDictionary *color = [[_Data objectForKey:key] objectForKey:@"Color"];
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
    
    /*for (int i = 0; i<titles.count; i++) {
        UILabel *label;
        if (leftColumn)
            label = [[UILabel alloc] initWithFrame:CGRectMake(cells.x[i]+(miniWidth+1)*miniColumn,33,cells.width[i],43)];
        else
            label = [[UILabel alloc] initWithFrame:CGRectMake(cells.x[i],33,cells.width[i],43)];
        label.text = titles[i];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 3;
        label.font = [UIFont systemFontOfSize:9];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:label];
    }
    if (miniColumn) {
        UILabel *label;
        if (leftColumn)
            label = [[UILabel alloc] initWithFrame:CGRectMake(1,33,miniWidth,43)];
        else
            label = [[UILabel alloc] initWithFrame:CGRectMake(cellArea+1,33,miniWidth,43)];
        //label.text = @"1A";
        label.font = [UIFont systemFontOfSize:9];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:label];
    }*/
    return headerView;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:50 inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];*/
    [self.navigationController popToRootViewControllerAnimated:YES];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
