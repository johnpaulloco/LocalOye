//
//  VerifyNoViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 24/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "VerifyNoViewController.h"
#import "PersonalDetailsViewController.h"
#import "LocalOyeConstants.h"

@interface VerifyNoViewController ()

@end

@implementation VerifyNoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.initiatedInfoLbl.hidden = YES;
    
    [self.verifyOTPBtn setBackgroundColor:[UIColor orangeColor]];
    [self.resendOTPBtn setBackgroundColor:[UIColor orangeColor]];
    
    
     [self.verifyOTPBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    
    self.headerTitleLbl.font = [UIFont fontWithName:kLocalOyeFontMedium size:18.0];
    self.phoneLbl.font = [UIFont fontWithName:kLocalOyeFontMedium size:14.0];
    self.initiatedInfoLbl.font = [UIFont fontWithName:kLocalOyeFontMedium size:12.0];
    
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.backItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.bannerImg.image = SHARED_DELEGATE.receivedBannerImg;
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
    
    if (debug && response) {
        NSLog(@"Response >>>> %@",response);
        [self triggerPersonalDetailsCtrl];
    }
}

-(void)triggerPersonalDetailsCtrl
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    PersonalDetailsViewController *orderView = (PersonalDetailsViewController*)[mainStoryboard
                                                                                instantiateViewControllerWithIdentifier: @"PersonalDetailsViewController"];
    
    [[SlideNavigationController sharedInstance] pushViewController:orderView animated:NO];
    
}

-(BOOL)validateOTPAndPhoneNo
{
    BOOL ret = FALSE;
    if(phoneField_.text.length>0 && otpField_.text.length>0)
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
    
    cell.textLabel.font = [UIFont fontWithName:kLocalOyeFontLight size:14.0];
    
    UITextField* tf = nil ;
    UIButton* btn = nil ;
    switch ( indexPath.row ) {
        case 0: {
            cell.textLabel.text = @"Phone Number" ;
            tf = phoneField_ = [self makeTextField:self.phoneNo placeholder:@"Enter phone number"];
            
            

            
            [cell addSubview:phoneField_];
            break ;
        }
        case 1: {
            cell.textLabel.text = @"OTP" ;
            
            tf = otpField_ = [self makeTextField:self.otpCode placeholder:@"Enter OTP"];
            [cell addSubview:otpField_];
            
            btn = [self makeBtnField:@"RESEND OTP" placeholder:@""];
            [cell addSubview:btn];
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
    if ( textField == phoneField_ ) {
        self.phoneNo = phoneField_.text ;
    } else if ( textField == otpField_ ) {
        self.otpCode = otpField_.text ;
    }
}


@end
