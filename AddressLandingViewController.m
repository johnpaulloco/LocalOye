//
//  AddressLandingViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 16/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "AddressLandingViewController.h"
#import "LocalOyeConstants.h"
#import "AddEditAddressViewController.h"
#import "AddressListViewController.h"

@interface AddressLandingViewController ()

@end

@implementation AddressLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    self.addAdrressBtn.backgroundColor = [UIColor orangeColor];
}

-(IBAction)addAddress:(id)sender
{
    if([SHARED_DELEGATE addressListAvailable]){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        AddressListViewController *orderView = (AddressListViewController*)[mainStoryboard
                                                                                  instantiateViewControllerWithIdentifier: @"AddressListViewController"];
        
        
        [[SlideNavigationController sharedInstance] pushViewController:orderView animated:NO];
        
    }
    else{
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        AddEditAddressViewController *orderView = (AddEditAddressViewController*)[mainStoryboard
                                                                                  instantiateViewControllerWithIdentifier: @"AddEditAddressViewController"];
        
        
        [[SlideNavigationController sharedInstance] pushViewController:orderView animated:NO];
        
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
