//
//  SignUpOTPViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 19/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "SignUpOTPViewController.h"
#import "LocalOyeConstants.h"
#import "CitySelectionViewController.h"
#import "RequestResposeHandler.h"
@interface SignUpOTPViewController ()

@end

@implementation SignUpOTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.initiatedInfoLbl.hidden = YES;
    
    [self.verifyMobileNoBtn setBackgroundColor:[UIColor orangeColor]];
    [self.verifyOTPBtn setBackgroundColor:[UIColor orangeColor]];
    [self.resendOTPBtn setBackgroundColor:[UIColor orangeColor]];
    
    
    [self.verifyOTPBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    
    self.headerTitleLbl.font = [UIFont fontWithName:kLocalOyeFontMedium size:18.0];
    self.phoneLbl.font = [UIFont fontWithName:kLocalOyeFontMedium size:14.0];
    self.initiatedInfoLbl.font = [UIFont fontWithName:kLocalOyeFontMedium size:12.0];
    
    
    //self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    //self.navigationController.navigationBar.backItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    
    NSLog(@"parametersVal %@",self.parametersVal);
    
    if(self.isForgotPasswordUseOTP){
        self.verifyMobileNoBtn.hidden= NO;
    }
    else{
        //[self VerifyMobileNo];
        //[self verifyMobileNo:nil];
        
        self.verifyMobileNoBtn.hidden= YES;
        //[self frameJsonForSignUp];
    }
    
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

-(IBAction)verifyMobileNo:(id)sender{
    self.phoneNo = phoneField_.text;
    [self VerifyMobileNo];
}
-(void)VerifyOTPNo
{
    self.initiatedInfoLbl.hidden = NO;
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",@"https://api.nexmo.com/verify/check/json?api_key=",NEXMO_API_KEY,@"&api_secret=",NEXMO_API_SECRET,@"&request_id=",self.requestID,@"&code=",self.otpCode];
    
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
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:returnData
                                                             options:kNilOptions
                                                               error:&error];
        
        if([[json objectForKey:@"status"] isEqualToString:@"0"])
        {
            SHARED_DELEGATE.OTPDone = YES;
            
            if (self.isForgotPasswordUseOTP) {
                //[self frameJsonForLogin];
                [self initiateLoginUsingMobileAPI];
            }
            else
            {
               [self frameJsonForSignUp];
            }
            
            
            
        }
        else{
            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Enter valid OTP" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [wsAlert show];
        }
        //[self triggerPersonalDetailsCtrl];
    }
}

-(void)frameJsonForResetPass
{
    self.parametersVal = @{@"user_id": SHARED_DELEGATE.userID,
                      @"email_id":SHARED_DELEGATE.signUpEmail,
                      @"new_password":self.password
                      };
    
    NSLog(@"framed json %@",self.parametersVal);
    
}
-(void)frameJsonForSignUp
{
    [self addProgressIndicator];
}

-(void)addProgressIndicator
{
    
    [APPDELEGATE_SHARED_MANAGER insertSignUpData:self.parametersVal:self.emailID];
    [self initiateSignUpAPI];
    
}

-(void)initiateLoginUsingMobileAPI
{
    if([APPDELEGATE_SHARED_MANAGER isConnected]){
        
        SHARED_DELEGATE.signUpEmail = self.emailID;
        [RequestResposeHandler LoginUsingMobileApiService:self.phoneNo :^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
            
            if (success)
            {
                NSLog(@"sucess");
                //[self initiateLoginAPI];
                [self triggerCityView];
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



-(void)initiateSignUpAPI
{
    if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
    SHARED_DELEGATE.signUpEmail = self.emailID;
    [RequestResposeHandler SignUpApiService:self.parametersVal :^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
        
        if (success)
        {
            NSLog(@"sucess");
            [self initiateLoginAPI];
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

-(NSDictionary*)frameJsonForLogin
{
    NSDictionary *parameters = @{@"email_id": self.emailID,
                                    @"password":self.password
                                    };
    
    NSLog(@"framed json %@",parameters);
    
    
    return parameters;
    
    
}

-(void)initiateLoginAPI
{
    if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
    self.parametersVal = [self frameJsonForLogin];
    [RequestResposeHandler LoginApiService:self.parametersVal:^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
        
        if (success)
        {
            NSLog(@"sucess");
            if(SHARED_DELEGATE.userID.length>0){
                [self triggerCityView];
            }
            else{
                UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Login failed"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [wsAlert show];
            }
        }
        else{
            //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(error,@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [wsAlert show];
            
            [self.navigationController popViewControllerAnimated:NO];
        }
        
    }];
     }
        else{
            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [wsAlert show];
        }
}

-(void)initiateResetPassAPI
{
    //if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
    [self frameJsonForResetPass];
    
    [RequestResposeHandler ResetPasswordApiService:self.parametersVal:^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
        
        if (success)
        {
            NSLog(@"sucess");
            if(SHARED_DELEGATE.resetPasswordSucess){
                [self triggerCityView];
            }
            else{
                UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Reset Password failed"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [wsAlert show];
            }
        }
        else{
            //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(error,@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [wsAlert show];
        }
        
    }];
    // }
    //    else{
    //        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [wsAlert show];
    //    }
}


-(void)triggerPersonalDetailsCtrl
{
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    
//    PersonalDetailsViewController *orderView = (PersonalDetailsViewController*)[mainStoryboard
//                                                                                instantiateViewControllerWithIdentifier: @"PersonalDetailsViewController"];
//    
//    [[SlideNavigationController sharedInstance] pushViewController:orderView animated:NO];
//    
}

-(BOOL)validateOTPAndPhoneNo
{
    BOOL ret = FALSE;
    if(phoneField_.text.length>0 && otpField_.text.length>0)
        ret = TRUE;
    
    return ret;
}

-(void)triggerCityView
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    CitySelectionViewController *cityView = (CitySelectionViewController*)[mainStoryboard
                                                                               instantiateViewControllerWithIdentifier: @"CitySelectionViewController"];
    
    
    
    //[[SlideNavigationController sharedInstance] pushViewController:merchantView animated:NO];
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:cityView
                                                             withSlideOutAnimation:YES
                                                                     andCompletion:nil];
    
}
-(IBAction)verifyOTPAction:(id)sender
{
    if([APPDELEGATE_SHARED_MANAGER isConnected]){
        if(SHARED_DELEGATE.OTPDone)
            [self initiateSignUpAPI];
        else
            [self VerifyOTPNo];
    }
    else{
        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [wsAlert show];
    }
    //[self triggerPersonalDetailsCtrl];
    
//    if(APPDELEGATE_SHARED_MANAGER.isConnected)
//    {
//        if([self validateOTPAndPhoneNo]){
//            [self  VerifyOTPNo];
//        }
//        else
//        {
//            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Phone number or OTP invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [wsAlert show];
//        }
//    }
//    else{
//        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [wsAlert show];
//    }
}
-(IBAction)resendOTPAction:(id)sender
{
    [self VerifyMobileNo];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if(self.isForgotPasswordUseOTP)
        return 2;
    else
        return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    // Make cell unselectable
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.font = [UIFont fontWithName:kLocalOyeFontLight size:14.0];
    
    UITextField* tf = nil ;
    UIButton* btn = nil ;
    switch ( indexPath.row ) {
        case 0: {
            cell.textLabel.text = @"Phone Number" ;
            tf = phoneField_ = [self makeTextField:self.phoneNo placeholder:@"Enter phone number"];
            tf.keyboardType = UIKeyboardTypeNumberPad;
            
            [cell addSubview:phoneField_];
            break ;
        }
        case 1: {
            cell.textLabel.text = @"OTP" ;
            
            tf = otpField_ = [self makeTextField:self.otpCode placeholder:@"Enter OTP"];
            tf.keyboardType = UIKeyboardTypeAlphabet;
            [cell addSubview:otpField_];
            
            btn = [self makeBtnField:@"RESEND OTP" placeholder:@""];
            [cell addSubview:btn];
            break ;
        }
        case 2: {
            cell.textLabel.text = @"Password" ;
            
            tf = newPasswordField_ = [self makeTextField:self.password placeholder:@"Enter New password"];
            tf.secureTextEntry = YES;
            [cell addSubview:newPasswordField_];
            
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

-(UIButton*) makeBtnField: (NSString*)text
              placeholder: (NSString*)placeholder  {
    self.btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setFrame:CGRectMake(self.view.frame.size.width-80, 4, 80, 35)];
    [self.btn setTitle:text forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.btn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontBold size:9.0]];
    
    self.btn.backgroundColor = [UIColor clearColor];
    //[btn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    
    [self.btn addTarget:self action:@selector(resendOTPAction:) forControlEvents:UIControlEventTouchDown];
    
    return self.btn ;
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
    if ( textField == phoneField_ ) {
        self.phoneNo = phoneField_.text ;
    } else if ( textField == otpField_ ) {
        self.otpCode = otpField_.text ;
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
