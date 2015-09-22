//
//  NexmoOTPViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 18/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NexmoOTPViewController : UIViewController
{
    long int mobileNo;
}
@property (weak, nonatomic) IBOutlet UIButton *verifyPhoneNoBtn;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMobileNo;

@property (weak, nonatomic) IBOutlet UILabel *initiatedInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (nonatomic, weak) IBOutlet UIImageView *bannerImg;


@end
