//
//  LoginViewController.h
//  SlideMenu
//
//  Created by Imma Web Pvt Ltd on 07/08/15.
//  Copyright (c) 2015 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "MBProgressHUD.h"
#import <unistd.h>


@interface LoginViewController : UIViewController<MBProgressHUDDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSIndexPath             *lastIndexPath;
    NSArray *cityList;
    MBProgressHUD *HUD;
    long long expectedLength;
    long long currentLength;
}

@property (nonatomic, weak) IBOutlet UIButton *nextBtn;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic, strong)  NSString *selectedCityID;

-(IBAction)nextBtnAction:(id)sender;

@end
