//
//  MyOrderListViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 25/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface MyOrderListViewController : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    NSArray *myOrderList;
    
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, assign)  BOOL viewFromOrderSummary;

@end
