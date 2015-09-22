//
//  RequestResposeHandler.h
//  RadonGoSafe
//
//  Created by abhijeet on 07/08/14.
//  Copyright (c) 2014 Xenon. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The RequestResposeHandler class is used to do the networrking job for appliation as fetching data from cloud.
 */

/**
    City search success call back Block to notify if getCity is Successful/Fail
 */
typedef void (^GetCitiesSuccess)(BOOL, NSString*);


/**
 Get Category success call back Block to notify if category search is Successful/Fail
 */
typedef void (^GetCategorySuccess)(BOOL, NSString*);

/**
 Get Category success call back Block to notify if category search is Successful/Fail
 */
typedef void (^GetQuestionsSuccess)(BOOL, NSString*);

typedef void (^SubmitLeadSuccess)(BOOL, NSString*);

typedef void (^ValidatePromoCodeSuccess)(BOOL, NSString*);

typedef void (^MyOrderListSuccess)(BOOL, NSString*);

typedef void (^QuoteListSuccess)(BOOL, NSString*);

typedef void (^OnlineQuoteListSuccess)(BOOL, NSString*);

typedef void (^MerchantProfileSuccess)(BOOL, NSString*);

typedef void (^PanicServiceSuccess)(BOOL, NSString*);

typedef void (^VersionCodeServiceSuccess)(BOOL, NSString*);

typedef void (^APNSServiceSuccess)(BOOL, NSString*);

typedef void (^GetLoginSuccess)(BOOL, NSString*);



typedef void (^getCountryServiceSuccess)(BOOL, NSString*);
typedef void (^getStateServiceSuccess)(BOOL, NSString*);
typedef void (^getCityServiceSuccess)(BOOL, NSString*);

typedef void (^signupServiceSuccess)(BOOL, NSString*);
typedef void (^loginServiceSuccess)(BOOL, NSString*);
typedef void (^resetPasswordServiceSuccess)(BOOL, NSString*);
typedef void (^activateLoginServiceSuccess)(BOOL, NSString*);
typedef void (^loginUsingMobileServiceSuccess)(BOOL, NSString*);
typedef void (^customerProfUsingUserServiceSuccess)(BOOL, NSString*);
typedef void (^sendCustomerProfUsingUserServiceSuccess)(BOOL, NSString*);


@interface RequestResposeHandler : NSObject{
    
    
}

/**
 Get City Request method which takes additional parameters and provide call back for login success or failure.
 @param nil
 @param citiesService - Success or failure callback
 @returns nothing;.
 */


/**
 Get Category Request method which takes additional parameters and provide call back for login success or failure.
 @param - nil
 
 @param categoryService - Success or failure callback
 @returns nothing;.
 */

//+ (void)PanicService :(NSString*)categoryName  :(PanicServiceSuccess)panicService;
//+ (void)GetMerchantProfileService :(NSString*)categoryName  :(MerchantProfileSuccess)merchantProfileService;
+ (void)GetMerchantProfileService :(NSString*)leadID :(NSString*)merchantID  :(MerchantProfileSuccess)merchantProfileService;
+ (void)GetQuotesListingService :(NSNumber*)leadID  :(QuoteListSuccess)quoteListService;
+ (void)GetMyOrderListingService :(NSString*)categoryName  :(MyOrderListSuccess)myOrderListService;
+ (void)ValidatePromoCodeService :(NSArray*)promoData  :(ValidatePromoCodeSuccess)promoCodeService;
+ (void)SubmitLeadService :(NSDictionary*)submitData  :(SubmitLeadSuccess)submitLeadService;
+ (void)GetQuestionsService :(NSString*)categoryName  :(GetQuestionsSuccess)categoriesService;
+ (void)GetCategoryService :(NSString*)cityID  :(GetCategorySuccess)categoriesService;
+ (void)GetCitiesService :(GetCitiesSuccess)citiesService;
+ (void)GetVersionCodeCheckService :(VersionCodeServiceSuccess)versionCodeService;
+ (void)SubmitPanicAlert :(NSNumber*)leadID  :(NSString*)escalationCause :(NSString*)rescheduledTo :(NSNumber*)rating:(PanicServiceSuccess)panicService;
+ (void)triggerApnsService :(id)apnsData :(APNSServiceSuccess)apnsService;
+ (void)GetRateCardQuestionsService :(NSString*)categoryName  :(GetQuestionsSuccess)categoriesService;

+ (void)GetOnlineMerchantQuotesListingService :(NSNumber*)leadID :(NSNumber*)merchantID  :(NSString*)categoryType:(OnlineQuoteListSuccess)onlineQuoteListService;


+ (void)GetLoginService :(GetLoginSuccess)loginService;
+ (void)GetCountriesService :(getCountryServiceSuccess)countryCodeService;
+ (void)GetStatesService :(getStateServiceSuccess)stateCodeService;
+ (void)GetMasterCitiService :(getCityServiceSuccess)cityCodeService;
+ (void)SignUpApiService :(NSDictionary*)submitData:(signupServiceSuccess)signUpService;
+ (void)LoginApiService :(NSDictionary*)submitData:(loginServiceSuccess)loginService;
+ (void)ResetPasswordApiService :(NSDictionary*)submitData:(resetPasswordServiceSuccess)resetPassService;
+ (void)LoginUsingMobileApiService :(NSString*)mobileNo:(loginUsingMobileServiceSuccess)loginService;
+ (void)GetCustomerProfileUsingUserIDService :(NSString*)userID:(NSString*)emailID:(customerProfUsingUserServiceSuccess)loginService;
@end
