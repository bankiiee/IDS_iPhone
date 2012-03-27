//
//  MainViewController.h
//  IDS
//
//  Created by Sakarn Limnitikarn on 23/01/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface MainViewController : UITableViewController <MBProgressHUDDelegate,UITabBarControllerDelegate, UIActionSheetDelegate>
{
    BOOL isWaitingForTitle;
    BOOL isWaitingForLink;
    BOOL isWaitingForDescription;
    BOOL isReadingTitle ;
    BOOL isReadingLink ;
    BOOL isReadingDescription ;
    int numberOfElement;
    //BOOL isWaitingForBody;
    UITextField *toField;
    UITextField *fromField;
    UILabel *HeadingText;
    UITextView *bodyField;
    long long expectedLength;
	long long currentLength;
}
@property (retain, nonatomic) IBOutlet UITextView *bodyField;
@property (retain, nonatomic) IBOutlet UILabel *HeadingText;
@property (retain, nonatomic) IBOutlet UITextField *fromField;
@property (nonatomic, retain) NSMutableDictionary *parsedData;
@property (retain, nonatomic) IBOutlet UITextField *toField;
@property (nonatomic, retain) NSMutableArray *feed;
@property (nonatomic, retain) NSMutableDictionary *feedElement;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) NSString *username;
-(void)loadSettingPanel;
-(void)refreshFeed:(id)sender;
-(void)reloadFeed;
-(void)swipeDetected:(id)sender;

- (void)myTask;
- (void)myProgressTask;
- (void)myMixedTask;

- (IBAction)showSimple:(id)sender;
- (IBAction)showWithLabel:(id)sender;
- (IBAction)showWithDetailsLabel:(id)sender;
- (IBAction)showWithLabelDeterminate:(id)sender;
- (IBAction)showWithCustomView:(id)sender;
- (IBAction)showWithLabelMixed:(id)sender;
- (IBAction)showUsingBlocks:(id)sender;
- (IBAction)showOnWindow:(id)sender;
- (IBAction)showURL:(id)sender;

@end
