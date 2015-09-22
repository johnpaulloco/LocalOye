//
//  LocalOyeConstants.h
//  GoSafeRadon
//
//  Created by John Paul Ranjith
//
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "LocalOyeSharedManager.h"
//Service Url

#define NEXMO_API_KEY               @"d4c75ae0"
#define NEXMO_API_SECRET            @"49569e8f"
#define NEXMO_BRAND                 @"LocalOye"
#define LOCALYTICS_API_KEY          @"6e00768e38a9ec634c71381-6e4254f8-5e01-11e5-0954-00deb82fd81f"



#define getLoginServiceURL                 @"http://ios.slocaloye.com/customerapp/login"



#define getCitiesServiceURL                 @"http://ios.slocaloye.com/customerapp/get_cities"
#define getCategoryServiceURL               @"http://ios.slocaloye.com/customerapp/get_categories?"
#define getQuestionsServiceURL              @"http://ios.slocaloye.com/customerapp/get_questions?"
#define getVersionCodeServiceURL            @"http://ios.slocaloye.com/customerapp/version_code"
#define getMyOrderServiceURL                @"http://ios.slocaloye.com/customerapp/booking_listings?"
#define getSubmitLeadServiceURL             @"http://ios.slocaloye.com/customerapp/submit_lead"
#define promoCodeServiceURL                 @"http://ios.slocaloye.com/customerapp/validate_promo_code"
#define getPanicAlertServiceURL             @"http://ios.slocaloye.com/customerapp/panic_alert?"
#define getQuoteListingServiceURL           @"http://ios.slocaloye.com/customerapp/quote_listing?"
#define getAPNSServiceURL                   @"http://ios.slocaloye.com/customerapp/create_endpoint_apn"
#define getOnlineMerchantQuoteServiceURL    @"http://ios.slocaloye.com/customerapp/online_merchant_quote?"
#define getMerchantProfileURL               @"http://ios.slocaloye.com/customerapp/merchant_profile?"

#define getSignUpURL                           @"http://ios.slocaloye.com/customerapp/customersignup"
#define getLoginURL                            @"http://ios.slocaloye.com/customerapp/customerlogin"
#define getLoginUsingMobileURL                 @"http://ios.slocaloye.com/customerapp/customerprofile?"
#define getCustomerProfileUsingUserIDURL                 @"http://ios.slocaloye.com/customerapp/customerprofile?"


#define getStateURL                             @"http://ios.slocaloye.com/customerapp/get_states?"
#define getCountryURL                           @"http://ios.slocaloye.com/customerapp/get_countries"
#define getCityMasterURL                        @"http://ios.slocaloye.com/customerapp/get_cities?"
#define getActivateUserURL                      @"http://ios.slocaloye.com/customerapp/activate_user?"
#define getCustomerLoginURL                     @"http://ios.slocaloye.com/customerapp/customerlogin"
#define getCustomeProfileURL                    @"http://ios.slocaloye.com/customerapp/customerprofile"
#define getResetPasswordURL                     @"http://ios.slocaloye.com/customerapp/customerprofile/reset_password"




#define APPDELEGATE_SHARED_MANAGER      ((AppDelegate *) [[UIApplication sharedApplication] delegate]) //Application singleton
#define SHARED_DELEGATE                 ((LocalOyeSharedManager*)[LocalOyeSharedManager sharedManager]) //Data Singleton

#define SyncServiceInterval             30.0

#define appBaseUrl                          @"http://ios.slocaloye.com/customerapp/"
#define imageBaseUrl                        @"http://localoye.com/xstatic/"


#define kSettings                           @"SETTINGS"

#define kLocalOyeFontLight                  @"GothamRounded-Light"
#define kLocalOyeFontMedium                 @"GothamRounded-Medium"
#define kLocalOyeFontBold                   @"GothamRounded-Bold"
#define kLocalOyeFontBook                   @"GothamRounded-Book"


#define kEmptyString                        @""
#define kYesString                          @"YES"
#define kNoString                           @"NO"
#define kAPNSAcceptedVal                    @"Create Endpoint Request Accepted"


#define kExoFont8                       [UIFont fontWithName:@"Exo-Light" size:8]
#define kExoFont9                       [UIFont fontWithName:@"Exo-Light" size:9]
#define kExoFont10                      [UIFont fontWithName:@"Exo-Light" size:10]
#define kExoFont11                      [UIFont fontWithName:@"Exo-Light" size:11]
#define kExoFont12                      [UIFont fontWithName:@"Exo-Light" size:12]
#define kExoFont13                      [UIFont fontWithName:@"Exo-Light" size:13]
#define kExoFont14                      [UIFont fontWithName:@"Exo-Light" size:14]
#define kExoFont15                      [UIFont fontWithName:@"Exo-Light" size:15]
#define kExoFont16                      [UIFont fontWithName:@"Exo-Light" size:16]
#define kExoFont17                      [UIFont fontWithName:@"Exo-Light" size:17]
#define kExoFont18                      [UIFont fontWithName:@"Exo-Light" size:18]
#define kExoFont19                      [UIFont fontWithName:@"Exo-Light" size:19]
#define kExoFont20                      [UIFont fontWithName:@"Exo-Light" size:20]
#define kExoFont24                      [UIFont fontWithName:@"Exo-Light" size:24]
#define kExoFont28                      [UIFont fontWithName:@"Exo-Light" size:28]

#define kExoRegularFont8                [UIFont fontWithName:@"Exo-Regular" size:8]
#define kExoRegularFont9                [UIFont fontWithName:@"Exo-Regular" size:9]
#define kExoRegularFont10               [UIFont fontWithName:@"Exo-Regular" size:10]
#define kExoRegularFont11               [UIFont fontWithName:@"Exo-Regular" size:11]
#define kExoRegularFont12               [UIFont fontWithName:@"Exo-Regular" size:12]
#define kExoRegularFont13               [UIFont fontWithName:@"Exo-Regular" size:13]
#define kExoRegularFont14               [UIFont fontWithName:@"Exo-Regular" size:14]
#define kExoRegularFont15               [UIFont fontWithName:@"Exo-Regular" size:15]
#define kExoRegularFont16               [UIFont fontWithName:@"Exo-Regular" size:16]
#define kExoRegularFont17               [UIFont fontWithName:@"Exo-Regular" size:17]
#define kExoRegularFont18               [UIFont fontWithName:@"Exo-Regular" size:18]
#define kExoRegularFont19               [UIFont fontWithName:@"Exo-Regular" size:19]
#define kExoRegularFont20               [UIFont fontWithName:@"Exo-Regular" size:20]
#define kExoRegularFont24               [UIFont fontWithName:@"Exo-Regular" size:24]
#define kExoRegularFont28               [UIFont fontWithName:@"Exo-Regular" size:28]


#define kLoginBtnColor                [UIColor colorWithRed:212.0f/255.0f green:162.0f/255.0f blue:14.0f/255.0f alpha:1]


#define kOfflineBGColor                [UIColor colorWithRed:44.0f/255.0f green:34.0f/255.0f blue:65.0f/255.0f alpha:1]
#define kLocalOyeOrangeColor                [UIColor colorWithRed:233.0f/255.0f green:77.0f/255.0f blue:27.0f/255.0f alpha:1]







#define kBlackColor                     [UIColor blackColor]
#define kGreenColor                     [UIColor greenColor]
#define IS_IPHONE_4                     ([[UIScreen mainScreen] bounds].size.height == 480.0)
#define IS_IPHONE_5                     ([[UIScreen mainScreen] bounds].size.height == 568.0)
#define IS_RETINA                       ([[UIScreen mainScreen] scale] == 2.0)

#define kXenonGreenColor                [UIColor colorWithRed:0.0f green:190.0f/255.0f blue:186.0f/255.0f alpha:1]
#define kXenonTextColor                 [UIColor colorWithRed:0.51 green:0.54 blue:0.56 alpha:1]
#define kXenonRedColor                  [UIColor colorWithRed:255.0f/255.0f green:110.0f/255.0f blue:102.0f/255.0f alpha:1]
#define kXenonFluorescentGreenColor     [UIColor colorWithRed:154.0f/255.0f green:204.0f/255.0f blue:104.0f/255.0f alpha:1]
#define kXenonYellowColor               [UIColor colorWithRed:0.98 green:0.78 blue:0.26 alpha:1]
#define kXenonGrayDarkColor             [UIColor colorWithRed:86.0f/255.0f green:86.0f/255.0f blue:86.0f/255.0f alpha:1]
#define kXenonGrayLightColor            [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1]
#define kXenonBackViewSelectedBlack     [UIColor colorWithRed:0.12 green:0.14 blue:0.14 alpha:1]
#define kXenonBackViewNonSelectedGray   [UIColor colorWithRed:0.21 green:0.22 blue:0.24 alpha:1]
#define BlackColor                      [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1]

#define GreenColorCurrentTrip           [UIColor colorWithRed:28.0f/255.0f green:91.0f/255.0f blue:88.0f/255.0f alpha:1]
#define YellowColorPreviousTrip         [UIColor colorWithRed:255.0f/255.0f green:253.0f/255.0f blue:43.0f/255.0f alpha:1]
#define GreenColorPreviousTrip          [UIColor colorWithRed:92.0f/255.0f green:164.0f/255.0f blue:34.0f/255.0f alpha:1]
#define RedColorPreviousTrip            [UIColor colorWithRed:235.0f/255.0f green:37.0f/255.0f blue:27.0f/255.0f alpha:1]
