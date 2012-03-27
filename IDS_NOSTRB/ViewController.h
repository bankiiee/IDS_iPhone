//
//  ViewController.h
//  IDS
//
//  Created by Sakarn Limnitikarn on 18/01/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)loginButton:(id)sender;
- (IBAction)resetButton:(id)sender;
- (IBAction)resignTextResponderButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *serverStatusLabel;

@end
