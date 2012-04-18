//
//  LoginViewController.h
//  IDS_NOSTRB
//
//  Created by Sakarn Limnitikarn on 4/11/55 BE.
//  Copyright (c) 2555 bankiiee@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic)UITabBarController *tab;
@property (weak, nonatomic) NSUserDefaults *userPref;
@property (nonatomic, retain) MBProgressHUD *HUD;

- (IBAction)doLogin:(id)sender;

@end
