//
//  DetailViewController.m
//  IDS
//
//  Created by Sakarn Limnitikarn on 24/01/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController
@synthesize topic,story,picPath,responseData, tweetView,newsid;
@synthesize detailLabel;
@synthesize textView;
@synthesize picView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.detailLabel setText:self.topic];
    [self.textView setText:self.story];
    self.responseData = [[NSMutableData alloc]init];

    NSString *url = [NSString stringWithFormat:@"http://localhost:8084/IDS/%@",self.picPath];
    NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection connectionWithRequest:request delegate:self];

    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *tweet = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(doTweet)];
    self.navigationItem.rightBarButtonItem = tweet;    
    
}
- (void) doTweet{
    if ([TWTweetComposeViewController canSendTweet]) // Check if twitter is setup and reachable
    {
        TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
        
        // set initial text
        if([self.story length]>100){
            NSString *tweetMsg = [NSString stringWithFormat:@"%@ - %@ - via IDS",self.topic,[self.story substringToIndex:90]];
            [tweetViewController setInitialText:tweetMsg];
        }else {
            NSString *tweetMsg = [NSString stringWithFormat:@"%@ - %@ - via IDS",self.topic,self.story];
            [tweetViewController setInitialText:tweetMsg];

        }
        
        
        [tweetViewController setModalPresentationStyle:UIModalPresentationFormSheet];
    
        // setup completion handler
        tweetViewController.completionHandler = ^(TWTweetComposeViewControllerResult result) {
            if(result == TWTweetComposeViewControllerResultDone) {
                // the user finished composing a tweet
                [self dismissModalViewControllerAnimated:YES];
            } else if(result == TWTweetComposeViewControllerResultCancelled) {
                // the user cancelled composing a tweet
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        // present view controller
        [self presentViewController:tweetViewController animated:YES completion:nil];
        
    }
    else
    {
        // Twitter account not configured, inform the user
        NSLog(@"NO TWITTER ACCOUNT CONFIGURED. DO SOMETHING");
    }

    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
   // NSLog(@"%@",self.responseData);
    if (self.responseData) {
        self.picView.image = [UIImage imageWithData:self.responseData];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
    NSLog(@"Received Resposne");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
      NSLog(@"Received Data %@",data);
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	self.responseData = nil;
    NSLog(@"Received Failed");
    
}



- (void)viewDidUnload
{
    [self setDetailLabel:nil];
    [self setTextView:nil];
    [self setPicView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
