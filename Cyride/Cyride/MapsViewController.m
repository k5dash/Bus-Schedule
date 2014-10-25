//
//  MapsViewController.m
//  Cyride
//
//  Created by Michael Anderson on 11/20/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import "MapsViewController.h"
#import "MapScrollView.h"

@interface MapsViewController ()

@end

@implementation MapsViewController

- (void)loadView {
    [super loadView];
    maps = [NSArray arrayWithObjects:@"Map Ames Fall 12.jpg", @"Map Ames Fall 12.jpg", nil];
    
    CGRect pagingScrollViewFrame = [[UIScreen mainScreen] bounds];
    pagingScrollViewFrame.origin.x -= 10;
    pagingScrollViewFrame.size.width += 20;
    pagingScrollView = [[UIScrollView alloc] initWithFrame:pagingScrollViewFrame];
    
    pagingScrollView.pagingEnabled = YES;
    pagingScrollView.backgroundColor = [UIColor blackColor];
    pagingScrollView.contentSize = CGSizeMake(pagingScrollViewFrame.size.width * maps.count,
                                              pagingScrollViewFrame.size.height);
    
    self.view = pagingScrollView;
    
    // Add maps to scroll view
    for (int c=0; c<maps.count; c++) {
        MapScrollView *page = [[MapScrollView alloc] init];
        [pagingScrollView addSubview:page];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return pagingScrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
