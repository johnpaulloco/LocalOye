//
//  SignUpViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 18/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "SignUpOTPViewController.h"

@interface SignUpViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    NSMutableArray *submitArray;
    NSMutableArray *promoCodeData;
    
    NSString* phoneNo_ ;
    NSString* firstName_ ;
    NSString* lastName ;
    NSString* email_ ;
    NSString* password_ ;


    
    UITextField* phoneField_ ;
    UITextField* firstNameField_ ;
    UITextField* lastNameField_ ;
    UITextField* emailField_ ;
    UITextField* passwordField_ ;
    
    
    BOOL couponVerified;
    NSDictionary *parametersVal;
    
    SignUpOTPViewController *signUpOTPView;
}

// Creates a textfield with the specified text and placeholder text
-(UITextField*) makeTextField: (NSString*)text
                  placeholder: (NSString*)placeholder  ;

// Handles UIControlEventEditingDidEndOnExit
- (IBAction)textFieldFinished:(id)sender ;

@property (nonatomic,strong) NSString* phoneNo ;
@property (nonatomic,strong) NSString* firstname ;
@property (nonatomic,strong) NSString* lastName ;
@property (nonatomic,strong) NSString* email ;
@property (nonatomic,strong) NSString* password ;



@property (nonatomic, weak) IBOutlet UITableView *detailsTableView;
@property (nonatomic, weak) IBOutlet UILabel *headerLbl;
@property (nonatomic, weak) IBOutlet UILabel *headerDesc;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, weak) IBOutlet UIImageView *bannerImg;

@property(nonatomic,strong) NSString *requestID;
@property(nonatomic,strong) NSString *otpCode;

@property(nonatomic,assign) BOOL *isFromPickerView;

@property(nonatomic,assign) BOOL isFromSignUpLandingView;


-(IBAction)submitAction:(id)sender;
-(IBAction)loginAction:(id)sender;


@end
