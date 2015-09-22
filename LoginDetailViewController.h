//
//  LoginDetailViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 19/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginDetailViewController : UIViewController<UITextFieldDelegate>
{
    UITextField* emailField_ ;
    UITextField* password_ ;
    NSDictionary *parametersVal;
}

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgotPassBtn;
@property (weak, nonatomic) IBOutlet UILabel *initiatedInfoLbl;
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;

@property(nonatomic,strong) NSString *requestID;
@property(nonatomic,strong) NSString *password;


@property (nonatomic,strong) NSString* emailID ;

@property (nonatomic,assign) BOOL isFromSignUpLandingView ;



@property (nonatomic, weak) IBOutlet UITableView *verifyTableView;


-(IBAction)loginAction:(id)sender;
-(IBAction)forgotPasswordAction:(id)sender;

@end
