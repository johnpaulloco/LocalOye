//
//  HomeViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "HomeViewController.h"
#import "LeftMenuViewController.h"
#import "DIDatepicker.h"
#import "HomeViewTableViewCell.h"
#import "LocalOyeConstants.h"
#import "RequestResposeHandler.h"

#import "AFJSONRPCClient.h"

#import "MajorCategory.h"
#import "ChildCategory.h"

#import "ServiceDetailViewController.h"

//#import <Analytics/Analytics.h>

//#import "Helpshift.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet DIDatepicker *datepicker;


@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.headerLbl.font = [UIFont fontWithName:kLocalOyeFontBold size:14.0];
    
	self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 503);
	self.portraitSlideOffsetSegment.selectedSegmentIndex = [self indexFromPixels:[SlideNavigationController sharedInstance].portraitSlideOffset];
	self.landscapeSlideOffsetSegment.selectedSegmentIndex = [self indexFromPixels:[SlideNavigationController sharedInstance].landscapeSlideOffset];
	self.panGestureSwitch.on = [SlideNavigationController sharedInstance].enableSwipeGesture;
	self.shadowSwitch.on = [SlideNavigationController sharedInstance].enableShadow;
	self.limitPanGestureSwitch.on = ([SlideNavigationController sharedInstance].panGestureSideOffset == 0) ? NO : YES;
	self.slideOutAnimationSwitch.on = ((LeftMenuViewController *)[SlideNavigationController sharedInstance].leftMenu).slideOutAnimationEnabled;
    
    self.tableView.separatorColor = [UIColor lightGrayColor];
    
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftMenu.jpg"]];
    //self.tableView.backgroundView = imageView;
    
    //[self initiateGetCategoryAPI];
    
    //[self addProgressIndicator];
    
    //[self logAnalytics];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)addProgressIndicator
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(initiateGetCategoryAPI) onTarget:self withObject:nil animated:YES];
}

-(void)addProgressIndicatorQuestionApi
{
    //HUD = [[MBProgressHUD alloc] initWithView:self.view];
    //HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    //[self.view.window addSubview:HUD];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(initiateGetQuestionsAPI) onTarget:self withObject:nil animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self fetchCategoryData];
    
    if([APPDELEGATE_SHARED_MANAGER isConnected])
        [self addProgressIndicator];
    
    SHARED_DELEGATE.selectedServiceName = @"beauty-services-at-home";
}

//-(void)logAnalytics
//{
//    //[[SEGAnalytics sharedAnalytics] screen:@"Home slide view  page" properties: @{
//                                                                                  }];
//}

-(void)createCollectionViewForCategories
{
    [self.datepicker addTarget:self action:@selector(updateSelectedDate) forControlEvents:UIControlEventValueChanged];
    
    [self.datepicker fillCurrentYear];
    [self.datepicker selectDateAtIndex:0];
}

-(IBAction)triggerChat:(id)sender
{
//    [Helpshift installForApiKey:@"62a09e35f63581f3c78057c07c2fb331"
//                     domainName:@"johnpaulloco.helpshift.com"
//                          appID:@"johnpaulloco_platform_20150804065446006-8ff5e7119156086"];
//    
//    
//    [[Helpshift sharedInstance] showConversation:self
//                                     withOptions:nil];
//    
}


- (void)processImageDataWithBlock:(void (^)(NSData *imageData))processImage
{
//    NSString *url = self.imageURL;
//    dispatch_queue_t callerQueue = dispatch_get_current_queue();
//    dispatch_queue_t downloadQueue = dispatch_queue_create("Photo Downloader", NULL);
//    dispatch_async(downloadQueue, ^{
//        NSData *imageData = *insert code that fetches photo from server*;
//        dispatch_async(callerQueue, ^{
//            processImage(imageData);
//        });
//    });
}


-(void)initiateGetCategoryAPI
{
    
    if([APPDELEGATE_SHARED_MANAGER isConnected]){
        //Need to move after proper webservice call and validation
        //Set Indicator
        //[APPDELEGATE_SHARED_MANAGER showGlobalProgressHUDWithTitle:NSLocalizedString(@"LoadingLabel",@"Loading")];
        
        [RequestResposeHandler GetCategoryService:SHARED_DELEGATE.selectedCityID :^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
            
            if (success)
            {
                NSLog(@"sucess");
                //[APPDELEGATE_SHARED_MANAGER clearFeedData];
                [self fetchCategoryData];
                //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
                [self.tableView reloadData];
                
                //[self launchSlideViewController];
            }
            else{
                //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
                UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(error,@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [wsAlert show];
            }
            
        }];
    }
    else{
        //UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //[wsAlert show];
        
        [self fetchCategoryData];
    }
}


-(void)reloadUIImages
{
//    [self.bannerImg processImageDataWithBlock:^(NSData *imageData) {
//        if (self.view.window) {
//            UIImage *image = [UIImage imageWithData:imageData];
//            imageView.image = image;
//            imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//            scrollView.contentSize = image.size;
//            [spinner stopAnimating];
//        }
//    }];

}
- (void)updateSelectedDate
{
    
    dataArray = [[NSMutableArray alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"EEEEddMMMM" options:0 locale:nil];
    
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    
    
    //Enable it
    [self fetchServiceForSelectedCategory:self.datepicker.selectedCat];
    
}

-(void)fetchCategoryData
{
   self.categoryList = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"MajorCategory"];
    
    [SHARED_DELEGATE.majorCategoryList removeAllObjects];
    
    for (int i=0 ; i<[self.categoryList count]; i++) {
        MajorCategory *majorCat = [self.categoryList objectAtIndex:i];
        if(![SHARED_DELEGATE.majorCategoryList containsObject:majorCat.name])
            [SHARED_DELEGATE.majorCategoryList addObject:majorCat.name];
    }
    if([SHARED_DELEGATE.majorCategoryList count]>0)
        [self createCollectionViewForCategories];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self fetchServiceForSelectedCategory:indexPath];
    
    
    //self.bannerImg =[UIImage imageNamed:@"leftMenu.jpg"]];
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return YES;
}

#pragma mark - IBActions -

- (IBAction)bounceMenu:(id)sender
{
	static Menu menu = MenuLeft;
	
	[[SlideNavigationController sharedInstance] bounceMenu:menu withCompletion:nil];
	
	menu = (menu == MenuLeft) ? MenuRight : MenuLeft;
}

- (IBAction)slideOutAnimationSwitchChanged:(UISwitch *)sender
{
	((LeftMenuViewController *)[SlideNavigationController sharedInstance].leftMenu).slideOutAnimationEnabled = sender.isOn;
}

- (IBAction)limitPanGestureSwitchChanged:(UISwitch *)sender
{
	[SlideNavigationController sharedInstance].panGestureSideOffset = (sender.isOn) ? 50 : 0;
}

- (IBAction)changeAnimationSelected:(id)sender
{
	[[SlideNavigationController sharedInstance] openMenu:MenuRight withCompletion:nil];
}

- (IBAction)shadowSwitchSelected:(UISwitch *)sender
{
	[SlideNavigationController sharedInstance].enableShadow = sender.isOn;
}

- (IBAction)enablePanGestureSelected:(UISwitch *)sender
{
	[SlideNavigationController sharedInstance].enableSwipeGesture = sender.isOn;
}

- (IBAction)portraitSlideOffsetChanged:(UISegmentedControl *)sender
{
	[SlideNavigationController sharedInstance].portraitSlideOffset = [self pixelsFromIndex:sender.selectedSegmentIndex];
}

- (IBAction)landscapeSlideOffsetChanged:(UISegmentedControl *)sender
{
	[SlideNavigationController sharedInstance].landscapeSlideOffset = [self pixelsFromIndex:sender.selectedSegmentIndex];
}

#pragma mark - Helpers -

- (NSInteger)indexFromPixels:(NSInteger)pixels
{
	if (pixels == 60)
		return 0;
	else if (pixels == 120)
		return 1;
	else
		return 2;
}

- (NSInteger)pixelsFromIndex:(NSInteger)index
{
	switch (index)
	{
		case 0:
			return 60;
			
		case 1:
			return 120;
			
		case 2:
			return 200;
			
		default:
			return 0;
	}
}
-(void)fetchServiceForSelectedCategory:(NSIndexPath*)indexPath
{
    if([self.categoryList count]>0)
    {
        MajorCategory *cat = [self.categoryList objectAtIndex:indexPath.row];
        
        self.serviceList  = [cat.childCategory allObjects];
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.serviceList count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeViewTableViewCell"];
    
    HomeViewTableViewCell *cell = (HomeViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"HomeViewTableViewCell"];
    
    if([self.serviceList count]>0)
    {
        ChildCategory *service = [self.serviceList objectAtIndex:indexPath.row];
        
         cell.serviceHeader.font = [UIFont fontWithName:kLocalOyeFontMedium size:14.0];
         cell.serviceDesc.font = [UIFont fontWithName:kLocalOyeFontLight size:12.0];
        //NSLog(@"service name %@",service.name);
            cell.serviceHeader.text = service.name;
         //   cell.serviceHeader.text = @"Home service";
        cell.serviceDesc.text = @"service description..";
        //cell.serviceImage.image = [UIImage imageNamed:@"TableCellImg"];
        //cell.serviceImage.image = [UIImage imageNamed:@"ic-menu-hamburger"];
        
        cell.serviceImage.image = nil; // or cell.poster.image = [UIImage imageNamed:@"placeholder.png"];
        
        if([APPDELEGATE_SHARED_MANAGER isConnected]){
            dispatch_queue_t queue = dispatch_queue_create("com.localoye.MyQueue", NULL);
            
            dispatch_async(queue, ^{
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageBaseUrl,service.icon]]];
                if (imgData) {
                    UIImage *image = [UIImage imageWithData:imgData];
                    if (image) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            HomeViewTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                            if (updateCell)
                                updateCell.serviceImage.image = image;
                        });
                    }
                }
            });
        }
        
    }
    cell.backgroundColor = [UIColor clearColor];
    
    
    
//Refreshing the images on cells enable it once implementation done
    
//    cell.imageView.image = nil;
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
//    dispatch_async(queue, ^(void) {
//        
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:parsedData[@"imageLR"]];
//                             
//        UIImage* image = [[UIImage alloc] initWithData:imageData];
//        if (image) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                    if (cell.tag == indexPath.row) {
//                        cell.imageView.image = image;
//                        [cell setNeedsLayout];
//                    }
//            });
//        }
//    });
    
    
//    static NSString *cellIdentifier = @"HomeViewTableViewCell";
//    
//    HomeViewTableViewCell *cell = (HomeViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    [[cell contentView] setBackgroundColor:[UIColor clearColor]];
//    [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
//    [cell setBackgroundColor:[UIColor clearColor]];
//    
//    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChildCategory *service = [self.serviceList objectAtIndex:indexPath.row];
    SHARED_DELEGATE.selectedServiceName =service.slug;
    SHARED_DELEGATE.selectedServiceHeader = service.name;
    
    //For submitting the lead
    SHARED_DELEGATE.cusSelectedCategory = service.slug;
    
    //if([APPDELEGATE_SHARED_MANAGER isConnected])
        [self addProgressIndicatorQuestionApi];
    
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    ServiceDetailViewController *serviceView = (ServiceDetailViewController*)[mainStoryboard
                                                                 instantiateViewControllerWithIdentifier: @"ServiceDetailViewController"];
    
    serviceView.childCat = service;
    
    [[SlideNavigationController sharedInstance] pushViewController:serviceView animated:NO];
    
}



-(void)initiateGetQuestionsAPI
{
    //if([APPDELEGATE_SHARED_MANAGER isConnected]){
        //Need to move after proper webservice call and validation
        //Set Indicator
        //[APPDELEGATE_SHARED_MANAGER showGlobalProgressHUDWithTitle:NSLocalizedString(@"LoadingLabel",@"Loading")];
        
        [RequestResposeHandler GetRateCardQuestionsService:SHARED_DELEGATE.selectedServiceName :^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.

            if (success)
            {
                NSLog(@"sucess");
                
                //[self fetchCategoryData];
                //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
                //[self.tableView reloadData];
                
                //[self launchSlideViewController];
            }
            else{
                //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
                UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(error,@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [wsAlert show];
            }
            
        }];
//    }
//    else{
//        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [wsAlert show];
//

//    }
}







@end
