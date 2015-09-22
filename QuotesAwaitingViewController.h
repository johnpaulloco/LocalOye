//
//  QuotesAwaitingViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 31/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "MyOrder.h"

@interface QuotesAwaitingViewController : UIViewController<MBProgressHUDDelegate>
{
    NSMutableArray *panicBtns;
    MBProgressHUD *HUD;
    NSString *causeStr;
    NSString *causeEnum;
    NSString *rescheduleEnum;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *headerLbl;
@property (nonatomic, weak) IBOutlet UILabel *awaitingHeaderLbl;
@property (nonatomic, weak) IBOutlet UILabel *awaitingDescHeaderLbl;


@property (nonatomic, weak) IBOutlet UILabel *needHelpHeaderLbl;
@property (nonatomic, weak) IBOutlet UILabel *needHelpDescHeaderLbl;

@property (nonatomic, weak) IBOutlet UIButton *veiwOrderBtn;
@property (nonatomic, weak) IBOutlet UIButton *browseOtherServBtn;

@property (nonatomic, weak) IBOutlet UIImageView *bannerImg;


@property (nonatomic, weak) IBOutlet UIView *orderSubView;
@property (nonatomic, weak) IBOutlet UIView *tableSubView;

@property (nonatomic, strong) MyOrder* myOrderObj;

-(IBAction)viewOrders:(id)sender;
-(IBAction)viewOtherServices:(id)sender;

@end
