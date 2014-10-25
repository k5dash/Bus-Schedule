//
//  WebViewController.m
//  Cyride
//
//  Created by Jiwei Xia on 12/5/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import "GoogleWebViewController.h"


@implementation GoogleWebViewController

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
    fullURL = @"http://www.google.com/maps?ie=UTF8&f=d&saddr=Coover%20Hall&daddr=Gerdin%20Hall&ttype=arr&date=12/07/2012&time=01:00%20AM&dirflg=r";
    url = [NSURL URLWithString:fullURL];
    //    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    //    [_veiwWeb loadRequest:requestObj];
    //
    
    
    
    [self.veiwWeb loadRequest:[[NSURLRequest alloc] initWithURL:url]];
    [_veiwWeb setDelegate:self];
    //backButton.enabled = NO;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.veiwWeb loadRequest:[[NSURLRequest alloc] initWithURL:url]];
    
}


@end
