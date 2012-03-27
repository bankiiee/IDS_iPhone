//
//  DispatchViewController.m
//  IDS_NOSTRB
//
//  Created by Sakarn Limnitikarn on 13/03/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import "DispatchViewController.h"
#import "FirstViewController.h"

#import "SecondViewController.h"
#import "MainViewController.h"
#import "NewsTypeViewController.h"
#import "SettingViewController.h"
#import "SampleWebViewController.h"
#import "LecturerListViewController.h"
#import "SettingViewController.h"
#import "AboutViewcontroller.h"
#import "DispatchViewController.h"

@interface DispatchViewController ()

@end

@implementation DispatchViewController
@synthesize username;
@synthesize password;

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
}
- (void) viewWillAppear:(BOOL)animated{
    [UIView setAnimationDuration:2.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)viewDidUnload
{
    [self setUsername:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





- (IBAction)loginButtonPressed:(id)sender {
    MainViewController *mainView = [[MainViewController  alloc]init];
    NewsTypeViewController *newstype = [[NewsTypeViewController alloc]init];
    SampleWebViewController *sampleWeb = [[SampleWebViewController alloc]init];
    LecturerListViewController *lecturer = [[LecturerListViewController alloc]init];
    AboutViewController *aboutView = [[AboutViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:mainView];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:newstype];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:lecturer];
    UINavigationController *aboutNav = [[UINavigationController alloc]initWithRootViewController:aboutView];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,sampleWeb,aboutNav,nil];
    //add navigation controller
    self.view.window.rootViewController = mainView;
    //self.window.rootViewController = self.navigationController;
    //[self.navigationController pushViewController:self.tabBarController animated:YES];
}
@end
