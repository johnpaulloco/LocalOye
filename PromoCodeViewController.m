//
//  PromoCodeViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 19/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "PromoCodeViewController.h"
#import "QuotesAwaitingViewController.h"
#import "LocalOyeConstants.h"
#import "RequestResposeHandler.h"

@interface PromoCodeViewController ()

@end

@implementation PromoCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bannerImg.image = SHARED_DELEGATE.receivedBannerImg;
    
    [self.submitBtn setBackgroundColor:[UIColor orangeColor]];
   
    [self.submitBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    
    self.promoCode        = @"" ;
    
}

-(IBAction)promoCodeValidationAction:(id)sender
{
    [self frameJsonForPromoCodeValidation];
    
}
-(IBAction)submitAction:(id)sender
{
    if(promoCode_.text.length>0)
    {
        if(couponVerified)
                [self frameJsonForPromoCodeValidation];
        
        else{
            [self frameJsonForSubmitlead];
        }
    }
    else{
        [self frameJsonForSubmitlead];
    }
    //[self triggerOrderSummary];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}


-(void)triggerOrderSummary
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    QuotesAwaitingViewController *orderView = (QuotesAwaitingViewController*)[mainStoryboard
                                                                              instantiateViewControllerWithIdentifier: @"QuotesAwaitingViewController"];
    
    
    [[SlideNavigationController sharedInstance] pushViewController:orderView animated:NO];
}

-(void)addProgressIndicator
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(initiateSubmitLeadAPI) onTarget:self withObject:nil animated:YES];
    
    
}


-(void)fetchSubmitResponseData
{
    
}

-(void)fetchPromoCodeResponseData
{
    
}

-(void)initiateSubmitLeadAPI
{
    //if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
    
    [RequestResposeHandler SubmitLeadService:parametersVal :^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
        
        if (success)
        {
            NSLog(@"sucess");
            //[APPDELEGATE_SHARED_MANAGER clearFeedData];
            [self fetchSubmitResponseData];
            //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
            //[self.tableView reloadData];
            
            //[self launchSlideViewController];
            [self triggerOrderSummary];
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

-(void)validateData{
    
}
-(void)initiateValidatePromoCodePI
{
    //if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
    [RequestResposeHandler ValidatePromoCodeService:promoCode_ :^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
        
        if (success)
        {
            couponVerified = YES;
            NSLog(@"sucess");
            //[APPDELEGATE_SHARED_MANAGER clearFeedData];
            //[self fetchSubmitResponseData];
            //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
            //[self.tableView reloadData];
            
            //[self launchSlideViewController];
        }
        else{
            couponVerified = NO;
            promoCode_.text = @"";
            //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Invalid promo code"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [wsAlert show];
        }
        
    }];
    //    }
    //    else{
    //        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [wsAlert show];
    //    }
}

-(void)frameJsonForPromoCodeValidation
{
    //    {"code":0,"data":[{
    //    "city": "bangalore",
    //    "category": "pest-control-services",
    //    "mobile_number": "9167369185",
    //    "promo_code": "ABCD1234",
    //    "sku": "1,2.3"
    //    }]}
    
    promoCodeData = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:SHARED_DELEGATE.cusSelectedCategory forKey:@"category"];
    [dict setObject:SHARED_DELEGATE.cusMobileNo forKey:@"mobile_number"];
    [dict setObject:SHARED_DELEGATE.cusSelectedCity forKey:@"city"];
    [dict setObject:self.promoCode forKey:@"promo_code"];
    [dict setObject:@"1,2,3" forKey:@"sku"];
    
    [promoCodeData addObject:dict];
    
    [self initiateValidatePromoCodePI];
}


-(void)frameJsonForSubmitlead
{
    SHARED_DELEGATE.userID = [NSString stringWithFormat:@"%@",@"14428523788092"];
    
    if(!SHARED_DELEGATE.cusLatitude.length>0){
        SHARED_DELEGATE.cusLatitude = @"12";
        SHARED_DELEGATE.cusLongitude = @"13";
    }
    //NSString *locationVal = @"ABCD|72.9169200|19.0919720";
    NSString *locationVal = [NSString stringWithFormat:@"%@|%@|%@",SHARED_DELEGATE.cusSelectedCity,SHARED_DELEGATE.cusLatitude,SHARED_DELEGATE.cusLongitude];
    
    if(!SHARED_DELEGATE.cusCoupon.length>0)
        SHARED_DELEGATE.cusCoupon = @"?";
    NSString *userDetVal = @"Test Lead|918888855555|test@localoye.com|?|bangalore";
   // NSString *userDetVal = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",SHARED_DELEGATE.cusName,SHARED_DELEGATE.cusMobileNo,SHARED_DELEGATE.cusEmailID,SHARED_DELEGATE.cusCoupon,SHARED_DELEGATE.cusSelectedCity];
    NSString *skuVal = @"1,3";
    
    SHARED_DELEGATE.deviceToken = @"038632601161EAA6B55377445FB54EFA3C7625DC229CF1FF72AA54910B697F16";
    
    NSLog(@"%@",locationVal);
    NSLog(@"%@",SHARED_DELEGATE.selectedServiceName);
    NSLog(@"%@",SHARED_DELEGATE.deviceID);
    NSLog(@"%@",SHARED_DELEGATE.deviceToken);
    NSLog(@"%@",SHARED_DELEGATE.userID);
    NSLog(@"%@",SHARED_DELEGATE.cusSelectedCity);
    
    
    parametersVal = @{@"What is your location": locationVal,
                      @"category":SHARED_DELEGATE.selectedServiceName,
                      @"app_id": SHARED_DELEGATE.deviceID,
                      @"reg_id": SHARED_DELEGATE.deviceToken,
                      @"user_id": SHARED_DELEGATE.userID,
                      @"city": SHARED_DELEGATE.cusSelectedCity,
                      //@"sku" : skuVal,
                      @"user_details" : userDetVal};
    
    NSLog(@"framed json %@",parametersVal);
    
    [self addProgressIndicator];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 6;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    // Make cell unselectable
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:kLocalOyeFontLight size:14.0];
    
    UITextField* tf = nil ;
    switch ( indexPath.row ) {
        case 0: {
            cell.textLabel.text = @"Phone Number" ;
            tf = promoCode_ = [self makeTextField:self.promoCode placeholder:@"Promo Code"];
            [cell addSubview:promoCode_];
            break ;
        }
        
    }
    
    // Textfield dimensions
    tf.frame = CGRectMake(140, 8, 170, 25);
    
    // Workaround to dismiss keyboard when Done/Return is tapped
    [tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    // We want to handle textFieldDidEndEditing
    tf.delegate = self ;
    
    return cell;
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


-(UITextField*) makeTextField: (NSString*)text
                  placeholder: (NSString*)placeholder  {
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = placeholder ;
    
    
    tf.text = text ;
    tf.autocorrectionType = UITextAutocorrectionTypeNo ;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.adjustsFontSizeToFitWidth = YES;
    tf.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    return tf ;
}

// Workaround to hide keyboard when Done is tapped
- (IBAction)textFieldFinished:(id)sender {
    // [sender resignFirstResponder];
}

// Textfield value changed, store the new value.
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ( textField == promoCode_ ) {
        self.promoCode = textField.text ;
        SHARED_DELEGATE.cusCoupon = self.promoCode;
    }
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
