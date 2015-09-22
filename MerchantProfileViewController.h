//
//  MerchantProfileViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 02/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "QuotesList.h"

@interface MerchantProfileViewController : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    NSArray *merchantList;
}

@property (nonatomic, weak) IBOutlet UITableView *merchantTableView;
@property (nonatomic, strong) QuotesList *quoteListObject;

@end
