//
//  AddressListViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 18/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *addressList;
}

@property (nonatomic, weak) IBOutlet UIButton *addAddresBtn;
@property (nonatomic, weak) IBOutlet UITableView *tableView;



-(IBAction)nextBtnAction:(id)sender;


@end
