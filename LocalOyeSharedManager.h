//
//  LocalOyeSharedManager.h
//  LocalOye
//
//  Created by John
//  Copyright (c) 2015 LocalOye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalOyeConstants.h"


/**
 The LocalOyeSharedManager class is a singleton DataModel class to store runtime fetched data.
 */
@interface LocalOyeSharedManager : NSObject{
    
}

@property(nonatomic)            NSString        *selectedCityID;
@property(nonatomic)            NSString        *selectedServiceName;
@property(nonatomic)            NSString        *selectedServiceHeader;
@property(nonatomic)            NSString        *cusSelectedCategory;
@property(nonatomic)            NSString        *cusName;
@property(nonatomic)            NSString        *cusSelectedDateTime;
@property(nonatomic)            NSString        *cusMobileNo;
@property(nonatomic)            NSString        *cusEmailID;
@property(nonatomic)            NSString        *cusSelectedCity;
@property(nonatomic)            NSString        *cusLocation;
@property(nonatomic)            NSString        *cusLatitude;
@property(nonatomic)            NSString        *cusLongitude;
@property(nonatomic)            NSString        *cusSKU;
@property(nonatomic)            NSString        *appID;
@property(nonatomic)            NSString        *cusAddress;
@property(nonatomic)            NSString        *cusCoupon;
@property(nonatomic)            NSString        *versionCode;
@property(nonatomic)            NSString        *apnsVerified;
@property(nonatomic)            NSString        *deviceID;
@property(nonatomic)            NSString        *deviceToken;
@property(nonatomic)            NSString        *methodType;
@property(nonatomic)            NSNumber        *recivedLeadID;

@property(nonatomic,strong)     NSMutableArray  *majorCategoryList;
@property(nonatomic,strong)     NSMutableArray  *majorSkuList;
@property(nonatomic,strong)     NSString        *selectedMajorSku;
@property(nonatomic,strong)     UIImage         *receivedBannerImg;

@property(nonatomic,strong)     NSString         *signUpEmail;
@property(nonatomic,strong)     NSString         *userID;

@property(nonatomic,strong)     NSString         *selectedCountry;
@property(nonatomic,strong)     NSString         *selectedState;
@property(nonatomic,strong)     NSString         *selectedCity;
@property(nonatomic,strong)     NSNumber         *selectedCountryId;
@property(nonatomic,strong)     NSNumber         *selectedStateId;
@property(nonatomic,strong)     NSNumber         *selectedCityId;


@property(nonatomic,strong)     NSMutableArray  *addedSkus;

@property(nonatomic)     BOOL  logInDone;
@property(nonatomic)     BOOL  signUpDone;
@property(nonatomic)     BOOL  OTPDone;
@property(nonatomic)     BOOL  addressAdded;
@property(nonatomic)     BOOL  addressListAvailable;
@property(nonatomic)     BOOL  resetPasswordSucess;
@property(nonatomic)     BOOL  userActivatedSucess;

@property(nonatomic)     BOOL  isUserMgmntApi;

@property(nonatomic)     BOOL  isLoginFromPickerView;




















/**
    singleton for shared manager
 */
+ (id)sharedManager;

@end
