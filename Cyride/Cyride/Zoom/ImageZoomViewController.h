//
//  ImageZoomViewController.h
//  Table
//
//  Created by Chee Kok Aun on 09/10/2012.
//  Copyright (c) 2012 Chee Kok Aun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageTableViewController.h"
#import "KTOneFingerRotationGestureRecognizer.h"

// Ensures the shake is strong enough on at least two axes before declaring it a shake.
// "Strong enough" means "greater than a client-supplied threshold" in G's.
static BOOL AccelerationIsShaking(UIAcceleration* last, UIAcceleration* current, double threshold) {
    double
    deltaX = fabs(last.x - current.x),
    deltaY = fabs(last.y - current.y),
    deltaZ = fabs(last.z - current.z);
    
    return
    (deltaX > threshold && deltaY > threshold) ||
    (deltaX > threshold && deltaZ > threshold) ||
    (deltaY > threshold && deltaZ > threshold);
}

@interface ImageZoomViewController : UIViewController <UIScrollViewDelegate,UIAccelerometerDelegate,UIApplicationDelegate,UIAlertViewDelegate>
{
    ImageTableViewController *myImageTableViewController;
    UITapGestureRecognizer *singleTap;
    UITapGestureRecognizer *doubleTap;
    KTOneFingerRotationGestureRecognizer *rotationSwipe;
    UIScrollView *zoomScrollView;
    UIImageView *imageView;
    
    BOOL histeresisExcited;
    UIAcceleration* lastAcceleration;
    UIAlertView *alert;
    NSArray* path;
}

-(void)presentCaption:(NSString *)title withMessage:(NSString *)msg withWebView:(bool)webView;

@end
