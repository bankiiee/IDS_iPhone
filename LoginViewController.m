//
//  LoginViewController.m
//  IDS_NOSTRB
//
//  Created by Sakarn Limnitikarn on 4/11/55 BE.
//  Copyright (c) 2555 bankiiee@gmail.com. All rights reserved.
//

#import "LoginViewController.h"
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
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize username, tab, HUD, userPref;
@synthesize password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.userPref = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    MainViewController *main = [[MainViewController alloc]init];
    NewsTypeViewController *newstype = [[NewsTypeViewController alloc]init];
      SampleWebViewController *sampleWeb = [[SampleWebViewController alloc]init];
        LecturerListViewController *lecturer = [[LecturerListViewController alloc]init];
        AboutViewController *aboutView = [[AboutViewController alloc]init];
        UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:main];
        UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:newstype];
        UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:lecturer];
        UINavigationController *aboutNav = [[UINavigationController alloc]initWithRootViewController:aboutView];
    
        self.tab = [[UITabBarController alloc] init];
        self.tab.viewControllers = [NSArray arrayWithObjects:nav1,nav3,sampleWeb,aboutNav,nil];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:@"enableRotation"];
    [defaults registerDefaults:appDefaults];
    [defaults synchronize];
    
    
    
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

- (IBAction)doLogin:(id)sender {

    BOOL result = [self doLogin:username.text andPassword:password.text];
    // BOOL result = YES;   
    if(result){
       // [self showWithLabel:self AndUsername:[self doQueryNameFromUsername:username.text]];
        NSLog(@"username is %@, and password is %@",username.text, password.text);
    
        // [self addMember:nil];
        //[self fetchRecords];
       
         NSString *usernameStr = [self doQueryNameFromUsername:username.text];
        //[self saveData];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login Success" message:@"Welcome!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self.userPref setBool:YES forKey:@"isLogin"];
        [self.userPref setValue:username.text forKey:@"username"];
        [self.userPref synchronize];
        AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        [delegate switchView];    
        

                 
    }else{
        //            UIActionSheet *error = [[UIActionSheet alloc]initWithTitle:@"Invalid Username and Password" delegate:self cancelButtonTitle:@"Try Again" destructiveButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        //            [error showInView:self.window];
        
        UIAlertView *error = [[UIAlertView alloc]initWithTitle:@"Invalid Username or Password" message:@"Please try again" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Try Again",@"Cancel" ,nil];
        [error setTag:2];
        [error show];
        
    }

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([self.username isFirstResponder]){
        [self.password becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
}

-(BOOL)doLogin:(NSString *)username andPassword:(NSString *)password{
    NSString *npassword = [[NSString stringWithString:password] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString *post =[NSString stringWithFormat:@"username=%@&password=%@",username,npassword];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://localhost:8084/IDS/MobileDoLoginServlet?"]];
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
    NSString *url = [NSString stringWithFormat:@"http://localhost:8084/IDS/mobileQuery.jsp?username=%@", username];
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
	[self.view.window addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = [NSString stringWithFormat:@"%@ is Loggin In.",username];
	
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}
- (IBAction)showWithCustomLabel:(id)sender AndCustom:(NSString *)customLabel{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.view addSubview:HUD];
	
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


@end
