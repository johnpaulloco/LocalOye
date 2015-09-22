//
//  PromoCodeViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 19/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface PromoCodeViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    UITextField* promoCode_ ;
    BOOL couponVerified;
    NSMutableArray *promoCodeData;
    NSDictionary *parametersVal;
}
@property (weak, nonatomic) IBOutlet UIImageView *bannerImg;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLbl;


@property (nonatomic,strong) NSString* promoCode ;


@property (nonatomic, weak) IBOutlet UITableView *promoCodeTableView;


@end
