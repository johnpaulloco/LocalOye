//
//  QuotesViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 31/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "QuotesViewController.h"
#import "PanicBtnTableViewCell.h"
#import "QuotesTableViewCell.h"
#import "RequestResposeHandler.h"
#import "MBProgressHUD.h"
#import "LocalOyeConstants.h"
#import "QuotesList.h"
#import "MerchantProfileViewController.h"
#import "MerchantOnlineQuoteViewController.h"
#import "RateMerchantViewController.h"


@interface QuotesViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation QuotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    panicBtns = [[NSMutableArray alloc] init];
    if([self.myOrderObj.status_text isEqualToString:@"Booking confirmed"] && [self.myOrderObj.category_type isEqualToString:@"Repair"])
    {
        [panicBtns addObject:@"My service did not happen"];
        [panicBtns addObject:@"I want to cancel my service"];
        [panicBtns addObject:@"I would like to reschedule"];
        [panicBtns addObject:@"I want to request a call back"];
        [panicBtns addObject:@"I want to rate my experience"];
        [panicBtns addObject:@"I am facing other issues"];
    }
    else if([self.myOrderObj.status_text isEqualToString:@"Booking confirmed"] && [self.myOrderObj.category_type isEqualToString:@"Online"])
    {
        [panicBtns addObject:@"I am not happy with the report"];
        [panicBtns addObject:@"I want to rate my experience"];
        [panicBtns addObject:@"I am facing other issues"];
    }
    else if([self.myOrderObj.status_text isEqualToString:@"Booking confirmed"] && [self.myOrderObj.category_type isEqualToString:@"research"])
    {
        [panicBtns addObject:@"I did not like the quote"];
        [panicBtns addObject:@"I did not get any introductory calls"];
        [panicBtns addObject:@"I want to rate my experience"];
        [panicBtns addObject:@"I want to cancel my service"];
        [panicBtns addObject:@"I am facing other issues"];
    }
    

    self.view.backgroundColor =[UIColor colorWithRed:236.0f/255.0f  green:236.0f/255.0f blue:236.0f/255.0f alpha:1];
    
    [self fetchQuotesData];
    
    
    
    
    self.quotesTableView.layer.cornerRadius = 5;
    self.quotesTableView.layer.masksToBounds = YES;
    [self.quotesTableView.layer setBorderWidth:2.0f];
    self.quotesTableView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.panicbtnsTableView.layer.cornerRadius = 5;
    self.panicbtnsTableView.layer.masksToBounds = YES;
    [self.panicbtnsTableView.layer setBorderWidth:2.0f];
    self.panicbtnsTableView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.helpBGView.layer.cornerRadius = 5;
    self.helpBGView.layer.masksToBounds = YES;
    [self.helpBGView.layer setBorderWidth:2.0f];
    self.helpBGView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    
    NSLog(@"lead id %@",self.leadID);
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self)
//    {
//        [self setupViewController];
//    }
//    return self;
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([quotesList count]>0){
        QuotesList *quoteListObj = [quotesList objectAtIndex:0];
        self.titleLbl.text = quoteListObj.category;
    }
    
    NSLog(@"lead id %@",self.leadID);
    //[self addProgressIndicator];
    [self initiateQuotesAPI];
}
-(void)addProgressIndicator
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(initiateQuotesAPI) onTarget:self withObject:nil animated:YES];
    
    
}

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    [self initiateQuotesAPI];
    sleep(3);
}


-(void)initiateQuotesAPI
{
    if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
    [RequestResposeHandler GetQuotesListingService:self.leadID :^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
        
        if (success)
        {
            NSLog(@"sucess");
            //[APPDELEGATE_SHARED_MANAGER clearFeedData];
            [self fetchQuotesData];
            //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
            [self.quotesTableView reloadData];
            
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
-(void)fetchQuotesData
{
    quotesList = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"QuotesList"];
    //self.data = [quotesList mutableCopy];
}


-(void)addProgressIndicatorPanicAlert
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(initiatePanicAlertAPI) onTarget:self withObject:nil animated:YES];
    
    
}

-(void)initiatePanicAlertAPI
{
    //if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
    //SHARED_DELEGATE.recivedLeadID= [NSNumber numberWithInt:1];
    [RequestResposeHandler SubmitPanicAlert:self.myOrderObj.booking_id :causeEnum : rescheduleEnum : rating:^(BOOL success, NSString *error){ //need to use
        if (success)
        {
            NSLog(@"sucess");
            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Alert Raised"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [wsAlert show];
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



//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self)
//    {
//        [self fetchQuotesData];
//        [self setupViewController];
//    }
//    return self;
//}

//- (void)setupViewController
//{
//    NSArray* colors = @[[UIColor lightGrayColor],
//                        //[UIColor orangeColor],
//                        //[UIColor yellowColor],
//                        //[UIColor greenColor],
//                        //[UIColor blueColor],
//                        //[UIColor purpleColor]
//                        ];
//    
//    self.data = [[NSMutableArray alloc] init];
//    for (int i = 0 ; i < [colors count] ; i++)
//    {
//        NSMutableArray* section = [[NSMutableArray alloc] init];
//        for (int j = 0 ; j < [quotesList count] ; j++)
//        {
//            //[section addObject:[NSString stringWithFormat:@"Cell n°%i", j]];
//            [section addObject:[quotesList objectAtIndex:j]];
//        }
//        [self.data addObject:section];
//    }
//    
//    self.headers = [[NSMutableArray alloc] init];
//    for (int i = 0 ; i < [colors count] ; i++)
//    {
//        UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
//        [header setBackgroundColor:[colors objectAtIndex:i]];
//        [self.headers addObject:header];
//    }
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.quotesTableView == tableView)
        return [quotesList count];
    else
        return [panicBtns count];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
//    view.backgroundColor = [UIColor clearColor];
//    return view;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.quotesTableView == tableView){
//        static NSString* cellIdentifier = @"QuotesTableViewCell";
//        
//        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        
//        if (!cell)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
//        }
        
        QuotesTableViewCell *cell = (QuotesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QuotesTableViewCell"];
        
        
        
        QuotesList *quoteListObj = [quotesList objectAtIndex:indexPath.row];
        
        if(quoteListObj.merchant_name.length>0)
        {
        //cell.merchantImg.image = [UIImage imageNamed:@""];
        cell.merchantName.text = quoteListObj.merchant_name;
        NSString *unitStr = @"";
        cell.quotePrice.text = [NSString stringWithFormat:@"Rs %@ %@",quoteListObj.quote_price,unitStr];
        
        //NSString* text = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        //cell.textLabel.text = text;
        
        cell.merchantImg.image = [UIImage imageNamed:@"defaultTableCellIcon.png"]; // or cell.poster.image = [UIImage imageNamed:@"placeholder.png"];
        
        dispatch_queue_t queue = dispatch_queue_create("com.localoye.MyQueueMerchantImage", NULL);
        
        dispatch_async(queue, ^{
            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageBaseUrl,quoteListObj.merchant_image]]];
            if (imgData) {
                UIImage *image = [UIImage imageWithData:imgData];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        QuotesTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                        if (updateCell)
                            updateCell.merchantImg.image = image;
                    });
                }
            }
        });
   
        }
        
        
        return cell;
    }
    else{
        PanicBtnTableViewCell *cell = (PanicBtnTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PanicBtnTableViewCell"];
        
        NSString *btn = [panicBtns objectAtIndex:indexPath.row];
        
        cell.textLabel.textColor = [UIColor darkGrayColor];
        
        cell.textLabel.text = btn;
        
        return cell;
        
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.quotesTableView == tableView)
        return 40;
    else
        return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(self.quotesTableView == tableView)
    {
        //return [self.headers objectAtIndex:section];
        UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(15, 3, 50, 60)];
        header.font = [UIFont systemFontOfSize:14];
        header.numberOfLines = 2;
        
        header.textColor = [UIColor grayColor];
        header.text = @"  Choose from these verified vendors \n  that match your requirements perfectly";
        
        return header;
    }
    else{
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        return header;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.quotesTableView == tableView){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
//        MerchantProfileViewController *merchantView = (MerchantProfileViewController*)[mainStoryboard
//                                                                                  instantiateViewControllerWithIdentifier: @"MerchantProfileViewController"];
//
    
            MerchantOnlineQuoteViewController *merchantView = (MerchantOnlineQuoteViewController*)[mainStoryboard
                                                                                      instantiateViewControllerWithIdentifier: @"MerchantOnlineQuoteViewController"];
    

        QuotesList *quoteListObj = [quotesList objectAtIndex:indexPath.row];
        merchantView.quoteListObject = quoteListObj;
        merchantView.myOderObject = self.myOrderObj;
        [[SlideNavigationController sharedInstance] pushViewController:merchantView animated:NO];
    }
    else{
        
        causeStr = [panicBtns objectAtIndex:indexPath.row];
        
        
        if ([causeStr isEqualToString:@"I want to cancel my service"]){
            causeEnum = @"user_cancel";
            rescheduleEnum = @"";
            rating = nil;
            [self addProgressIndicatorPanicAlert];
        }
        else if ([causeStr isEqualToString:@"I would like to reschedule"]){
            causeEnum = @"user_rescheduled";
            rescheduleEnum = @"19/09/2015 14:20";
            rating = nil;
            [self addProgressIndicatorPanicAlert];
        }
        else if ([causeStr isEqualToString:@"My service did not happen"]){
            causeEnum = @"partner_not_arrived";
            rescheduleEnum = @"";
            rating = nil;
            [self addProgressIndicatorPanicAlert];
        }
        else if ([causeStr isEqualToString:@"I want to request a call back"]){
            causeEnum = @"partner_contact_failed";
            rescheduleEnum = @"";
            rating = nil;
            [self addProgressIndicatorPanicAlert];
        }else if ([causeStr isEqualToString:@"I am facing other issues"]){
            //causeEnum = @"did_not_like_quotes";
        }
        else if ([causeStr isEqualToString:@"I did not get my report"]){
            causeEnum = @"partner_not_arrived";
            rescheduleEnum = @"";
            rating = nil;
            [self addProgressIndicatorPanicAlert];
        }
        else if ([causeStr isEqualToString:@"I want to rate my experience"]){
            causeEnum = @"user_rating";
            rating = [NSNumber numberWithInt:2];
            http://ios.slocaloye.com/customerapp/panic_alert?lead_id=14402493436740&escalation_cause=user_rating&rating=5
            //[self addProgressIndicatorPanicAlert];
            
            [self triggerRateMerchant];
        }
        else if ([causeStr isEqualToString:@"I am not happy with the report"]){
            causeEnum = @"partner_not_arrived";
            rescheduleEnum = @"";
            rating = nil;
            [self addProgressIndicatorPanicAlert];
        }
        else if ([causeStr isEqualToString:@"I did not like the quote"]){
            causeEnum = @"did_not_like_quotes";
            rescheduleEnum = @"";
            rating = nil;
            [self addProgressIndicatorPanicAlert];
        }
        else if ([causeStr isEqualToString:@"I did not get any introductory calls"]){
            causeEnum = @"partner_contact_failed";//Need to check
            rescheduleEnum = @"";
            rating = nil;
            [self addProgressIndicatorPanicAlert];
        }
    }
    
}

-(void)triggerRateMerchant
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    RateMerchantViewController *merchantView = (RateMerchantViewController*)[mainStoryboard
                                                                                           instantiateViewControllerWithIdentifier: @"RateMerchantViewController"];
    
    merchantView.causeEnum = causeEnum;
    merchantView.rescheduleEnum = rescheduleEnum;
    merchantView.myOrderObj = self.myOrderObj;
    
    
    [[SlideNavigationController sharedInstance] pushViewController:merchantView animated:NO];
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
