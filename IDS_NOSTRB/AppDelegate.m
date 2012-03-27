//
//  AppDelegate.m
//  IDS_NOSTRB
//
//  Created by Sakarn Limnitikarn on 24/01/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import "AppDelegate.h"

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



@implementation AppDelegate
@synthesize main, HUD, responseData, userPref;

@synthesize window = _window, navigationController, usernameField,passwordField,memberArray, managedObjectContext,managedObjectModel,persistentCoordinator, usernameStr;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
 //   UIViewController *viewController1, *viewController2;
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPhone" bundle:nil];
//        viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPhone" bundle:nil];
//    } else {
//        viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPad" bundle:nil];
//        viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPad" bundle:nil];
//    }
    
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
       NSLog(@"After managedObjectContext: %@",  managedObjectContext);
    }

   // MainViewController *main = [[MainViewController alloc]init];
    NSLog(@"%@",[self.userPref boolForKey:@"isLogin"]);
    if(![self.userPref boolForKey:@"isLogin"]){
        [self loginButtonPressed];
    }
    self.main = [[MainViewController alloc]init];
  NewsTypeViewController *newstype = [[NewsTypeViewController alloc]init];
    SampleWebViewController *sampleWeb = [[SampleWebViewController alloc]init];
    LecturerListViewController *lecturer = [[LecturerListViewController alloc]init];
    AboutViewController *aboutView = [[AboutViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:main];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:newstype];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:lecturer];
    UINavigationController *aboutNav = [[UINavigationController alloc]initWithRootViewController:aboutView];

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,sampleWeb,aboutNav,nil];
    //add navigation controller
    self.navigationController = [[UINavigationController alloc]init];
    
    //self.window.rootViewController = self.navigationController;
    //[self.navigationController pushViewController:self.tabBarController animated:YES];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    // Set the application defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:@"enableRotation"];
    [defaults registerDefaults:appDefaults];
    [defaults synchronize];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    NSLog(@"Today : %@",today);
    NSLog(@"Tomorrow : %@",tomorrow);  
    
    return YES;
}
-(void)loginButtonPressed{
    UIAlertView *loginForm = [[UIAlertView alloc]initWithTitle:@"Please Login" message:@"Please Login" delegate:self cancelButtonTitle:@"Login" otherButtonTitles:@"Cancel", nil];
    self.usernameField = [[UITextField alloc]init ];
    self.passwordField = [[UITextField alloc]init];
    loginForm.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    //[loginForm addSubview:self.usernameField];
    // [loginForm addSubview:self.passwordField];
    [loginForm setTag:1];
    [loginForm show];
   
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1){
    if(buttonIndex == 0){
    UITextField *username = [alertView textFieldAtIndex:0];
       // [username setText:@"it51070089"];
    UITextField *password = [alertView textFieldAtIndex:1];
        //[password setText:@"9ddt+9ddt"];
   // BOOL result = [self doLogin:username.text andPassword:password.text];
        BOOL result = YES;   
        if(result){
            //[self showWithLabel:self AndUsername:[self doQueryNameFromUsername:username.text]];
            NSLog(@"username is %@, and password is %@",username.text, password.text);
            
            // [self addMember:nil];
            //  [self fetchRecords];
           // self.usernameStr = [self doQueryNameFromUsername:username.text];
            //  [self saveData];
            [self.userPref setBool:YES forKey:@"isLogin"];
            [self.userPref synchronize];

        }else{
//            UIActionSheet *error = [[UIActionSheet alloc]initWithTitle:@"Invalid Username and Password" delegate:self cancelButtonTitle:@"Try Again" destructiveButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
//            [error showInView:self.window];
            UIAlertView *error = [[UIAlertView alloc]initWithTitle:@"Invalid Username or Password" message:@"Please try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Try Again",@"Cancel" ,nil];
            [error setTag:2];
            [error show];

        }
       }else{
           [self showWithCustomLabel:self AndCustom:@"Application is exiting....."];
           //exit(1);
       }
    }else{
        if(buttonIndex == 1){
            [self showWithCustomLabel:self AndCustom:@"Application is exiting....."];
            //exit(0);
        }else{
            [self loginButtonPressed];
        }
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag == 2){
        
    }else{
    if(buttonIndex == 1){
        [self loginButtonPressed];
    }else {
        exit(0);
    }
    }
}
-(BOOL)doLogin:(NSString *)username andPassword:(NSString *)password{
    NSString *npassword = [[NSString stringWithString:password] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString *post =[NSString stringWithFormat:@"username=%@&password=%@",username,npassword];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://169.254.18.105:8084/IDS/MobileDoLoginServlet?"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",data);
    if([data isEqualToString:@"true"]){
        return true;
    }else{
    return false;
    }
}
-(NSString *)doQueryNameFromUsername:(NSString *)username{
        
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *url = [NSString stringWithFormat:@"http://169.254.18.105:8084/IDS/mobileQuery.jsp?username=%@", username];
    [request setURL:[NSURL URLWithString:url]];
   
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",data);
    NSString *result = [[NSString stringWithString:data] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return result;
}


- (IBAction)showWithLabel:(id)sender AndUsername:(NSString *)username{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.window addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = [NSString stringWithFormat:@"%@ is Loggin In.",username];
	
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}
- (IBAction)showWithCustomLabel:(id)sender AndCustom:(NSString *)customLabel{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.window addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = [NSString stringWithFormat:@"%@",customLabel];
	
    [HUD showWhileExecuting:@selector(myTask2) onTarget:self withObject:nil animated:YES];
}

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(5);
   
}
- (void)myTask2{
    // Do something usefull in here instead of sleeping ...
    sleep(5);
    exit(0);
    
}


- (void) saveData
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSManagedObject *userInfo;
    
    userInfo = [NSEntityDescription insertNewObjectForEntityForName:@"Member" inManagedObjectContext:context];
    
    [userInfo setValue:self.usernameStr forKey:@"userid"];
        
        
    NSError *error;
    [context save:&error];
	NSLog(@"Saved!!");
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
