//
//  DetailViewController.h
//  IDS
//
//  Created by Sakarn Limnitikarn on 24/01/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (nonatomic, retain) NSString *detail;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@end
