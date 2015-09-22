//
//  UserProfileViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 17/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController<UITextFieldDelegate>
{
    UITextField* firstNameField_ ;
    UITextField* lastNameField_ ;
    UITextField* emailField_ ;
    UITextField* phoneNoField_ ;
    UITextField* addressField_ ;
    
}

@property(nonatomic,strong) NSString *firstName;
@property (nonatomic,strong) NSString *lastName ;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *phoneNo ;
@property (nonatomic,strong) NSString *address ;

@end
