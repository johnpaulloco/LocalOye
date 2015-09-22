//
//  MerchantOnlineQuoteViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 04/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "MerchantOnlineQuoteViewController.h"
#import "RequestResposeHandler.h"
#import "MerchantProfile.h"
#import "PdfViewController.h"

@interface MerchantOnlineQuoteViewController ()

@end

@implementation MerchantOnlineQuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor colorWithRed:236.0f/255.0f  green:236.0f/255.0f blue:236.0f/255.0f alpha:1];
    
    self.star1.hidden= YES;
    self.star2.hidden= YES;
    self.star3.hidden= YES;
    self.star4.hidden= YES;
    self.star5.hidden= YES;
    
     [self.downloadPdfbtn setBackgroundColor:[UIColor orangeColor]];
     [self.downloadPdfbtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    
    [self fetchOnlineMerchantData];
    [self refreshUI];
    
    [self addProgressIndicator];
    
}

-(IBAction)downLoadPDf:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
        PdfViewController *pdfView = (PdfViewController*)[mainStoryboard
                                                                                  instantiateViewControllerWithIdentifier: @"PdfViewController"];
    
    pdfView.urlStr = self.merProf.downLoadLink;
    [[SlideNavigationController sharedInstance] pushViewController:pdfView animated:YES];
    

    
   
}
-(void)refreshUI
{
    if([onlineQuoteList count]>0){
        self.merProf = [onlineQuoteList objectAtIndex:0];
        if([self.merProf.rating isEqualToString:@"1"]){
            self.star1.hidden= NO;
        }
        else if([self.merProf.rating isEqualToString:@"2"])
        {
            self.star1.hidden= NO;
            self.star2.hidden= NO;
        }
        else if([self.merProf.rating isEqualToString:@"3"]){
            self.star1.hidden= NO;
            self.star2.hidden= NO;
            self.star3.hidden= NO;
        }
        else if([self.merProf.rating isEqualToString:@"4"])
        {
            self.star1.hidden= NO;
            self.star2.hidden= NO;
            self.star3.hidden= NO;
            self.star4.hidden= NO;
            
        }
        else if([self.merProf.rating isEqualToString:@"5"])
        {
            self.star1.hidden= NO;
            self.star2.hidden= NO;
            self.star3.hidden= NO;
            self.star4.hidden= NO;
            self.star5.hidden= NO;
        }
        
        //self.quote_text.text = merProf.quote_text;
        //self.certifications.text = merProf.certifications;
        self.descriptionStr.text = self.merProf.descriptionStr;
        //self.profile_pic.image = merProf.quote_text;
        self.merchant_name.text = self.merProf.merchant_name;
        self.quotesTitle.text = self.quoteListObject.category;
        self.quotesDate.text = self.myOderObject.created_at;
        self.descriptionStr.text= self.merProf.descriptionStr;
        self.certifications.text = self.merProf.descriptionStr;
        self.quote_text.text = self.merProf.descriptionStr;
        
        downLoadLink = self.merProf.downLoadLink;
        NSLog(@"downLoadLink %@",downLoadLink);
        
    }
}

-(void)addProgressIndicator
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(initiateOnlineMerchantQuoteAPI) onTarget:self withObject:nil animated:YES];
    
}

-(void)initiateOnlineMerchantQuoteAPI
{
    if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
        NSNumber *leadID;
        NSNumber *merchantID;
        NSString *urlStr;
        if([self.myOderObject.category isEqualToString:@"Online"])
        {
            leadID  = self.myOderObject.booking_id;
            merchantID= self.quoteListObject.merchant_id;
            urlStr = getOnlineMerchantQuoteServiceURL;
        }
        else{
            leadID  = self.quoteListObject.lead_id;
            merchantID= self.quoteListObject.merchant_id;
            urlStr = getMerchantProfileURL;
        }
    
        [RequestResposeHandler GetOnlineMerchantQuotesListingService:self.myOderObject.booking_id:merchantID :self.myOderObject.category_type:^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
        
        if (success)
        {
            NSLog(@"sucess");
            //[APPDELEGATE_SHARED_MANAGER clearFeedData];
            [self fetchOnlineMerchantData];
            
            [self refreshUI];
            
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
        }
        else{
            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [wsAlert show];
        }
}

-(void)fetchOnlineMerchantData
{
   onlineQuoteList  = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"MerchantProfile"];
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
