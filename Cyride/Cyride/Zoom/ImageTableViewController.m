//
//  ImageTableViewController.m
//  Table
//
//  Created by Chee Kok Aun on 08/10/2012.
//  Copyright (c) 2012 Chee Kok Aun. All rights reserved.
//

#import "ImageTableViewController.h"

@interface ImageTableViewController ()

@end

@implementation ImageTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) createProgressionAlertWithMessage:(NSString *)message withProgressBar:(BOOL)activity
{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    progressAlert = [[UIAlertView alloc] initWithTitle: message
                                               message: @"Please wait..."
                                              delegate: self
                                     cancelButtonTitle: nil
                                     otherButtonTitles: nil];
    progressAlert.delegate = self;
    if (activity) {
        progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(30.0f, 80.0f, 225.0f, 90.0f)];
        [progressAlert addSubview:progressBar];
        [progressBar setProgressViewStyle: UIProgressViewStyleBar];
    } else {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake(139.0f-18.0f, 100.0f, 37.0f, 37.0f);
        [progressAlert addSubview:activityView];
        [activityView startAnimating];
    }
    [progressAlert show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
}

- (void)dismissProgressAlert
{
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    progressAlert.delegate = nil;
    [progressAlert dismissWithClickedButtonIndex:0 animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    //if ([searchTextField.text isEqualToString:@""])
       // searchTextField.text = @"food";
    NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:totalResultsTextField.text];
    if (![_NumericOnly isSupersetOfSet: myStringSet] || [totalResultsTextField.text isEqualToString:@""])
        totalResultsTextField.text = @"8";
    
    [textField resignFirstResponder];
    [self createProgressionAlertWithMessage:@"Loading Images" withProgressBar:YES];
    [self performSelectorInBackground:@selector(refetchImages) withObject:nil];
    return YES;
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    //after animation
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
        textField.text = @"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    path = [NSArray arrayWithObjects:[[NSBundle mainBundle] pathForResource:@"Map Ames Fall 12 small" ofType:@"png"],[[NSBundle mainBundle] pathForResource:@"redA1 small" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"green2 small" ofType:@"png"],[[NSBundle mainBundle] pathForResource:@"Blue Route small" ofType:@"png"],nil];
    titlePic = [NSArray arrayWithObjects:@"2012/2013 Whole Map", @"#1 Red",@"#2 Green",@"#3 Blue",nil];
    
    
    //searchTextField.text = @"food";
    totalResultsTextField.text = @"8";
    //searchTextField.returnKeyType = UIReturnKeyDone;
    totalResultsTextField.returnKeyType = UIReturnKeyDone;
    
    _selectedSection = 0;
    _selectedRow = 0;
    _imageTitles = [[NSArray alloc] init];
    imageIDs = [[NSMutableArray alloc] init];
    imageThumbnails = [[NSMutableArray alloc] init];
    
    //deviantART
    imageThumbnailsDA = [[NSMutableArray alloc] init];
    _imageURLsDA = [[NSMutableArray alloc] init];
    _imageTitles =titlePic;
    //[self fetchImages];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

int countFlickr;
NSString *flickrAPIKey = @"78bd5fd661d75a1703ae1c533a30fae1";
- (void)fetchImages
{
    NSLog(@"FETCH");
    NSString *flickrText = [@"food" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *apiCall = @"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=%@&format=json&nojsoncallback=1&sort=relevance";
    NSString *urlString = [NSString stringWithFormat:apiCall, flickrAPIKey, flickrText, totalResultsTextField.text];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *results = [jsonString JSONValue];
    
    NSArray *images = [[results objectForKey:@"photos"] objectForKey:@"photo"];
    dispatch_async(dispatch_get_main_queue(), ^{
    countFlickr = 0;
    progressAlert.title = @"Retrieving Flickr Images";
    });
    for (NSDictionary *image in images) {
        // Get the title for each photo
        //NSString *title = [image objectForKey:@"title"];
       
        // Construct the URL for each photo
      //  NSString *imageURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_n.jpg", //n better quality, s smallest square
     //                               [image objectForKey:@"farm"],
       //                             [image objectForKey:@"server"],
         //                           [image objectForKey:@"id"],
           //                         [image objectForKey:@"secret"]];
        //[imageThumbnails addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLString]]]];
        //NSLog(@"%@",[self fetchLargestImageSizeURL:[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=%@&photo_id=%@&format=json&nojsoncallback=1",flickrAPIKey,[image objectForKey:@"id"] ]]);
        //[imageIDs addObject:[image objectForKey:@"id"]];
        //[_imageURLs addObject:[imageURLString stringByReplacingCharactersInRange:NSMakeRange(imageURLString.length-5,1) withString:@"o"]];
        //dispatch_async(dispatch_get_main_queue(), ^{
        //NSLog(@"Flickr %d",countFlickr++);
        //progressAlert.title = [NSString stringWithFormat:@"Retrieving Flickr %d",countFlickr];
        //progressAlert.message = [NSString stringWithFormat:@"Loading Cyride Map"];
        //[progressBar setProgress:((float)countFlickr/[totalResultsTextField.text floatValue])*0.5 animated:YES];
        //});
    }
   // NSLog(@"%@",[@"food" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
   // NSString *dARSSCall = @"http://backend.deviantart.com/rss.xml?type=deviation&q=boost%3Apopular+in%3Adigitalart%2Fdrawings+";
   // [self parseXMLFileAtURL:[NSString stringWithFormat:@"%@%@",dARSSCall,[@"food" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ]];

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
// fixed font style. use custom view (UILabel) if you want something different
{
//    if (section == 0){
//        return [NSString stringWithFormat:@"flickr Image Fetcher"];
//    }else{
//        return [NSString stringWithFormat:@"deviantART Image Fetcher"];
    return @"";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return path.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row < [path count]){
        if ([_imageTitles count] > indexPath.row){
           cell.textLabel.text = [titlePic objectAtIndex:indexPath.row];
        
         
        cell.imageView.image = [UIImage imageWithContentsOfFile:[path objectAtIndex: indexPath.row]];
        cell.userInteractionEnabled=YES;
        }else{//cell.textLabel.text=@"UNAVAILABLE";
            cell.imageView.image=nil;
            cell.userInteractionEnabled=NO;}
//    }else{
//        if ([_articles count] > indexPath.row){
//            NSString *title = [[_articles objectAtIndex:indexPath.row] objectForKey:@"media:title"];
//            title = [title substringToIndex:title.length-9];
//        cell.textLabel.text = @"Cyride Map";
//
//            cell.imageView.image = [UIImage imageWithContentsOfFile:[path objectAtIndex:indexPath.section]];
//        cell.userInteractionEnabled=YES;
//        }else{//cell.textLabel.text=@"UNAVAILABLE";
//            
//            cell.imageView.image=nil;cell.userInteractionEnabled=NO;}
    }
   // cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //cell.textLabel.numberOfLines = 0;
   // cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setSelectedSection:indexPath.section];
    [self setSelectedRow:indexPath.row];
 
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [self createProgressionAlertWithMessage:[NSString stringWithFormat:@"Loading:\n %@",selectedCell.textLabel.text] withProgressBar:NO];
    [self performSelectorInBackground:@selector(presentLargeImage) withObject:nil];

}

-(void)presentLargeImage{
    [self performSegueWithIdentifier:@"pushImageZoomVC" sender:self];
    [self dismissProgressAlert];
}

@end
