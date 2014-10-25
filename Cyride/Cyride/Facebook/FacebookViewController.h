//
//  FacebookViewController.h
//  Cyride
//
//  Created by Jiwei Xia on 12/5/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <CoreLocation/CoreLocation.h>

@interface FacebookViewController : UIViewController <CLLocationManagerDelegate>
{
    IBOutlet UITextField *postText;
    __weak IBOutlet UILabel *label;
    
    CLLocationManager *manager;
}

-(IBAction)faceBook:(id)sender;


- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error;
@end