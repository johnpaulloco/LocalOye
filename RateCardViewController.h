//
//  RateCardViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 02/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "STCollapseTableView.h"
#import "UICollectionPicker.h"
#import "RateCard.h"
#import "QuestionRateCard.h"

@interface RateCardViewController : UIViewController<MBProgressHUDDelegate,UITableViewDataSource, UITableViewDelegate>
{
    MBProgressHUD *HUD;
    NSNumber *minimumOrder;
}

@property (nonatomic, weak) IBOutlet STCollapseTableView        *rateCardTableView;
@property (nonatomic, weak) IBOutlet UIImageView                *bannerImg;
@property (weak, nonatomic) IBOutlet UIButton                   *nextBtn;
@property (nonatomic, strong) NSMutableArray                    *data;
@property (nonatomic, strong) NSMutableArray                    *headers;
@property (nonatomic, strong) NSArray                           *rateCardList;
@property (nonatomic, strong) NSArray                           *majorSkuArray;
@property (nonatomic, strong) NSMutableArray                    *minorSkuArray;
@property (nonatomic, strong) NSMutableArray                    *skuArray;
@property (nonatomic, strong) QuestionRateCard                  *rateCardObj;

-(IBAction)continueAction:(id)sender;
-(NSArray*)fetchDataForMinorSkuFromDb : (NSString*)majorSkuName : (NSString*)minorSkuName : (NSString*)skuName;





@end


