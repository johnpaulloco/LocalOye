//
//  ServiceDetailViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 13/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildCategory.h"


@interface ServiceDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
{
    NSArray *questionArrayList;
    BOOL isRateCardDataAvailable;
}

@property (nonatomic, weak) IBOutlet UIImageView *bannerImg;


@property (weak, nonatomic) IBOutlet UIImageView *serviceImage;
@property (weak, nonatomic) IBOutlet UILabel *serviceHeader;
@property (weak, nonatomic) IBOutlet UILabel *serviceDesc;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *letGoBtn;
@property (nonatomic, strong)  NSArray *serviceCoveredList;

@property (nonatomic, strong)  ChildCategory *childCat;

-(IBAction)letsProceed:(id)sender;

@end
