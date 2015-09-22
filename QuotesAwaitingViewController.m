//
//  QuotesAwaitingViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 31/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "QuotesAwaitingViewController.h"
#import "PanicBtnTableViewCell.h"
#import "RequestResposeHandler.h"
#import "LocalOyeConstants.h"
#import "MyOrderListViewController.h"
#import "HomeViewController.h"

@interface QuotesAwaitingViewController ()

@end

@implementation QuotesAwaitingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.headerLbl.font = [UIFont fontWithName:kLocalOyeFontMedium size:18.0];
    
    self.awaitingHeaderLbl.font = [UIFont fontWithName:kLocalOyeFontLight size:16.0];
    self.awaitingDescHeaderLbl.font = [UIFont fontWithName:kLocalOyeFontLight size:12.0];
    
    self.needHelpHeaderLbl.font = [UIFont fontWithName:kLocalOyeFontLight size:16.0];
    self.needHelpDescHeaderLbl.font = [UIFont fontWithName:kLocalOyeFontLight size:12.0];
    
   [self.veiwOrderBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontLight size:14.0]];
    [self.browseOtherServBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontLight size:14.0]];

    
    panicBtns = [[NSMutableArray alloc] init];
    
//    if([self.myOrderObj.category_type isEqualToString:@"Repair"])
//    {
//        
//    }
//    else
    if([self.myOrderObj.category_type isEqualToString:@"Repair"])
    {
        [panicBtns addObject:@"I want to cancel my service"];
        [panicBtns addObject:@"I would like to reschedule"];
        [panicBtns addObject:@"My service did not happen"];
        [panicBtns addObject:@"I want to request a call back"];
        [panicBtns addObject:@"I am facing other issues"];
    }
    else if([self.myOrderObj.category_type isEqualToString:@"Online"])
    {
        [panicBtns addObject:@"I want to cancel my service"];
        [panicBtns addObject:@"I did not get my report"];
        [panicBtns addObject:@"I am facing other issues"];
    }
    else if([self.myOrderObj.category_type isEqualToString:@"research"])//Need to check the category type
    {
        [panicBtns addObject:@"I want to cancel my service"];
        [panicBtns addObject:@"I did not get my replies"];
        [panicBtns addObject:@"I am facing other issues"];
    }
    
    self.view.backgroundColor =[UIColor colorWithRed:236.0f/255.0f  green:236.0f/255.0f blue:236.0f/255.0f alpha:1];
    
    self.orderSubView.layer.cornerRadius = 5;
    self.orderSubView.layer.masksToBounds = YES;
    [self.orderSubView.layer setBorderWidth:2.0f];
    self.orderSubView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    
    self.tableSubView.layer.cornerRadius = 5;
    self.tableSubView.layer.masksToBounds = YES;
    [self.tableSubView.layer setBorderWidth:2.0f];
    self.tableSubView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.headerLbl.text = SHARED_DELEGATE.selectedServiceHeader;

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //self.bannerImg.image = SHARED_DELEGATE.receivedBannerImg;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [panicBtns count];
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
    
    PanicBtnTableViewCell *cell = (PanicBtnTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PanicBtnTableViewCell"];
    
        NSString *btn = [panicBtns objectAtIndex:indexPath.row];
        
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont fontWithName:kLocalOyeFontLight size:14.0];
    
    cell.textLabel.text = btn;
    
    //cell.backgroundColor = [UIColor clearColor];
    
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    causeStr = [panicBtns objectAtIndex:indexPath.row];
    
    
    if ([causeStr isEqualToString:@"I want to cancel my service"]){
        causeEnum = @"user_cancel";
        rescheduleEnum = @"";
        [self addProgressIndicator];
    }
    else if ([causeStr isEqualToString:@"I would like to reschedule"]){
        causeEnum = @"user_rescheduled";
        rescheduleEnum = @"19/09/2015 14:20";
        [self addProgressIndicator];
    }
    else if ([causeStr isEqualToString:@"My service did not happen"]){
        causeEnum = @"partner_not_arrived";
        rescheduleEnum = @"";
        [self addProgressIndicator];
    }
    else if ([causeStr isEqualToString:@"I want to request a call back"]){
        causeEnum = @"partner_contact_failed";
        rescheduleEnum = @"";
        [self addProgressIndicator];
    }else if ([causeStr isEqualToString:@"I am facing other issues"]){
        //causeEnum = @"did_not_like_quotes";
    }
    else if ([causeStr isEqualToString:@"I did not get my report"]){
        causeEnum = @"partner_not_arrived";
        rescheduleEnum = @"";
        [self addProgressIndicator];
    }
    else if ([causeStr isEqualToString:@"I did not get my replies"]){
        causeEnum = @"partner_not_arrived";
        rescheduleEnum = @"";
        [self addProgressIndicator];
    }
    
    
            
        
    
//    ChildCategory *service = [self.serviceList objectAtIndex:indexPath.row];
//    SHARED_DELEGATE.selectedServiceName =service.slug;
//    
//    
//    [self initiateGetQuestionsAPI];
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    
//    ServiceDetailViewController *serviceView = (ServiceDetailViewController*)[mainStoryboard
//                                                                              instantiateViewControllerWithIdentifier: @"ServiceDetailViewController"];
//    
//    [[SlideNavigationController sharedInstance] pushViewController:serviceView animated:NO];
//    
}

-(void)addProgressIndicator
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(initiatePanicAlertAPI) onTarget:self withObject:nil animated:YES];
    
    
}

-(IBAction)viewOrders:(id)sender
{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    MyOrderListViewController *vc ;
    
    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"MyOrderListViewController"];
    
    
    vc.viewFromOrderSummary = YES;
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
            															 withSlideOutAnimation:YES
            																	 andCompletion:nil];
            
            
    //[[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
}
-(IBAction)viewOtherServices:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    HomeViewController *vc ;
    
    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
    
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:YES
                                                                     andCompletion:nil];
    
    
}

-(void)initiatePanicAlertAPI
{
    //if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
    //SHARED_DELEGATE.recivedLeadID= [NSNumber numberWithInt:1];
    [RequestResposeHandler SubmitPanicAlert:self.myOrderObj.booking_id :causeEnum : rescheduleEnum:nil:^(BOOL success, NSString *error){ //need to use
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
