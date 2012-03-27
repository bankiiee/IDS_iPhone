//
//  ViewController.m
//  IDS
//
//  Created by Sakarn Limnitikarn on 18/01/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize serverStatusLabel;
@synthesize username;
@synthesize password;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setUsername:nil];
    [self setPassword:nil];
    [self setServerStatusLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)loginButton:(id)sender {
    NSString *status = [[NSString alloc]initWithFormat:@"%@,%@",self.username.text,self.password.text];
    UIAlertView *loginStatus = [[UIAlertView alloc]initWithTitle:@"Loging In..." message:status delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [loginStatus show];
    MainViewController *main = [[MainViewController  alloc]initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:main animated:YES];        
}

- (IBAction)resetButton:(id)sender {
}

- (IBAction)resignTextResponderButton:(id)sender {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}
@end
