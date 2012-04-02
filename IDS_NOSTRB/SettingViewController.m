//
//  SettingViewController.m
//  IDS
//
//  Created by Sakarn Limnitikarn on 24/01/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import "SettingViewController.h"
#import "DeveloperSettingViewController.h"
#import "MBProgressHUD.h"


@implementation SettingViewController

@synthesize HUD,userPref;
- (id)initWithStyle:(UITableViewStyle)style
{   
    style = UITableViewStyleGrouped;
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self setTitle:@"Setting"];
        [self.tabBarItem setImage:[UIImage imageNamed:@"20-gear2.png"]];
        [self.navigationController setTitle:@"Setting"];
        [self.tableView setBounces:YES];
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneSetting)];
        self.navigationItem.rightBarButtonItem = right;
        
    }
   
    return self;
}
-(void)doneSetting{
    NSLog(@"Done Setting");
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userPref = [NSUserDefaults standardUserDefaults];
    [self.userPref synchronize];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if(section == 0 || section == 2){
        return 1;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    if(indexPath.section == 0){
        [cell.textLabel setText:@"Developer Mode"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell.imageView setImage:[UIImage imageNamed:@"157-wrench.png"]];
    }
    if(indexPath.section == 2){
        NSString *usernamelogout = [NSString stringWithFormat:@"Logout : %@",[self.userPref objectForKey:@"username"]];
        [cell.textLabel setText:usernamelogout];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell.imageView setImage:[UIImage imageNamed:@"63-runner.png"]];
        
        
    }if(indexPath.section == 1){
        if(indexPath.row == 0){
            [cell.textLabel setText:@"Update Your Profile"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell.imageView setImage:[UIImage imageNamed:@"123-id-card.png"]];
        }
        if(indexPath.row == 1){
            [cell.textLabel setText:@"Location Service"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
            cell.accessoryView = switchview;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            switchview.tag = 0;
            [switchview addTarget:self action:@selector(setLocationService:) forControlEvents:UIControlEventTouchUpInside];
            NSLog(@"%@",switchview.isOn);
            [cell.imageView setImage:[UIImage imageNamed:@"193-location-arrow.png"]];
        }
    }

    
    
    return cell;
}

-(void)setLocationService:(id)sender{
    UISwitch *sw = (UISwitch *)sender;
    if(sw.isOn){
         NSLog(@"Switch on Location is ON");
    }else{
        NSLog(@"Switch on Location is OFF");

    }
   
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if(indexPath.section == 0 ){
        DeveloperSettingViewController *devView = [[DeveloperSettingViewController alloc]init];
        [devView setTitle:@"Developer Setting"];
        [self.navigationController pushViewController:devView animated:YES];
    }if(indexPath.section == 2){
        UIActionSheet *logoutConfirmSheet = [[UIActionSheet alloc]initWithTitle:@"You are about to logout from this application, are you sure?" delegate:self cancelButtonTitle:@"Not Rightnow." destructiveButtonTitle:@"Yes, I'm sure." otherButtonTitles:nil, nil];
        [logoutConfirmSheet showInView:self.view];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        [self showWithLabel:self];
    }
}
- (IBAction)showSimple:(id)sender {
    // The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
	
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
	
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}
- (IBAction)showWithLabel:(id)sender {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = @"Logging Out, then App will exit.";
	
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    [self.userPref setBool:NO forKey:@"isLogin"];
    [self.userPref synchronize];
    sleep(5);
    exit(0);
}

@end
