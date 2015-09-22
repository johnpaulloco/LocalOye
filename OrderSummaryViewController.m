//
//  OrderSummaryViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 24/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "OrderSummaryViewController.h"

@interface OrderSummaryViewController ()

@end

@implementation OrderSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.viewServiceRequestBtn setBackgroundColor:[UIColor orangeColor]];
    [self.serviceRequestBtn setBackgroundColor:[UIColor orangeColor]];
    [self.chatBtn setBackgroundColor:[UIColor orangeColor]];
    [self.requestHelpBtn setBackgroundColor:[UIColor orangeColor]];
    
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
