//
//  SecondViewController.h
//  Cyride
//
//  Created by Anderson, Michael L on 11/13/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITextFieldDelegate>
{
    UILocalNotification *myNotification;
    NSTimer *t;
}

- (IBAction)Set:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIDatePicker *CountDown;


@end
