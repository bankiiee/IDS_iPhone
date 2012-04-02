//
//  SettingViewController.h
//  IDS
//
//  Created by Sakarn Limnitikarn on 24/01/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SettingViewController : UITableViewController<UIActionSheetDelegate,MBProgressHUDDelegate>

@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) NSUserDefaults *userPref;
- (void)myTask;
- (IBAction)showSimple:(id)sender;
- (IBAction)showWithLabel:(id)sender;

@end
