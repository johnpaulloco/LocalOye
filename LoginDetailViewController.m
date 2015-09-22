//
//  LoginDetailViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 19/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "LoginDetailViewController.h"
#import "LocalOyeConstants.h"
#import "SignUpOTPViewController.h"
#import "CitySelectionViewController.h"
#import "RequestResposeHandler.h"
#import "AddressListViewController.h"
#import "AddEditAddressViewController.h"

@interface LoginDetailViewController ()

@end

@implementation LoginDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.initiatedInfoLbl.hidden = YES;
    
    [self.loginBtn setBackgroundColor:[UIColor orangeColor]];
    [self.forgotPassBtn setBackgroundColor:[UIColor orangeColor]];
    
    
    [self.loginBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:12.0]];
    [self.forgotPassBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:12.0]];
    
    self.loginBtn.layer.cornerRadius = 4.0;
    self.forgotPassBtn.layer.cornerRadius = 4.0;
    
    self.headerTitleLbl.font = [UIFont fontWithName:kLocalOyeFontMedium size:12.0];
    self.phoneLbl.font = [UIFont fontWithName:kLocalOyeFontMedium size:14.0];
    self.initiatedInfoLbl.font = [UIFont fontWithName:kLocalOyeFontMedium size:12.0];
    
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)VerifyOTPNo
{
    self.initiatedInfoLbl.hidden = NO;
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",@"https://api.nexmo.com/verify/check/json?api_key=",NEXMO_API_KEY,@"&api_secret=",NEXMO_API_SECRET,@"&request_id=",self.requestID,@"&code=",self.password];
    
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
    
    if (debug && response) {
        NSLog(@"Response >>>> %@",response);
        [self triggerPersonalDetailsCtrl];
    }
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
    if(emailField_.text.length>0 && password_.text.length>0)
        ret = TRUE;
    
    return ret;
}

-(IBAction)verifyOTPAction:(id)sender
{
    [self triggerPersonalDetailsCtrl];
    
    if(APPDELEGATE_SHARED_MANAGER.isConnected)
    {
        if([self validateOTPAndPhoneNo]){
            [self  VerifyOTPNo];
        }
        else
        {
            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Phone number or OTP invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [wsAlert show];
        }
    }
    else{
        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [wsAlert show];
    }
}
-(IBAction)resendOTPAction:(id)sender
{
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
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    // Make cell unselectable
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.font = [UIFont fontWithName:kLocalOyeFontLight size:11.0];
    
    UITextField* tf = nil ;
    //UIButton* btn = nil ;
    switch ( indexPath.row ) {
        case 0: {
            cell.textLabel.text = @"Email Address" ;
            tf = emailField_ = [self makeTextField:self.emailID placeholder:@"Enter email address"];
            tf.keyboardType = UIKeyboardTypeAlphabet;
            
            
            
            [cell addSubview:emailField_];
            break ;
        }
        case 1: {
            cell.textLabel.text = @"Password" ;
            
            tf = password_ = [self makeTextField:self.password placeholder:@"Enter Password"];
            tf.secureTextEntry = YES;
            [cell addSubview:password_];
            
            //btn = [self makeBtnField:@"RESEND OTP" placeholder:@""];
            //[cell addSubview:btn];
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

-(IBAction)loginAction:(id)sender{
    
    
    
    [emailField_ resignFirstResponder];
    [password_ resignFirstResponder];
    
    if(self.emailID.length>0 && self.password.length>0){
        [self initiateLoginAPI];
    }
    else{
        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Enter phone number and password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [wsAlert show];
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [emailField_ resignFirstResponder];
    [password_ resignFirstResponder];
}

-(IBAction)forgotPasswordAction:(id)sender{
   
    //if(self.emailID.length>0)
    {
        //if([APPDELEGATE_SHARED_MANAGER isConnected]){
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            
            SignUpOTPViewController *orderView = (SignUpOTPViewController*)[mainStoryboard
                                                                            instantiateViewControllerWithIdentifier: @"SignUpOTPViewController"];
            orderView.isForgotPasswordUseOTP = YES;
            orderView.emailID = self.emailID;
            [[SlideNavigationController sharedInstance] pushViewController:orderView animated:NO];
            
//        }
//        else{
//            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Internet appears to be offline" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [wsAlert show];
//            
//        }
    }
//    else{
//        
//        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Enter phone number to validate" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [wsAlert show];
//    }
    

}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(UIButton*) makeBtnField: (NSString*)text
              placeholder: (NSString*)placeholder  {
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(self.view.frame.size.width-80, 4, 80, 35)];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontBold size:9.0]];
    
    btn.backgroundColor = [UIColor clearColor];
    //[btn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    
    [btn addTarget:self action:@selector(resendOTPAction:) forControlEvents:UIControlEventTouchDown];
    
    return btn ;
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
    if ( textField == emailField_ ) {
        self.emailID = emailField_.text ;
    } else if ( textField == password_ ) {
        self.password = password_.text ;
    }
}

-(void)triggerCitySelection
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    CitySelectionViewController *orderView = (CitySelectionViewController*)[mainStoryboard
                                                                            instantiateViewControllerWithIdentifier: @"CitySelectionViewController"];
    
    //[[SlideNavigationController sharedInstance] pushViewController:orderView animated:NO];
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:orderView
                                                             withSlideOutAnimation:YES
                                                                     andCompletion:nil];
    
    
}

-(void)triggerAddressList
{
    NSArray *addressList = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"Address"];
    if([addressList count]>0){
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    AddressListViewController *addresList = (AddressListViewController*)[mainStoryboard
                                                                            instantiateViewControllerWithIdentifier: @"AddressListViewController"];
    
    //[[SlideNavigationController sharedInstance] pushViewController:orderView animated:NO];
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:addresList
                                                             withSlideOutAnimation:YES
                                                                     andCompletion:nil];
    
    }
    else
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        AddEditAddressViewController *addressEditView = (AddEditAddressViewController*)[mainStoryboard
                                                                             instantiateViewControllerWithIdentifier: @"AddEditAddressViewController"];
        
        //[[SlideNavigationController sharedInstance] pushViewController:orderView animated:NO];
        
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:addressEditView
                                                                 withSlideOutAnimation:YES
                                                                         andCompletion:nil];
        

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
    //if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
   NSDictionary *parameters = [self frameJsonForLogin];
        [RequestResposeHandler LoginApiService:parameters:^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
            
            if (success)
            {
                NSLog(@"sucess");
                if(SHARED_DELEGATE.userID.length>0){
                    
                    [self initiateCustomerProfileAPI];
                    if(!self.isFromSignUpLandingView)
                        [self triggerAddressList];
                    else
                        [self triggerCitySelection];
                }
                else{
                    UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Login failed"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [wsAlert show];
                }
            }
            else{
                
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

-(void)initiateCustomerProfileAPI
{
    //if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
    [RequestResposeHandler GetCustomerProfileUsingUserIDService:SHARED_DELEGATE.userID:self.emailID:^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
        
        if (success)
        {
            NSLog(@"sucess");
//            if(SHARED_DELEGATE.userID.length>0){
//                
//                if(!self.isFromSignUpLandingView)
//                    [self triggerAddressList];
//                else
//                    [self triggerCitySelection];
//            }
//            else{
//                UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Login failed"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [wsAlert show];
//            }
        }
        else{
            
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
