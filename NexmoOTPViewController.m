//
//  NexmoOTPViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 18/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "NexmoOTPViewController.h"
#import "LocalOyeConstants.h"
#import "VerifyNoViewController.h"

@interface NexmoOTPViewController ()

@end

@implementation NexmoOTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     [self.verifyPhoneNoBtn setBackgroundColor:[UIColor orangeColor]];
    [self.verifyPhoneNoBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.backItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.headerTitleLbl.font = [UIFont fontWithName:kLocalOyeFontMedium size:18.0];
    self.phoneLbl.font = [UIFont fontWithName:kLocalOyeFontLight size:14.0];
    self.initiatedInfoLbl.font = [UIFont fontWithName:kLocalOyeFontLight size:12.0];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.bannerImg.image = SHARED_DELEGATE.receivedBannerImg;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    //mobileNo = (long)[self.textFieldMobileNo.text intValue];
    
    NSString *number = self.textFieldMobileNo.text;
    
    NSLog(@"mobileNo %ld",number.integerValue);
    
    mobileNo = number.integerValue;

    [self.textFieldMobileNo resignFirstResponder];
    
    NSLog(@"textFieldDidEndEditing");
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:");
     [textField resignFirstResponder];
    return YES;
}

-(void)VerifyMobileNo
{
    //long int mob = 919620704460;
    
    NSNumber   *mobileNumber =[NSNumber numberWithLong:mobileNo];
    
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
    
    if (debug && response) {
        NSLog(@"Response >>>> %@",response);
        [self triggerVerifyOTPCtrl];
    }
    
    
}


-(IBAction)verifyPhoneNoBtnAction:(id)sender
{
    [self triggerVerifyOTPCtrl];
//    if(APPDELEGATE_SHARED_MANAGER.isConnected)
//    {
//        [self  VerifyMobileNo];
//    }
//    else{
//        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [wsAlert show];
//        
//    }
}

-(void)triggerVerifyOTPCtrl
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    VerifyNoViewController *verifyView = (VerifyNoViewController*)[mainStoryboard
                                                                   instantiateViewControllerWithIdentifier: @"VerifyNoViewController"];
    
    
    [[SlideNavigationController sharedInstance] pushViewController:verifyView animated:NO];
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
