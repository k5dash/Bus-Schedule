//
//  ImageTableViewController.h
//  Table
//
//  Created by Chee Kok Aun on 08/10/2012.
//  Copyright (c) 2012 Chee Kok Aun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ImageTableViewController : UITableViewController <NSXMLParserDelegate, UITextFieldDelegate,UIAlertViewDelegate>
{    
    //NSInteger selectedSection;
    //NSInteger selectedRow;
    //NSMutableArray *imageTitles;
    NSMutableArray *imageIDs;
    NSMutableArray *imageThumbnails;
    
    NSXMLParser *rssParser;
    //NSMutableArray *articles;
    NSMutableDictionary *item;
    NSString *currentElement;
    NSMutableString *ElementValue;
    BOOL errorParsing;
    
    NSMutableArray *imageThumbnailsDA;
    //NSMutableArray *imageURLsDA;
    
    UIAlertView *progressAlert;
    UIProgressView *progressBar;
    NSArray *path;
    NSArray *titlePic;
    NSInteger RowSelected;

    IBOutlet UITextField *totalResultsTextField;
}

@property(nonatomic,strong) NSArray *imageTitles;
@property(nonatomic,assign) NSInteger selectedSection;
@property(nonatomic,assign) NSInteger selectedRow;
-(void)fetchImages;
//-(void)refetchImages;
-(void)createProgressionAlertWithMessage:(NSString *)message withProgressBar:(BOOL)activity;
-(void)dismissProgressAlert;
//-(NSString *)fetchLargestImageSizeURL;
//-(NSString *)fetchImageDescription;
//+(NSInteger) NumOfRowSelected;
//- (void)parseXMLFileAtURL:(NSString *)URL;
@property(nonatomic,strong) NSMutableArray *articles;
@property(nonatomic,strong) NSMutableArray *imageURLsDA;

@end
