//
//  MerchantOnlineQuoteViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 04/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "LocalOyeConstants.h"
#import "QuotesList.h"
#import "MyOrder.h"
#import "MerchantProfile.h"

@interface MerchantOnlineQuoteViewController : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    NSArray *onlineQuoteList;
    
    NSString *downLoadLink;
    
}

@property (nonatomic, weak) IBOutlet UIButton       *downloadPdfbtn;
@property (nonatomic, weak) IBOutlet UIImageView    *star1;
@property (nonatomic, weak) IBOutlet UIImageView    *star2;
@property (nonatomic, weak) IBOutlet UIImageView    *star3;
@property (nonatomic, weak) IBOutlet UIImageView    *star4;
@property (nonatomic, weak) IBOutlet UIImageView    *star5;
@property (nonatomic, weak) IBOutlet UIImageView    *verified;
@property (nonatomic, weak) IBOutlet UIImageView    *experienced;

@property (nonatomic, weak) IBOutlet UITextView     *certifications;
@property (nonatomic, weak) IBOutlet UITextView     *descriptionStr;
@property (nonatomic, weak) IBOutlet UILabel        *merchant_name;
@property (nonatomic, weak) IBOutlet UILabel        *phone;
@property (nonatomic, weak) IBOutlet UIImageView    *profile_pic;
@property (nonatomic, weak) IBOutlet UITextView     *quote_text;
@property (nonatomic, weak) IBOutlet UILabel        *quotesTitle;
@property (nonatomic, weak) IBOutlet UILabel        *quotesDate;

@property (nonatomic, strong) QuotesList            *quoteListObject;
@property (nonatomic, strong) MyOrder               *myOderObject;

@property (nonatomic, strong) MerchantProfile *merProf;

@end
