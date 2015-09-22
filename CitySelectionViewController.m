//
//  CitySelectionViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 19/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "CitySelectionViewController.h"
#import "SlideNavigationController.h"
#import "CitiesViewTableViewCell.h"
#import "LocalOyeConstants.h"
#import "RequestResposeHandler.h"
#import "AFJSONRPCClient.h"
#import "Cities.h"
#import "AFNetworkReachabilityManager.h"
#import "LocalOyeConstants.h"


@interface CitySelectionViewController ()

@end

@implementation CitySelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];

    
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    [self.nextBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    
    self.nextBtn.enabled = NO;
    [self.nextBtn setBackgroundColor:[UIColor orangeColor]];
    self.nextBtn.titleLabel.textColor = [UIColor grayColor];
    
    cityList = [[NSArray alloc] init];
    
    [self fetchCityData];
    
    if([APPDELEGATE_SHARED_MANAGER isConnected])
        [self addProgressIndicator];
}

-(void)goBack
{
    
}
-(void)addProgressIndicator
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(initiateGetCitiesAPI) onTarget:self withObject:nil animated:YES];
}

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    [self initiateGetCitiesAPI];
    sleep(3);
}


-(void)initiateGetCitiesAPI
{
    if([APPDELEGATE_SHARED_MANAGER isConnected]){
        //Need to move after proper webservice call and validation
        //Set Indicator
        //[APPDELEGATE_SHARED_MANAGER showGlobalProgressHUDWithTitle:NSLocalizedString(@"LoadingLabel",@"Loading")];
        
        [RequestResposeHandler GetCitiesService:^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
            
            if (success)
            {
                NSLog(@"sucess");
                //[APPDELEGATE_SHARED_MANAGER clearFeedData];
                [self fetchCityData];
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
        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [wsAlert show];
    }
}


-(void)fetchCityData
{
    cityList = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"Cities"];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([cityList count]>0)
        self.nextBtn.enabled = YES;
    
    return [cityList count];
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
    
    CitiesViewTableViewCell *cell = (CitiesViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CitiesViewTableViewCell"];
    
    
    Cities *citiObj = [cityList objectAtIndex:indexPath.row];
    cell.cityName.text = citiObj.citiName;
    cell.cityName.textColor = [UIColor blackColor];
    cell.cityName.font = [UIFont fontWithName:kLocalOyeFontLight size:14.0];
    
    //if(indexPath.row == 0 && (cell.accessoryType == UITableViewCellAccessoryNone))
    //    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    //cell.textLabel.textAlignment = UITextAlignmentCenter;
    //cell.backgroundColor = [UIColor clearColor];
    
    //cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"ic-select-blank"]];
    //[cell.accessoryView setFrame:CGRectMake(0, 0, 24, 24)];
    
    [cell setTintColor:[UIColor orangeColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //lastIndexPath = indexPath;
    
    Cities *citiObj = [cityList objectAtIndex:indexPath.row];
    SHARED_DELEGATE.selectedCityID = citiObj.citiID;
    
    SHARED_DELEGATE.cusSelectedCity = citiObj.citiID;
    
    //[self.tableView reloadData];
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    //[self refershModelData]; //Need to enable it
}

-(void)refershModelData
{
    [APPDELEGATE_SHARED_MANAGER clearModelData:@"MajorCategory"];
    [APPDELEGATE_SHARED_MANAGER clearModelData:@"MerchantProfile"];
    [APPDELEGATE_SHARED_MANAGER clearModelData:@"MyOrder"];
    [APPDELEGATE_SHARED_MANAGER clearModelData:@"QuestionRateCard"];
    [APPDELEGATE_SHARED_MANAGER clearModelData:@"Questions"];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

-(IBAction)nextBtnAction:(id)sender
{
    if(SHARED_DELEGATE.cusSelectedCity.length>0){
        
    
    NSLog(@"next");
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    UIViewController *vc ;
    
    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:YES
                                                                     andCompletion:nil];
    
    }
    else{
        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Select a city to proceed"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [wsAlert show];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
