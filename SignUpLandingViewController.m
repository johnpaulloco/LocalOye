//
//  SignUpLandingViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 16/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "SignUpLandingViewController.h"
#import "LocalOyeConstants.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "LoginDetailViewController.h"
#import "CitySelectionViewController.h"
#import "PdfViewController.h"

@interface SignUpLandingViewController ()

@end

@implementation SignUpLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.loginBtn setBackgroundColor:[UIColor orangeColor]];
    [self.signupBtn setBackgroundColor:kLoginBtnColor];
    
    self.loginBtn.layer.cornerRadius = 2.0;
    self.signupBtn.layer.cornerRadius = 2.0;
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
    
    
    
    
   
}

- (void)goBack
{
    NSLog(@"pop");
    
}


-(IBAction)loginAction:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    LoginDetailViewController *merchantView = (LoginDetailViewController*)[mainStoryboard
                                                                 instantiateViewControllerWithIdentifier: @"LoginDetailViewController"];
    
    
    merchantView.isFromSignUpLandingView = YES;
    
    [[SlideNavigationController sharedInstance] pushViewController:merchantView animated:NO];
}

-(IBAction)signUp:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    SignUpViewController *signUpView = (SignUpViewController*)[mainStoryboard
                                                               instantiateViewControllerWithIdentifier: @"SignUpViewController"];
    
    
    signUpView.isFromSignUpLandingView = YES;
    
    [[SlideNavigationController sharedInstance] pushViewController:signUpView animated:NO];

}

-(IBAction)skipNow:(id)sender
{
   
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    CitySelectionViewController *cityView = (CitySelectionViewController*)[mainStoryboard
                                                                 instantiateViewControllerWithIdentifier: @"CitySelectionViewController"];
    
    
    
    //[[SlideNavigationController sharedInstance] pushViewController:merchantView animated:NO];
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:cityView
                                                             withSlideOutAnimation:YES
                                                                     andCompletion:nil];
    

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
