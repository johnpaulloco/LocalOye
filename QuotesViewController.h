//
//  QuotesViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 31/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCollapseTableView.h"
#import "MBProgressHUD.h"
#import "MyOrder.h"

@interface QuotesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,MBProgressHUDDelegate>
{
    NSMutableArray *panicBtns;
    MBProgressHUD *HUD;
    NSArray *quotesList;
     NSString *causeStr;
    NSString *causeEnum;
    NSString *rescheduleEnum;
    NSNumber *rating;
   
}

@property (nonatomic, weak) IBOutlet UITableView *quotesTableView;
@property (nonatomic, weak) IBOutlet UITableView *panicbtnsTableView;

@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
@property (nonatomic, weak) IBOutlet UIView *helpBGView;

@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) NSMutableArray* headers;
@property (nonatomic, strong) MyOrder* myOrderObj;

@property (nonatomic, strong) NSNumber* leadID;


@end
