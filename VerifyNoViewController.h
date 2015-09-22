//
//  VerifyNoViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 24/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyNoViewController : UIViewController<UITextFieldDelegate>
{
    UITextField* phoneField_ ;
    UITextField* otpField_ ;
    
}

@property (weak, nonatomic) IBOutlet UIButton *verifyOTPBtn;
@property (weak, nonatomic) IBOutlet UIButton *resendOTPBtn;
@property (weak, nonatomic) IBOutlet UILabel *initiatedInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (nonatomic, weak) IBOutlet UIImageView *bannerImg;

@property(nonatomic,strong) NSString *requestID;
@property(nonatomic,strong) NSString *otpCode;


@property (nonatomic,strong) NSString* phoneNo ;


@property (nonatomic, weak) IBOutlet UITableView *verifyTableView;


@end
