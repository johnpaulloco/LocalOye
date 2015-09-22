//
//  RateCardDetailViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 13/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionRateCard.h"


@interface RateCardDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *list1;
    NSMutableArray *list2;
}

@property (nonatomic, weak) IBOutlet UIImageView    *bannerImg;
@property (nonatomic, weak) IBOutlet UILabel        *titleLbl;
@property (nonatomic, weak) IBOutlet UIButton       *addToCardBtn;
@property (nonatomic, weak) IBOutlet UITableView    *tableviewDetail;
@property (nonatomic, weak) IBOutlet UITableView    *tableviewService;
@property (nonatomic, weak) IBOutlet UITextView     *descTextView;
@property (nonatomic, strong) UIImage               *receivedBanerImg;
@property (nonatomic, strong) QuestionRateCard      *rateCardObj;

-(IBAction)addToCart:(id)sender;

@end
