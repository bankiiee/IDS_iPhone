//
//  AppDelegate.h
//  IDS_NOSTRB
//
//  Created by Sakarn Limnitikarn on 24/01/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData/CoreData.h"
#import "Member.h"
#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"
#import "MBProgressHUD.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate,UIActionSheetDelegate, UITabBarControllerDelegate, UIAlertViewDelegate, UINavigationBarDelegate, UINavigationControllerDelegate,MBProgressHUDDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property(strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UITextField *usernameField, *passwordField;
-(void)loginButtonPressed;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;  
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentCoordinator;
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;  
@property (nonatomic, retain) MainViewController *main;
@property (nonatomic, retain) NSString *usernameStr;
@property (nonatomic, retain) NSMutableData *responseData;

@property (nonatomic, retain) NSMutableArray *memberArray;   
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic,retain) NSUserDefaults *userPref;



- (void)myTask;
- (IBAction)showSimple:(id)sender;
- (IBAction)showWithLabel:(id)sender AndUsername:(NSString *)username;
-(void)switchView;
- (void) fetchRecords;  
- (void) addMember:(id)sender;  
-(void) saveData;
-(BOOL)doLogin:(NSString *)username andPassword:(NSString *)password;
@end
