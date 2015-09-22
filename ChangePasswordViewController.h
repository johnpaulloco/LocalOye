//
//  ChangePasswordViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 16/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController<UITextFieldDelegate>
{
    UITextField* userField_ ;
    UITextField* passwordField_ ;
    
}

@property(nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *password ;


@end
