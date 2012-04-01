//
//  MainViewController.m
//  IDS
//
//  Created by Sakarn Limnitikarn on 23/01/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "SettingViewController.h"


@implementation MainViewController
@synthesize bodyField;
@synthesize HeadingText;
@synthesize fromField;
@synthesize parsedData;
@synthesize toField, feed, feedElement,HUD, username;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self setTitle:@"IDS Feed"];
        self.tabBarItem.image = [UIImage imageNamed:@"09-chat-2.png"];  
        //[self.navigationController setTitle:@"Main"];
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"Setting" style:UIBarButtonItemStyleDone target:self action:@selector(loadSettingPanel)];
        self.navigationItem.rightBarButtonItem = right;
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshFeed:)];
        self.navigationItem.leftBarButtonItem = left;
        self.feed = [[NSMutableArray alloc]init ];
        self.feedElement  = [[NSMutableDictionary alloc]init];
        //Swipe Down Detection 
        UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDetected:)];
        swipeRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
        [swipeRecognizer setDelaysTouchesEnded:NO];
        [swipeRecognizer setDelaysTouchesBegan:YES];
        [self.tableView addGestureRecognizer:swipeRecognizer];
    }
    return self;
}
-(void)loadSettingPanel{
    SettingViewController *settingPanel = [[SettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:settingPanel];
    [self.navigationController setModalInPopover:YES];

    [self.navigationController presentModalViewController:nav animated:YES];

    [settingPanel setTitle:@"Setting"];
    
    
}
-(void)swipeDetected:(id)sender{
    NSLog(@"Swipe Down Detected");
    [self showWithLabelDeterminate:self];
    [self.tableView reloadData];
   }

-(void)refreshFeed:(id)sender{
    [self showWithLabelDeterminate:self];
    self.feed = [[NSMutableArray alloc]init];
    [self reloadFeed];
    [self.tableView reloadData];
}
-(void)reloadFeed{
    isWaitingForTitle = NO;
    isWaitingForLink = NO;
    isWaitingForDescription = NO;
    isReadingTitle = NO;
    isReadingLink = NO;
    isReadingDescription = NO;
    numberOfElement = 0;
    //isWaitingForBody = NO;
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"idsfeed" ofType:@"xml"];
//    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
       NSURL *url = [NSURL URLWithString:@"http://localhost:8084/IDS/idsfeed.xml"];
        NSData *myData = [NSData dataWithContentsOfURL:url];
    if (myData) {
        // Start parsing
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:myData];
        parser.delegate = self;
        [parser parse];
    }
    NSLog(@"Number of feed Elements : %d",numberOfElement);
    NSLog(@"Number of feed Elements : %d",[self.feed count]);

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

    
    isWaitingForTitle = NO;
    isWaitingForLink = NO;
    isWaitingForDescription = NO;
    isWaitingForNewsID = NO;
    isReadingTitle = NO;
    isReadingLink = NO;
    isReadingDescription = NO;
    isReadingNewsID = NO;
    numberOfElement = 0;
//    //isWaitingForBody = NO;
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"idsfeed" ofType:@"xml"];
//    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8084/IDS/idsfeed.xml"];
    NSData *myData = [NSData dataWithContentsOfURL:url];
    if (myData) {
        // Start parsing
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:myData];
        parser.delegate = self;
        [parser parse];
    }
    NSLog(@"Number of feed Elements : %d",numberOfElement);
    NSLog(@"Number of feed Elements : %d",[self.feed count]);

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"title"]) {
        NSLog(@"<--- Start %@ ---> ", elementName);
        isWaitingForTitle = NO;
        isWaitingForDescription = YES;
        isWaitingForLink = YES;
        isWaitingForNewsID = YES;
        isReadingTitle = YES;
    }
    if ([elementName isEqualToString:@"description"]) {
        NSLog(@"<--- Start %@ ---> ", elementName);
        isWaitingForTitle = NO;
        isWaitingForDescription = NO;
        isWaitingForLink = YES;
        isWaitingForNewsID = YES;
        isReadingDescription = YES;


    }
    if ([elementName isEqualToString:@"attachment"]) {
        NSLog(@"<--- Start %@ ---> ", elementName);
        isWaitingForTitle = NO;
        isWaitingForDescription = NO;
        isWaitingForLink = NO;
        isWaitingForNewsID = YES;
        isReadingLink = YES;

    }
    if ([elementName isEqualToString:@"newsid"]) {
        NSLog(@"<--- Start %@ ---> ", elementName);
        isWaitingForTitle = NO;
        isWaitingForDescription = NO;
        isWaitingForLink = NO;
        isWaitingForNewsID = NO;
        isReadingNewsID = YES;
        
    }


}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(isReadingTitle == YES){
    NSLog(@"Found TITLE %@", string);
        [self.feedElement setObject:string forKey:@"title"];
    }
    if(isReadingDescription == YES){
        NSLog(@"Found DESCRIPTION %@", string);
        [self.feedElement setObject:string forKey:@"description"];
    }
    if(isReadingLink == YES){
        NSLog(@"Found ATTCH %@", string);
        [self.feedElement setObject:string forKey:@"attachment"];

    }
    if(isReadingNewsID == YES){
        NSLog(@"Found NewsID %@", string);
        [self.feedElement setObject:string forKey:@"newsid"];
        
    }
//    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"title"]) {
        isReadingTitle = NO;
    NSLog(@"<--- End Element %@ ---> ", elementName);
    }
    if ([elementName isEqualToString:@"description"]) {
        isReadingDescription = NO;
        NSLog(@"<--- End Element %@ ---> ", elementName);
    }
    if ([elementName isEqualToString:@"attachment"]) {
        isReadingLink = NO;
        NSLog(@"<--- End Element %@ ---> ", elementName);
    }
    if ([elementName isEqualToString:@"newsid"]) {
        isReadingNewsID = NO;
        NSLog(@"<--- End Element %@ ---> ", elementName);
        
        [self.feed addObject:self.feedElement];
        self.feedElement = [[NSMutableDictionary alloc]init];
        
        numberOfElement ++;
    }

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.feed count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *title = [NSString stringWithFormat:@"%@",[[self.feed objectAtIndex:indexPath.row]objectForKey:@"title"]];
    NSString *desc = [NSString stringWithFormat:@"%@",[[self.feed objectAtIndex:indexPath.row]objectForKey:@"description"]];
    NSString *link = [NSString stringWithFormat:@"%@",[[self.feed objectAtIndex:indexPath.row]objectForKey:@"link"]];
    [cell.textLabel setText:title];
    //[cell.detailTextLabel setText:link];
    [cell.detailTextLabel setText:@"Tap to read more"];
    [cell.imageView setImage:[UIImage imageNamed:@"124-bullhorn.png"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
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
    NSLog(@"%@",[[self.feed objectAtIndex:indexPath.row]objectForKey:@"description"]);
    DetailViewController *detailViewController = [[DetailViewController alloc]init];
    detailViewController.topic = [[self.feed objectAtIndex:indexPath.row]objectForKey:@"title"];
    detailViewController.story = [[self.feed objectAtIndex:indexPath.row]objectForKey:@"description"];
    detailViewController.picPath = [[self.feed objectAtIndex:indexPath.row]objectForKey:@"attachment"];
    detailViewController.newsid = [[self.feed objectAtIndex:indexPath.row]objectForKey:@"newsid"];

    [self.navigationController pushViewController:detailViewController animated:YES];
    
    
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
    HUD.labelText = @"Loading";
	
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (IBAction)showWithDetailsLabel:(id)sender {
	
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    HUD.detailsLabelText = @"updating data";
	HUD.square = YES;
	
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (IBAction)showWithLabelDeterminate:(id)sender {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
    // Set determinate mode
    HUD.mode = MBProgressHUDModeDeterminate;
    
	HUD.delegate = self;
    HUD.labelText = @"Loading";
	
	// myProgressTask uses the HUD instance to update progress
    [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}

- (IBAction)showWithCustomView:(id)sender {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
	
    HUD.delegate = self;
    HUD.labelText = @"Completed";
	
    [HUD show:YES];
	[HUD hide:YES afterDelay:3];
}

- (IBAction)showWithLabelMixed:(id)sender {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = @"Connecting";
	HUD.minSize = CGSizeMake(135.f, 135.f);
	
    [HUD showWhileExecuting:@selector(myMixedTask) onTarget:self withObject:nil animated:YES];
}

- (IBAction)showUsingBlocks:(id)sender {
#ifdef __BLOCKS__
	// No need to retain (just a local variable)
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
	hud.labelText = @"Loading";
	
	dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		// Do a taks in the background
		[self myTask];
		// Hide the HUD in the main tread 
		dispatch_async(dispatch_get_main_queue(), ^{
			[MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
		});
	});
#endif
}

- (IBAction)showOnWindow:(id)sender {
	// The hud will dispable all input on the window
    HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = @"Loading";
	
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (IBAction)showURL:(id)sender {
	NSURL *URL = [NSURL URLWithString:@"https://github.com/matej/MBProgressHUD/zipball/master"];
	NSURLRequest *request = [NSURLRequest requestWithURL:URL];
	
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection start];
	
	
	HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
}


- (IBAction)showWithGradient:(id)sender {
	
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	HUD.dimBackground = YES;
	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
	
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

#pragma mark -
#pragma mark Execution code

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

- (void)myProgressTask {
    // This just increases the progress indicator in a loop
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        HUD.progress = progress;
        usleep(50000);
    }
}

- (void)myMixedTask {
    // Indeterminate mode
    sleep(2);
    // Switch to determinate mode
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.labelText = @"Progress";
    float progress = 0.0f;
    while (progress < 1.0f)
    {
        progress += 0.01f;
        HUD.progress = progress;
        usleep(50000);
    }
    // Back to indeterminate mode
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"Cleaning up";
    sleep(2);
	// The sample image is based on the work by www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = @"Completed";
	sleep(2);
}

#pragma mark -
#pragma mark NSURLConnectionDelegete

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	expectedLength = [response expectedContentLength];
	currentLength = 0;
	HUD.mode = MBProgressHUDModeDeterminate;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	currentLength += [data length];
	HUD.progress = currentLength / (float)expectedLength;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
	[HUD hide:YES afterDelay:2];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[HUD hide:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    
	HUD = nil;
}

@end
