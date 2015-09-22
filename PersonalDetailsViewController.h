//
//  PersonalDetailsViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 24/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

//@interface PersonalDetailsViewController : UIViewController<MBProgressHUDDelegate>
@interface PersonalDetailsViewController :UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    NSMutableArray *submitArray;
    NSMutableArray *promoCodeData;
    
    NSString* phoneNo_ ;
    NSString* coupon_ ;
    NSString* email_ ;
    
    NSString* name_ ;
    NSString* address_ ;
    NSString* password_ ;
    NSString* description_ ;
    
    UITextField* nameField_ ;
    UITextField* addressField_ ;
    UITextField* passwordField_ ;
    UITextField* descriptionField_ ;
    UITextField* phoneField_ ;
    UITextField* couponField_ ;
    UITextField* emailField_ ;
    
    BOOL couponVerified;
    NSDictionary *parametersVal;
    
}

// Creates a textfield with the specified text and placeholder text
-(UITextField*) makeTextField: (NSString*)text
                  placeholder: (NSString*)placeholder  ;

// Handles UIControlEventEditingDidEndOnExit
- (IBAction)textFieldFinished:(id)sender ;

@property (nonatomic,strong) NSString* name ;
@property (nonatomic,strong) NSString* address ;
@property (nonatomic,strong) NSString* password ;
@property (nonatomic,strong) NSString* descriptionStr ;

@property (nonatomic,strong) NSString* coupon ;
@property (nonatomic,strong) NSString* email ;
@property (nonatomic,strong) NSString* phoneNo ;


@property (nonatomic, weak) IBOutlet UITableView *detailsTableView;
@property (nonatomic, weak) IBOutlet UILabel *headerLbl;
@property (nonatomic, weak) IBOutlet UILabel *headerDesc;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic, weak) IBOutlet UIImageView *bannerImg;

-(IBAction)submitAction:(id)sender;

@end



