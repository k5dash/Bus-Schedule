//
//  FirstViewController.m
//  SocialApp
//
//  Created by Lyon, Todd M on 10/14/12.
//  Copyright (c) 2012 Lyon, Todd M. All rights reserved.
//

#import "FacebookViewController.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    manager = [[CLLocationManager alloc] init];
	manager.delegate=self;
	[manager startUpdatingLocation];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
	NSString * latitude = [[NSString alloc] initWithFormat:@"Latitude:%f", newLocation.coordinate.latitude];
    NSString * longitude= [[NSString alloc] initWithFormat:@"Longitude:%f", newLocation.coordinate.longitude];
    label.text = [latitude stringByAppendingFormat:@"    %@",longitude];
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error {
	
}


-(IBAction)faceBook:(id)sender{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                NSLog(@"Cancelled");
                
            } else
                
            {
                NSLog(@"Done");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        NSString *text = [NSString stringWithFormat:@"Hey, I am here! %@ Sent from our cyride app!", label.text];
        [controller setInitialText:text];
        [controller addImage:[UIImage imageNamed:@"cyride.png"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        NSLog(@"UnAvailable");
    }
}

@end
