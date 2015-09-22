//
//  SignUpOTPViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 19/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpOTPViewController : UIViewController<UITextFieldDelegate>
{
    UITextField* phoneField_ ;
    UITextField* otpField_ ;
    UITextField* newPasswordField_ ;
    
    NSString *email;
    
    
    
}
@property (weak, nonatomic) IBOutlet UIButton *verifyMobileNoBtn;
@property (weak, nonatomic) IBOutlet UIButton *verifyOTPBtn;
@property (weak, nonatomic) IBOutlet UIButton *resendOTPBtn;
@property (weak, nonatomic) IBOutlet UILabel *initiatedInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic,assign) BOOL isForgotPasswordUseOTP;


@property(nonatomic,strong) NSDictionary *parametersVal;
@property(nonatomic,strong) NSString *emailID;

@property(nonatomic,strong) NSString *requestID;
@property(nonatomic,strong) NSString *otpCode;


@property (nonatomic,strong) NSString *phoneNo ;
@property (nonatomic,strong) NSString *password;


@property (nonatomic, weak) IBOutlet UITableView *verifyTableView;


@end
