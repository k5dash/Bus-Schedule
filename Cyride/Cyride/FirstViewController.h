//
//  FirstViewController.h
//  SocialApp
//
//  Created by Lyon, Todd M on 10/14/12.
//  Copyright (c) 2012 Lyon, Todd M. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface FirstViewController : UIViewController{
    IBOutlet UITextField *postText;
}

 -(IBAction)faceBook:(id)sender;

@end
