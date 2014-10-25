//
//  WebViewController.h
//  Cyride
//
//  Created by Jiwei Xia on 12/5/12.
//  Copyright (c) 2012 A1 Steaksause. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterWebViewController : UIViewController <UIWebViewDelegate>
{
    NSString *fullURL;
    NSURL *url;
}
- (IBAction)backButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *veiwWeb;
@end
