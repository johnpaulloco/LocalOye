//
//  MerchantProfileViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 02/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "MerchantProfileViewController.h"
#import "RequestResposeHandler.h"
#import "LocalOyeConstants.h"

@interface MerchantProfileViewController ()

@end

@implementation MerchantProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     
    
    [self addProgressMerchantProfIndicator];
}

-(void)addProgressMerchantProfIndicator
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(initiateMerchantProfileAPI) onTarget:self withObject:nil animated:YES];
}

-(void)initiateMerchantProfileAPI
{
    //if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
    [RequestResposeHandler GetMerchantProfileService: @"": @"" :^(BOOL success, NSString *error)
     { //need to use error appropriatly according to service for alerts.
         
         if (success)
         {
             NSLog(@"sucess");
             //[APPDELEGATE_SHARED_MANAGER clearFeedData];
             [self fetchMerchantData];
             //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
             [self.merchantTableView reloadData];
             
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
    //    }
}

-(void)fetchMerchantData
{
    merchantList = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"MerchantProfile"];
    //self.data = [quotesList mutableCopy];
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
