//
//  LecturerDetailViewController.h
//  IDS_NOSTRB
//
//  Created by Sakarn Limnitikarn on 4/2/55 BE.
//  Copyright (c) 2555 bankiiee@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LecturerDetailViewController : UIViewController
@property (nonatomic, retain) NSString *name;
@property (nonatomic,retain) NSString *room;
@property (nonatomic,retain)NSString *status;
@property (nonatomic,retain)NSString *lid;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
- (IBAction)doChangeStatus:(id)sender;
@end
