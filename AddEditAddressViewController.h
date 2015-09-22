//
//  AddEditAddressViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 17/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AddEditAddressViewController : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate>
{
    UITextField* addressTypeField_ ;
    UITextField* houseNoField_ ;
    UITextField* country_ ;
    UITextField* state_ ;
    UITextField* city_ ;
    UITextField* locationField_ ;

    CLLocationDegrees currentLat;
    CLLocationDegrees currentLong;
    CLLocationManager *locationManager;
}

@property(nonatomic,strong) NSString *addresType;
@property (nonatomic,strong) NSString *houseNo ;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *location ;

@property (weak, nonatomic) IBOutlet UITableView *tableViewObj;
@property (weak, nonatomic) IBOutlet UIButton *addAdrressBtn;


@property (nonatomic, strong)  NSString *retrievedAddress;

-(IBAction)addAddress:(id)sender;

@end
