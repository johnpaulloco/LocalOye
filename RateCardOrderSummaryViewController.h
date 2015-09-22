//
//  RateCardOrderSummaryViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 13/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionRateCard.h"

@interface RateCardOrderSummaryViewController : UIViewController
{
    NSInteger totalVal;
}

@property (nonatomic, weak) IBOutlet UIImageView    *bannerImg;
@property (weak, nonatomic) IBOutlet UIButton       *continueBtn;
@property (weak, nonatomic) IBOutlet UILabel        *headerTitle;
@property (weak, nonatomic) IBOutlet UILabel        *totalval;
@property (nonatomic, strong)  NSArray              *questionArrayList;
@property (nonatomic, strong)  UIImage              *receivedBanerImg;

@property (nonatomic, strong) NSArray               *rateCardList;
@property (nonatomic, strong) NSNumber               *minimumOrderVal;
-(IBAction)continueAction:(id)sender;

@end
