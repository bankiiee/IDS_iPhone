//
//  DispatchViewController.h
//  IDS_NOSTRB
//
//  Created by Sakarn Limnitikarn on 13/03/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DispatchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)loginButtonPressed:(id)sender;

@end
