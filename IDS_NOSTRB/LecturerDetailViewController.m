//
//  LecturerDetailViewController.m
//  IDS_NOSTRB
//
//  Created by Sakarn Limnitikarn on 4/2/55 BE.
//  Copyright (c) 2555 bankiiee@gmail.com. All rights reserved.
//

#import "LecturerDetailViewController.h"
#import "SampleWebViewController.h"

@interface LecturerDetailViewController ()

@end

@implementation LecturerDetailViewController
@synthesize nameLabel;
@synthesize roomLabel;
@synthesize statusButton;
@synthesize statusLabel;
@synthesize name,room,status,lid;
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
    // Do any additional setup after loading the view from its nib.
    [self.nameLabel setText:self.name];
    [self.roomLabel setText:self.room];
    [self.statusLabel setText:self.status];
    if([self.status isEqualToString:@"In-Office"]){
        [self.statusLabel setTextColor:[UIColor greenColor]];
    }else{
        [self.statusLabel setTextColor:[UIColor redColor]];

    }
NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
[user synchronize];
NSString *uname = [user objectForKey:@"username"];
if([uname hasPrefix:@"it"]){
    [self.statusButton removeFromSuperview];
}
}

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setRoomLabel:nil];
    [self setStatusLabel:nil];
    [self setStatusButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doChangeStatus:(id)sender {
    SampleWebViewController *sam = [[SampleWebViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:sam];
    [self.navigationController presentModalViewController:nav animated:YES];   
}
@end
