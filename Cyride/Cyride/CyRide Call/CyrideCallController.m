//
//  CyrideCallController.m
//  Cyride
//
//  Created by Jiwei Xia on 12/5/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import "CyrideCallController.h"

@interface CyrideCallController ()

@end

@implementation CyrideCallController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(IBAction)CyrideCall:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://5152921100"]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
