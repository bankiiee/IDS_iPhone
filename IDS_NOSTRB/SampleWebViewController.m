//
//  SampleWebViewController.m
//  IDS_NOSTRB
//
//  Created by Sakarn Limnitikarn on 24/01/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import "SampleWebViewController.h"
#import "SettingViewController.h"

@implementation SampleWebViewController
@synthesize webView;
@synthesize indicator; 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Web View"];
        self.tabBarItem.image = [UIImage imageNamed:@"175-macbook.png"];  
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"Setting" style:UIBarButtonItemStyleDone target:self action:@selector(loadSettingPanel)];
        self.navigationItem.rightBarButtonItem = right;
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshFeed:)];
        self.navigationItem.leftBarButtonItem = left;
        self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicator.center = self.view.center;
        [self.view addSubview:self.indicator];

        [self.indicator startAnimating];
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

    
    
    [self.view addSubview:self.indicator];
    self.indicator.center = self.view.center;
    [self.indicator startAnimating];
    //Load web view data
    NSString *strWebsiteUlr = [NSString stringWithFormat:@"http://smo.it.kmitl.ac.th:8088/IDS/m"];
    
    // Load URL
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:strWebsiteUlr];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [self.webView loadRequest:requestObj];
}
-(void)loadSettingPanel{
    SettingViewController *settingPanel = [[SettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:settingPanel];
    [self.navigationController presentModalViewController:nav animated:YES];    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    //[self.indicator setCenter:CGPointMake(self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.indicator];
    [self.indicator startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.indicator stopAnimating];
    //[self.indicator removeFromSuperview];
    [self.indicator setHidesWhenStopped:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.webView reload];
   //[self.view addSubview:self.indicator];
    [self.indicator startAnimating];
}
- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setIndicator:nil];
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
