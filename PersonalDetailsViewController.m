//
//  PersonalDetailsViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 24/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "PersonalDetailsViewController.h"
#import "OrderSummaryViewController.h"
#import "LocalOyeConstants.h"
#import "RequestResposeHandler.h"
#import "QuotesAwaitingViewController.h"

@interface PersonalDetailsViewController ()

@end

@implementation PersonalDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.submitBtn setBackgroundColor:[UIColor orangeColor]];
    
     [self.submitBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    
    self.name        = @"" ;
    self.address     = @"" ;
    self.password    = @"" ;
    self.descriptionStr = @"" ;
    
    self.headerLbl.font = [UIFont fontWithName:kLocalOyeFontMedium size:18.0];
    self.headerDesc.font = [UIFont fontWithName:kLocalOyeFontMedium size:14.0];
    
}

-(IBAction)promoCodeValidationAction:(id)sender
{
    [self frameJsonForPromoCodeValidation];
    
}
-(IBAction)submitAction:(id)sender
{
    if(phoneField_.text.length>0 && nameField_.text.length>0 && addressField_.text.length>0 && emailField_.text.length>0)
    {
        if(couponField_.text.length>0){
            if(couponVerified)
                [self frameJsonForSubmitlead];
        }
        else{
            [self frameJsonForSubmitlead];
        }
    }
    
    [self triggerOrderSummary];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.bannerImg.image = SHARED_DELEGATE.receivedBannerImg;
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

    [RequestResposeHandler ValidatePromoCodeService:promoCodeData :^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
        
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
            couponField_.text = @"";
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
    [dict setObject:self.coupon forKey:@"promo_code"];
    [dict setObject:@"1,2,3" forKey:@"sku"];
    
    [promoCodeData addObject:dict];
    
    [self initiateValidatePromoCodePI];
}


-(void)frameJsonForSubmitlead
{
    if(!SHARED_DELEGATE.cusLatitude.length>0){
        SHARED_DELEGATE.cusLatitude = @"";
        SHARED_DELEGATE.cusLongitude = @"";
    }
    //NSString *locationVal = @"ABCD|72.9169200|19.0919720";
    NSString *locationVal = [NSString stringWithFormat:@"%@|%@|%@",SHARED_DELEGATE.cusSelectedCity,SHARED_DELEGATE.cusLatitude,SHARED_DELEGATE.cusLongitude];
    
    
    if(!SHARED_DELEGATE.cusCoupon.length>0)
        SHARED_DELEGATE.cusCoupon = @"?";
    //NSString *userDetVal = @"Test Lead|918888855555|test@localoye.com|?|bangalore";
        NSString *userDetVal = [NSString stringWithFormat:@"%@|%@|%@|%@|%@",SHARED_DELEGATE.cusName,SHARED_DELEGATE.cusMobileNo,SHARED_DELEGATE.cusEmailID,SHARED_DELEGATE.cusCoupon,SHARED_DELEGATE.cusSelectedCity];
    NSString *skuVal = @"1,3";
    
    //NSArray *addedSkuObj = [APPDELEGATE_SHARED_MANAGER retrieveAddedSkus:SHARED_DELEGATE.selectedServiceName];

//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array addObject:[NSNumber numberWithInt:1]];
//        [array addObject:[NSNumber numberWithInt:2]];
//    for(QuestionRateCard *data in array)
//    {
//        [array addObject:data.sku_id];
//    }
//    NSString * combinedStuff = [array componentsJoinedByString:@"separator"];
    
    //SHARED_DELEGATE.deviceToken = @"038632601161EAA6B55377445FB54EFA3C7625DC229CF1FF72AA54910B697F16";
    
    
    NSLog(@"locationVal %@",locationVal);
    NSLog(@"SHARED_DELEGATE.selectedServiceName %@",SHARED_DELEGATE.selectedServiceName);
    NSLog(@"SHARED_DELEGATE.deviceID %@",SHARED_DELEGATE.deviceID);
    NSLog(@"SHARED_DELEGATE.deviceToken %@",SHARED_DELEGATE.deviceToken);
    NSLog(@"SHARED_DELEGATE.cusSelectedCity %@",SHARED_DELEGATE.cusSelectedCity);
    NSLog(@"skuVal %@",skuVal);
    NSLog(@"userDetVal %@",userDetVal);
    //SHARED_DELEGATE.deviceToken = @"038632601161EAA6B55377445FB54EFA3C7625DC229CF1FF72AA54910B697F16";
    
    parametersVal = @{@"What is your location": locationVal,
                                  @"category":SHARED_DELEGATE.selectedServiceName,
                                  @"app_id": SHARED_DELEGATE.deviceID,
                                  @"reg_id": SHARED_DELEGATE.deviceToken,
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
            tf = phoneField_ = [self makeTextField:self.phoneNo placeholder:@"Phone number"];
            [cell addSubview:phoneField_];
            break ;
        }
        case 1: {
            cell.textLabel.text = @"Name" ;
            tf = nameField_ = [self makeTextField:self.name placeholder:@"John Appleseed"];
            [cell addSubview:nameField_];
            break ;
        }
        case 2: {
            cell.textLabel.text = @"Address" ;
            tf = addressField_ = [self makeTextField:self.address placeholder:@"Address"];
            [cell addSubview:addressField_];
            break ;
        }
        case 3: {
            cell.textLabel.text = @"Coupon" ;
            tf = couponField_ = [self makeTextField:self.coupon placeholder:@"Coupon code"];
            [cell addSubview:couponField_];
            break ;
        }
        case 4: {
            cell.textLabel.text = @"Email" ;
            tf = emailField_ = [self makeTextField:self.email placeholder:@"example@gmail.com"];
            [cell addSubview:emailField_];
            break ;
        }
//        case 5: {
//            cell.textLabel.text = @"Description" ;
//            tf = descriptionField_ = [self makeTextField:self.description placeholder:@"My Gmail Account"];
//            [cell addSubview:descriptionField_];
//            break ;
//        }
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
    if ( textField == nameField_ ) {
        self.name = textField.text ;
        SHARED_DELEGATE.cusName = self.name;
    } else if ( textField == addressField_ ) {
        self.address = textField.text ;
        SHARED_DELEGATE.cusAddress = self.address;
    } else if ( textField == phoneField_ ) {
        self.phoneNo = textField.text ;
        SHARED_DELEGATE.cusMobileNo = self.phoneNo;
    } else if ( textField == emailField_ ) {
        self.email = textField.text ;
        SHARED_DELEGATE.cusEmailID = self.email;
    }
    else if ( textField == couponField_ ) {
        self.coupon = textField.text ;
        SHARED_DELEGATE.cusCoupon = self.coupon;
        //[self frameJsonForPromoCodeValidation];
    }
}


@end
