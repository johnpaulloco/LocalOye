//
//  SignUpViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 18/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "SignUpViewController.h"
#import "OrderSummaryViewController.h"
#import "LocalOyeConstants.h"
#import "RequestResposeHandler.h"
#import "QuotesAwaitingViewController.h"
#import "SignUpOTPViewController.h"
#import "LoginDetailViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.submitBtn setBackgroundColor:[UIColor orangeColor]];
    [self.loginBtn setBackgroundColor:[UIColor orangeColor]];
    
    [self.submitBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    [self.loginBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    
    self.submitBtn.layer.cornerRadius = 4.0;
    self.loginBtn.layer.cornerRadius = 4.0;
    
    if(self.isFromSignUpLandingView)
        self.loginBtn.hidden = YES;
    else
        self.loginBtn.hidden = NO;
    
    self.lastName        = @"" ;
    self.firstname        = @"" ;
    self.phoneNo     = @"" ;
    self.password    = @"" ;
    self.email = @"" ;
    
    self.headerLbl.font = [UIFont fontWithName:kLocalOyeFontMedium size:18.0];
    self.headerDesc.font = [UIFont fontWithName:kLocalOyeFontMedium size:14.0];
    
    //self.password = @"Test@123";
}

//- (void)goBack
//{
//    NSLog(@"pop");
//    [self.navigationController popViewControllerAnimated:NO];
//}

-(IBAction)loginAction:(id)sender
{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    LoginDetailViewController *loginDetail = (LoginDetailViewController*)[mainStoryboard
                                                                              instantiateViewControllerWithIdentifier: @"LoginDetailViewController"];
    
    
    [[SlideNavigationController sharedInstance] pushViewController:loginDetail animated:NO];
}
-(IBAction)promoCodeValidationAction:(id)sender
{
    [self frameJsonForPromoCodeValidation];
    
}

-(IBAction)OTPAction:(id)sender
{
    [passwordField_ resignFirstResponder];
    [self VerifyMobileNo];
    
//    [self frameJsonForSignUp];
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    
//    signUpOTPView = (SignUpOTPViewController*)[mainStoryboard
//                                                                              instantiateViewControllerWithIdentifier: @"SignUpOTPViewController"];
//    signUpOTPView.parametersVal=parametersVal;
//    signUpOTPView.emailID=self.email;
//    signUpOTPView.password=self.password;
//    
//    
//    signUpOTPView.isForgotPasswordUseOTP = NO;
//
//    
//    signUpOTPView.phoneNo = self.phoneNo;
//    [[SlideNavigationController sharedInstance] pushViewController:signUpOTPView animated:NO];
}
-(IBAction)submitAction:(id)sender
{
    if(phoneField_.text.length>0 && firstNameField_.text.length>0 && lastNameField_.text.length>0 && passwordField_.text.length>0 && emailField_.text.length>0)
    {
//        if(couponField_.text.length>0){
//            if(couponVerified)
//                [self frameJsonForSubmitlead];
//        }
//        else{
            [phoneField_ resignFirstResponder];
            [firstNameField_ resignFirstResponder];
            [lastNameField_ resignFirstResponder];
            [emailField_ resignFirstResponder];
            [passwordField_ resignFirstResponder];
            [self frameJsonForSignUp];
//        }
    }
    else{
        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Enter details"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [wsAlert show];
    }
    
    [self triggerOrderSummary];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    
    [APPDELEGATE_SHARED_MANAGER insertSignUpData:parametersVal:self.email];
    [self initiateSignUpAPI];
    
}

-(void)fetchSubmitResponseData
{
    
}

-(void)fetchPromoCodeResponseData
{
    
}

-(void)initiateSignUpAPI
{
    //if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
    SHARED_DELEGATE.signUpEmail = self.email;
    [RequestResposeHandler SignUpApiService:parametersVal :^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
        
        if (success)
        {
            NSLog(@"sucess");
            //[APPDELEGATE_SHARED_MANAGER clearFeedData];
            //[self fetchSubmitResponseData];
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
            //couponField_.text = @"";
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
    //[dict setObject:self.coupon forKey:@"promo_code"];
    [dict setObject:@"1,2,3" forKey:@"sku"];
    
    [promoCodeData addObject:dict];
    
    [self initiateValidatePromoCodePI];
}

-(void)frameJsonForSignUp
{
    
    parametersVal = @{@"first_name": self.firstname,
                      @"last_name":self.lastName,
                      @"email_id": self.email,
                      @"mobile_number": self.phoneNo,
                      @"password": self.password,
                      };
    
    NSLog(@"framed json %@",parametersVal);
    
    //[self addProgressIndicator];
    
}
-(void)frameJsonForSubmitlead
{
    SHARED_DELEGATE.cusSelectedCity = @"bangalore";
    SHARED_DELEGATE.cusLocation = @"Bangalore";
    
    SHARED_DELEGATE.cusSelectedCategory = @"Beauty";
    SHARED_DELEGATE.appID = @"1221";
    
    
    //    {
    //        "category": "beauty-services-at-home",
    //        "app_id": "8BDFE896-48AD-432D-B666-5D310171FBCB",
    //        "reg_id": "038632601161EAA6B55377445FB54EFA3C7625DC229CF1FF72AA54910B697F16",
    //        "user_details": "Tejas Jadhav Test Lead|9167369185|tejas@localoye.com|?|delhi",
    //        "city": "Gurgaon",
    //        "What is your location": "ABCD|72.9169200|19.0919720",
    //        "sku": "1,2.3"
    //    }
    
    
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
            cell.textLabel.text = @"Mobile Number" ;
            tf = phoneField_ = [self makeTextField:self.phoneNo placeholder:@"Mobile number (10 digit)"];
            //tf.keyboardType = UIKeyboardTypeNumberPad;
            [cell addSubview:phoneField_];
            break ;
        }
        case 1: {
            cell.textLabel.text = @"First Name" ;
            tf = firstNameField_ = [self makeTextField:self.firstname placeholder:@"John"];
            tf.keyboardType = UIKeyboardTypeAlphabet;
            [cell addSubview:firstNameField_];
            break ;
        }
        case 2: {
            cell.textLabel.text = @"Last Name" ;
            tf = lastNameField_ = [self makeTextField:self.lastName placeholder:@"Appleseed"];
            tf.keyboardType = UIKeyboardTypeAlphabet;
            [cell addSubview:lastNameField_];
            break ;
        }
        case 3: {
            cell.textLabel.text = @"Email" ;
            tf = emailField_ = [self makeTextField:self.email placeholder:@"test@gmail.com"];
            tf.keyboardType = UIKeyboardTypeAlphabet;
            [cell addSubview:emailField_];
            break ;
        }
        case 4: {
            cell.textLabel.text = @"Password" ;
            tf = passwordField_ = [self makeTextField:self.password placeholder:@"Password"];
            //tf.secureTextEntry = YES;
            [cell addSubview:passwordField_];
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
    if ( textField == firstNameField_ ) {
        self.firstname = firstNameField_.text ;
        
    } else if ( textField == lastNameField_ ) {
        self.lastName = lastNameField_.text ;
        
    } else if ( textField == phoneField_ ) {
        self.phoneNo = phoneField_.text ;
        
    } else if ( textField == emailField_ ) {
        self.email = emailField_.text ;
    }
    else if ( textField == passwordField_ ) {
        self.password = passwordField_.text ;
        
        //[self frameJsonForPromoCodeValidation];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)VerifyMobileNo
{
    self.phoneNo = [NSString stringWithFormat:@"91%@",self.phoneNo];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *mobileNumber = [f numberFromString:self.phoneNo];
    
    
    //NSNumber   *mobileNumber =[NSString stringWithFormat:@"%@",self.phoneNo];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",@"https://api.nexmo.com/verify/json?api_key=",NEXMO_API_KEY,@"&api_secret=",NEXMO_API_SECRET,@"&number=",mobileNumber,@"&brand=",NEXMO_BRAND];
    
    NSLog(@"urlString %@",urlString);
    
    NSData *returnData = [[NSData alloc]init];
    
    //Build the Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    //[request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //Send the Request
    returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    
    //Get the Result of Request
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    
    bool debug = YES;
    
    if (returnData != nil && response.length>0) {
        NSLog(@"Response >>>> %@",response);
        //[self triggerVerifyOTPCtrl];
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:returnData
                                                             options:kNilOptions
                                                               error:&error];
        if([json count]>0){
            if([[json objectForKey:@"status"] isEqualToString:@"0"]){
                self.requestID = [json objectForKey:@"request_id"];
                [self triggerOTPView];
                UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter the OTP" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [wsAlert show];
            }
            else{
                NSString *error =[json objectForKey:@"error_text"];
                UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [wsAlert show];
                
            }
        }
    }
}

-(void)triggerOTPView
{
    [self frameJsonForSignUp];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    signUpOTPView = (SignUpOTPViewController*)[mainStoryboard
                                               instantiateViewControllerWithIdentifier: @"SignUpOTPViewController"];
    signUpOTPView.parametersVal=parametersVal;
    signUpOTPView.emailID=self.email;
    signUpOTPView.password=self.password;
    signUpOTPView.requestID = self.requestID;
    signUpOTPView.phoneNo = self.phoneNo;
    
    signUpOTPView.isForgotPasswordUseOTP = NO;

    
    signUpOTPView.phoneNo = self.phoneNo;
    [[SlideNavigationController sharedInstance] pushViewController:signUpOTPView animated:NO];
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
