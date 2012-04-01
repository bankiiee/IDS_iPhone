//
//  DetailViewController.h
//  IDS
//
//  Created by Sakarn Limnitikarn on 24/01/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>


@interface DetailViewController : UIViewController<NSURLConnectionDelegate>
@property (nonatomic, retain) NSString *topic;
@property (nonatomic,retain) NSString *story;
@property (nonatomic,retain)NSString *picPath;
@property (nonatomic,retain)NSString *newsid;
@property (nonatomic,retain) NSMutableData *responseData;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) UIViewController *tweetView;
@end
