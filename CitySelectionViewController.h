//
//  CitySelectionViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 19/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "MBProgressHUD.h"


@interface CitySelectionViewController : UIViewController<MBProgressHUDDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSArray *cityList;
    MBProgressHUD *HUD;
}

@property (nonatomic, weak) IBOutlet UIButton *nextBtn;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic, strong)  NSString *selectedCityID;

-(IBAction)nextBtnAction:(id)sender;

@end
