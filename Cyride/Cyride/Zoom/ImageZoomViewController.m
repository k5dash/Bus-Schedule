//
//  ImageZoomViewController.m
//  Table
//
//  Created by Chee Kok Aun on 09/10/2012.
//  Copyright (c) 2012 Chee Kok Aun. All rights reserved.
//

#import "ImageZoomViewController.h"
#import "ImageTableViewController.h"
@interface ImageZoomViewController ()

@end

@implementation ImageZoomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)presentCaption:(NSString *)title withMessage:(NSString *)msg withWebView:(bool)webView{
    if(webView){
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:@"\n\n\n\n\n\n\n\n\n\n\n"
                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
       // [alert show];
        UIWebView *htmlView = [[UIWebView alloc] initWithFrame:CGRectMake(15.0, 60.0, 255.0, 220.0)];
        [htmlView loadHTMLString:msg baseURL:nil];
        [alert addSubview:htmlView];
    }else{
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:msg
                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[alert show];
    }
}

bool captionShowing = NO;
- (IBAction)toggleCaption {
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex { captionShowing=NO; }



- (IBAction) dismissZoomVC {
    [UIAccelerometer sharedAccelerometer].delegate = nil;
    zoomScrollView.delegate = nil;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
// return a view that will be scaled. if delegate returns nil, nothing happens
{
    return imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)loadView
{
    path = [NSArray arrayWithObjects:[[NSBundle mainBundle] pathForResource:@"Map Ames Fall 12" ofType:@"png"],[[NSBundle mainBundle] pathForResource:@"redA1" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"green2" ofType:@"png"],[[NSBundle mainBundle] pathForResource:@"Blue Route" ofType:@"png"], nil];

    
    
    [UIAccelerometer sharedAccelerometer].delegate = self;
    
    zoomScrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    
    zoomScrollView.backgroundColor = [UIColor blackColor];
    zoomScrollView.delegate = self;
    
    myImageTableViewController = (ImageTableViewController *)[(UINavigationController *)[((UITabBarController *)[self presentingViewController] ) selectedViewController] topViewController] ;
    
    
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[path objectAtIndex: myImageTableViewController.selectedRow]]];
        
    //imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ngm.nationalgeographic.com/visions/field-test/sartore-biodiversity/img/gallery/01-maned-wolf-950.jpg" ]]]];
    zoomScrollView.contentSize = imageView.frame.size;
    [zoomScrollView addSubview:imageView];
    zoomScrollView.minimumZoomScale = zoomScrollView.frame.size.width / imageView.frame.size.width;
    zoomScrollView.maximumZoomScale = 1;//imageView.frame.size.width / zoomScrollView.frame.size.width;
    [zoomScrollView setZoomScale:zoomScrollView.minimumZoomScale];
    
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doSingleTap)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [zoomScrollView addGestureRecognizer:singleTap];
    
    doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doDoubleTap)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.numberOfTouchesRequired = 1;
    [zoomScrollView addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    rotationSwipe = [[KTOneFingerRotationGestureRecognizer alloc] initWithTarget:self action:@selector(doRotationSwipe:)];
    [zoomScrollView addGestureRecognizer:rotationSwipe];
    
    [rotationSwipe requireGestureRecognizerToFail:singleTap];
    [rotationSwipe requireGestureRecognizerToFail:doubleTap];
    
    self.view = zoomScrollView;
}

int rotMem=0;
- (void)doRotationSwipe:(KTOneFingerRotationGestureRecognizer *)recognizer
{
    if (recognizer.ended){
    NSLog(@"%f",recognizer.rotation);
    if (recognizer.rotation > 0.0){
        [self toggleCaption];
    }else{
        [self dismissZoomVC];
    }
    }
}

- (void)doSingleTap
{
    //NSLog(@"Action: One finger, one taps");
    CGPoint tapPoint = [singleTap locationInView:imageView];
    //NSLog(@"%f,%f",tapPoint.x,tapPoint.y);
    double toZoomScale = zoomScrollView.zoomScale*2;
    if (toZoomScale <= zoomScrollView.maximumZoomScale){
        [zoomScrollView zoomToRect:[self zoomRectForScrollView:zoomScrollView withScale:toZoomScale withCenter:tapPoint] animated:YES];
    }else{
        [zoomScrollView zoomToRect:[self zoomRectForScrollView:zoomScrollView withScale:zoomScrollView.maximumZoomScale withCenter:tapPoint] animated:YES];
    }
}

- (void)doDoubleTap
{
    //NSLog(@"Action: One finger, two taps");
    CGPoint tapPoint = [doubleTap locationInView:imageView];
    //NSLog(@"%f,%f",tapPoint.x,tapPoint.y);
    if (zoomScrollView.zoomScale == zoomScrollView.minimumZoomScale){
        [zoomScrollView zoomToRect:[self zoomRectForScrollView:zoomScrollView withScale:zoomScrollView.maximumZoomScale withCenter:tapPoint] animated:YES];
    }else{
        [zoomScrollView setZoomScale:zoomScrollView.minimumZoomScale animated:YES];
    }
}


- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    // The zoom rect is in the content view's coordinates.
    // At a zoom scale of 1.0, it would be the size of the
    // imageScrollView's bounds.
    // As the zoom scale decreases, so more content is visible,
    
    // the size of the rect grows.
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
} 

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //NSLog(@"%f", imageView.frame.size.width);
    if (imageView.frame.size.width < 200.0){
        [self dismissZoomVC];
        return;
    }
    if (scrollView.zoomScale==scrollView.minimumZoomScale){
        rotationSwipe.enabled=YES;
    }else{rotationSwipe.enabled=NO;}
    imageView.frame = [self centeredFrameForScrollView:scrollView andUIView:imageView];
}

- (CGRect)centeredFrameForScrollView:(UIScrollView *)scroll andUIView:(UIView *)rView
{
    CGSize boundsSize = scroll.bounds.size;
    CGRect frameToCenter = rView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    }else {
        frameToCenter.origin.x = 0;
    }
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    }else {
        frameToCenter.origin.y = 0;
    }
    
    return frameToCenter;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
