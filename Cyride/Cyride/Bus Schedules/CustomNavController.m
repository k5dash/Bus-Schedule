//
//  CustomNavController.m
//  Cyride
//
//  Created by Anderson, Michael L on 12/12/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import "CustomNavController.h"
#import "RouteTypeViewController.h"
#import "ScheduleViewController.h"

@interface CustomNavController ()

@end

@implementation CustomNavController

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    if (self.viewControllers.count == 1) {
        [self pushViewController:schedule animated:animated];
    }
    return [self popToViewController:schedule animated:animated];
}

- (void)pushScheduleViewController:(NSString *)type {
    schedule = [[ScheduleViewController alloc] initWithDictionary:Data andType:[NSString stringWithFormat:@"%@ Routes",type]];
    [self pushViewController:schedule animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSData *json = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Data" ofType:@"json"]];
    Data = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
    schedule = [[ScheduleViewController alloc] initWithDictionary:Data andType:[self getWeekdayType]];
    RouteTypeViewController *root = [[RouteTypeViewController alloc] init];
    [self setViewControllers:[NSArray arrayWithObjects:root, schedule, nil]];
}

- (NSString *)getWeekdayType {
    CFAbsoluteTime at = CFAbsoluteTimeGetCurrent();
    CFTimeZoneRef tz = CFTimeZoneCopySystem();
    SInt32 WeekdayNumber = CFAbsoluteTimeGetDayOfWeek(at, tz);
    NSString *WeekdayType;
    switch (WeekdayNumber) {
        case 0:
            WeekdayType = @"Sunday";
            break;
        case 6:
            WeekdayType = @"Saturday";
            break;
        default:
            WeekdayType = @"Weekday";
            break;
    }
    NSLog(@"Weekday Number:%ld Type:%@",WeekdayNumber,WeekdayType);
    return [NSString stringWithFormat:@"%@ Routes",WeekdayType];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
