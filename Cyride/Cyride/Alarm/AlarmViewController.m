//
//  SecondViewController.m
//  Cyride
//
//  Created by Anderson, Michael L on 11/13/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import "AlarmViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    NSDate *currentDateTime = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"EEE,MM-dd-yyyy HH:mm:ss"];    
//    NSString *dateInStringFormated = [dateFormatter stringFromDate:currentDateTime];
   

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (IBAction)Set:(id)sender {
   
    
    
    NSString * time = [[[NSDate date] description] substringWithRange:NSMakeRange (11, 5)];
//    
//
    NSInteger  hour = ([[time substringWithRange:NSMakeRange(0, 2)] integerValue]+18)%24;
    NSInteger  Minute =[[time substringWithRange:NSMakeRange(3, 2)] integerValue];
//    
    
    
    
    
    
    
    
    NSString * time_set = [_CountDown.date.description substringWithRange:NSMakeRange (11, 5)];
    
   
    NSInteger  hour_set = ([[time_set substringWithRange:NSMakeRange(0, 2)] integerValue]+18) %24;
    NSInteger  Minute_set = [[time_set substringWithRange:NSMakeRange(3, 2)] integerValue];
    
    if (hour_set<hour || (hour==hour_set && Minute_set<Minute)) hour_set =hour_set+24;
    NSInteger seconds_count = (60*(hour_set-hour)+(Minute_set-Minute));
if (seconds_count){
        
    [t invalidate];
    myNotification = [[UILocalNotification alloc] init];
    myNotification.alertAction = @"Cyride Alarm";
    myNotification.alertBody = @"Time to go!";
    myNotification.timeZone = [NSTimeZone defaultTimeZone];
    myNotification.soundName = UILocalNotificationDefaultSoundName;
    myNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:seconds_count];
    
    
     _timeLbl.text = [NSString stringWithFormat:@"%d",seconds_count];
    [[UIApplication sharedApplication] scheduleLocalNotification:myNotification];
    t = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabelOnTick:) userInfo:_timeLbl repeats:YES];
}
     NSLog(@"%@",time);
}

- (void)updateLabelOnTick:(NSTimer *)timer {
    UILabel *label = timer.userInfo;
    label.text = [NSString stringWithFormat:@"%d",[label.text integerValue]-1];
    if([label.text integerValue]==0) {
        label.text = @"BOOM!";
        [timer invalidate];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
