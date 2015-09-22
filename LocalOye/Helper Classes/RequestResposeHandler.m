    //
//  RequestResposeHandler.m
//  RadonGoSafe
//
//  Created by abhijeet on 07/08/14.
//  Copyright (c) 2014 Xenon. All rights reserved.
//

#import "RequestResposeHandler.h"
#import "AFHTTPRequestOperationManager.h"
#import "LocalOyeConstants.h"
//#import "NSTimer+Blocks.h"
#import "DataModelManager.h"

#import "AFJSONRPCClient.h"
#import "AppDelegate.h"

@implementation RequestResposeHandler

+ (void)GetLoginService :(GetLoginSuccess)loginService
{
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:getLoginServiceURL]];
    
    SHARED_DELEGATE.methodType = @"POST";
    // Invocation
    [client invokeMethod:@"getLogin"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //NSLog(@"Success");
         if (responseObject) {
             
             NSLog(@"responseObject %@",responseObject);
             
             //citiesService(true,nil);
             
             [DataModelManager updateCitiDataModel:responseObject withCitiUpdateSuccess:^(BOOL dm){
                 
                 //if ([responseObject objectForKey:@"result"])
                 {
                     if (dm)
                         loginService(true,nil);
                 }
                 //                 else
                 //                 {
                 //                     citiesService(false,[responseObject objectForKey:@"error"]);
                 //                 }
             }];
         }
         else{
             loginService(false,@"Unable to connect server");
         }
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         loginService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
}
//Search Citi service
+ (void)GetCitiesService :(GetCitiesSuccess)citiesService{
    
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:getCitiesServiceURL]];
    
    SHARED_DELEGATE.methodType = @"GET";
    // Invocation
    [client invokeMethod:@"getCities"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //NSLog(@"Success");
         if (responseObject) {
             
             NSLog(@"responseObject %@",responseObject);
             
             //citiesService(true,nil);
             
             [DataModelManager updateCitiDataModel:responseObject withCitiUpdateSuccess:^(BOOL dm){
                 
                 //if ([responseObject objectForKey:@"result"])
                 {
                     if (dm)
                         citiesService(true,nil);
                 }
                 //                 else
                 //                 {
                 //                     citiesService(false,[responseObject objectForKey:@"error"]);
                 //                 }
             }];
         }
         else{
             citiesService(false,@"Unable to connect server");
         }
         
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         citiesService(false,@"Unable to connect server");
         //NSLog(@"Failure");
        }];
}

//Search Category service
+ (void)GetCategoryService :(NSString*)cityID  :(GetCategorySuccess)categoriesService{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",getCategoryServiceURL,@"city=",cityID];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"GET";
    // Invocation
    [client invokeMethod:@"getCategories"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //NSLog(@"Success");
         if (responseObject) {
             
             NSLog(@"responseObject %@",responseObject);
             
             categoriesService(true,nil);
             
             [DataModelManager updateCategoryDataModel:responseObject withCategoryUpdateSuccess:^(BOOL dm){
                 
                 
                 //if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"])
                 //{
                 if (dm)
                     categoriesService(true,nil);
                 //                 }
                 //                 else
                 //                 {
                 //                     citiesService(false,[responseObject objectForKey:@"error"]);
                 //                 }
             }];
         }
         else{
             categoriesService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         categoriesService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
    
    
}

//Search Category service
+ (void)GetQuestionsService :(NSString*)categoryName  :(GetQuestionsSuccess)categoriesService{
    
    //http://android.localoye.com/customerapp/questions?category=beauty-services-at-home
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",getQuestionsServiceURL,@"city=",SHARED_DELEGATE.selectedCityID,@"&",@"category=",categoryName];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"GET";
    // Invocation
    [client invokeMethod:@"questions"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //NSLog(@"Success");
         if (responseObject) {
             
             NSLog(@"responseObject %@",responseObject);
             
             categoriesService(true,nil);
             
             [DataModelManager updateQuestionsDataModel:responseObject withQuestionsUpdateSuccess:^(BOOL dm){
                 
                 //if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"])
                 //{
                 if (dm)
                     categoriesService(true,nil);
                 //                 }
                 //                 else
                 //                 {
                 //                     citiesService(false,[responseObject objectForKey:@"error"]);
                 //                 }
             }];
         }
         else{
             categoriesService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         categoriesService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
    
    
}

+ (void)GetRateCardQuestionsService :(NSString*)categoryName  :(GetQuestionsSuccess)categoriesService{
    
//    id responseObject = [APPDELEGATE_SHARED_MANAGER readJsonFile:@"RateCardNew"];
//    [DataModelManager updateQuestionsDataModel:responseObject withQuestionsUpdateSuccess:^(BOOL dm){
//    
//            if (dm)
//                categoriesService(true,nil);
//        }];

    
    //http://android.localoye.com/customerapp/questions?category=beauty-services-at-home
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",getQuestionsServiceURL,@"city=",SHARED_DELEGATE.selectedCityID,@"&",@"category=",categoryName];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"GET";
    // Invocation
    [client invokeMethod:@"questions"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //NSLog(@"Success");
         if (responseObject) {
             
             NSLog(@"responseObject %@",responseObject);
             
             categoriesService(true,nil);
             
             [DataModelManager updateQuestionsDataModel:responseObject withQuestionsUpdateSuccess:^(BOOL dm){
                 
                 //if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"])
                 //{
                 if (dm)
                     categoriesService(true,nil);
                 //                 }
                 //                 else
                 //                 {
                 //                     citiesService(false,[responseObject objectForKey:@"error"]);
                 //                 }
             }];
         }
         else{
             categoriesService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         categoriesService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
}

+ (void)SubmitLeadService :(NSDictionary*)submitData  :(SubmitLeadSuccess)submitLeadService{
    
    //http://ios.localoye.com/customerapp/submit_lead
    
    NSString *categoryName;
    NSString *urlStr = [NSString stringWithFormat:@"%@",getSubmitLeadServiceURL];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"POST";
    
    //NSDictionary *dict = [submitData objectAtIndex:0];
    // Invocation
    [client invokeMethod:@"submit_lead"
                    withParameters:submitData
                    success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             NSLog(@"responseObject %@",responseObject);
             
             submitLeadService(true,nil);
             
             [DataModelManager updateSubmitLeadDataModel:responseObject withSubmitLeadUpdateSuccess:^(BOOL dm){
                 
                 //if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"])
                 //{
                 if (dm)
                     submitLeadService(true,nil);
                 //}
                 //else
                 //{
                 //citiesService(false,[responseObject objectForKey:@"error"]);
                 //}
             }];
         }
         else{
             submitLeadService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         submitLeadService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
}

+ (void)ValidatePromoCodeService :(NSArray*)promoData  :(ValidatePromoCodeSuccess)promoCodeService{
    
    //http://ios.localoye.com/customerapp/validate_promo_code
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",promoCodeServiceURL];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"POST";
    // Invocation
    [client invokeMethod:@"validate_promo_code"
                withParameters:[promoData objectAtIndex:0]
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             NSLog(@"responseObject %@",responseObject);
             
             NSDictionary *array = (NSDictionary*)responseObject;
             NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
             
             
             //for(int i=0;i<[array count];i++){
             
             for(NSDictionary *dict in diction){
                 
                 NSNumber *valid = [dict objectForKey:@"valid"];
                 
                 if([valid isEqualToNumber:[NSNumber numberWithInt:0]])
                        promoCodeService(false,nil);
                 else
                     promoCodeService(true,nil);
                 
             }
             

             
             [DataModelManager updatePromoCodeDataModel:responseObject withPromoCodeUpdateSuccess:^(BOOL dm){
                 
                 //if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"])
                 //{
                 if (dm)
                     promoCodeService(true,nil);
                 //}
                 //else
                 //{
                 //citiesService(false,[responseObject objectForKey:@"error"]);
                 //}
             }];
         }
         else{
             promoCodeService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         promoCodeService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
    
    
}

+ (void)GetMyOrderListingService :(NSString*)categoryName  :(MyOrderListSuccess)myOrderListService{
    
//    id responseObject = [APPDELEGATE_SHARED_MANAGER readJsonFile:@"MyOrderJson"];
//    [DataModelManager updateMyOrderListDataModel:responseObject withMyOrderUpdateSuccess:^(BOOL dm){
//        
//        if (dm)
//            myOrderListService(true,nil);
//    }];
    
    //http://ios.localoye.com/customerapp/booking_listings
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",getMyOrderServiceURL,@"user_id=",SHARED_DELEGATE.userID];
    
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"GET";
    
    // Invocation
    [client invokeMethod:@"booking_listings"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             NSLog(@"responseObject %@",responseObject);
             
             myOrderListService(true,nil);
             
             [DataModelManager updateMyOrderListDataModel:responseObject withMyOrderUpdateSuccess:^(BOOL dm){
                 
                 //if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"])
                 //{
                 if (dm)
                     myOrderListService(true,nil);
                 //}
                 //else
                 //{
                 //citiesService(false,[responseObject objectForKey:@"error"]);
                 //}
             }];
         }
         else{
             myOrderListService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         myOrderListService(false,@"Unable to connect server");
         
     }];
    
    
}

+ (void)GetQuotesListingService :(NSNumber*)leadID  :(QuoteListSuccess)quoteListService{
    
    //http://ios.localoye.com/customerapp/quote_listing
    
//    id responseObject = [APPDELEGATE_SHARED_MANAGER readJsonFile:@"QuoteListJson"];
//    [DataModelManager updateQuoteListDataModel:responseObject withQuoteUpdateSuccess:^(BOOL dm){
//        
//        if (dm)
//            quoteListService(true,nil);
//    }];
//    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",getQuoteListingServiceURL,@"lead_id=",leadID];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"GET";
    // Invocation
    [client invokeMethod:@"quote_listing"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             NSLog(@"responseObject %@",responseObject);
             
             quoteListService(true,nil);
                 
             [DataModelManager updateQuoteListDataModel:responseObject withQuoteUpdateSuccess:^(BOOL dm){
                 
                 //if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"])
                 //{
                 if (dm)
                     quoteListService(true,nil);
                 //}
                 //else
                 //{
                 //citiesService(false,[responseObject objectForKey:@"error"]);
                 //}
             }];
         }
         else{
             quoteListService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         quoteListService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
    
    
}


+ (void)GetOnlineMerchantQuotesListingService :(NSNumber*)leadID :(NSNumber*)merchantID  :(NSString*)categoryType:(OnlineQuoteListSuccess)onlineQuoteListService{
    
    //http://ios.localoye.com/customerapp/online_merchant_quote
    
    
//    id responseObject = [APPDELEGATE_SHARED_MANAGER readJsonFile:@"OnlineMerchantQuoteJson"];
//    [DataModelManager updateOnlineQuoteListDataModel:responseObject withQuoteUpdateSuccess:^(BOOL dm){
//        
//        if (dm)
//            onlineQuoteListService(true,nil);
//    }];
//    
    NSString *urlStr;
    if([categoryType isEqualToString:@"Online"])
    {
        urlStr = [NSString stringWithFormat:@"%@%@%@",getOnlineMerchantQuoteServiceURL,@"lead_id=",leadID];
        //urlStr = [NSString stringWithFormat:@"%@%@",getOnlineMerchantQuoteServiceURL,@"lead_id=14399725510229"];
        
    }
    else{
        urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",getMerchantProfileURL,@"lead_id=",leadID,@"&",@"merchant_id=",merchantID];
    }

    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"GET";
    // Invocation
    [client invokeMethod:@"online_merchant_quote"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             NSLog(@"responseObject %@",responseObject);
             
             onlineQuoteListService(true,nil);
             
             [DataModelManager updateOnlineQuoteListDataModel:responseObject withQuoteUpdateSuccess:^(BOOL dm){
                 
                 //if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"])
                 //{
                 if (dm)
                     onlineQuoteListService(true,nil);
                 //}
                 //else
                 //{
                 //citiesService(false,[responseObject objectForKey:@"error"]);
                 //}
             }];
         }
         else{
             onlineQuoteListService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         onlineQuoteListService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
    
    
}

+ (void)GetMerchantProfileService :(NSString*)leadID :(NSString*)merchantID  :(MerchantProfileSuccess)merchantProfileService{
    
    //http://ios.localoye.com/customerapp/merchant_profile
    
//    id responseObject = [APPDELEGATE_SHARED_MANAGER readJsonFile:@"MerchantProfileJson"];
//    [DataModelManager updateMerchantProfileDataModel:responseObject withMerchantProfileSuccess:^(BOOL dm){
//        
//        if (dm)
//            merchantProfileService(true,nil);
//    }];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",getMerchantProfileURL,@"lead_id=",leadID,@"&",@"merchant_id=",merchantID];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];

    SHARED_DELEGATE.methodType = @"GET";
    // Invocation
    [client invokeMethod:@"merchant_profile"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             NSLog(@"responseObject %@",responseObject);
             
             merchantProfileService(true,nil);
             
             [DataModelManager updateMerchantProfileDataModel:responseObject withMerchantProfileSuccess:^(BOOL dm){
                 
                 //if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"])
                 //{
                 if (dm)
                     merchantProfileService(true,nil);
                 //}
                 //else
                 //{
                 //citiesService(false,[responseObject objectForKey:@"error"]);
                 //}
             }];
         }
         else{
             merchantProfileService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         merchantProfileService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
}

+ (void)SubmitPanicAlert :(NSNumber*)leadID  :(NSString*)escalationCause :(NSString*)rescheduledTo :(NSNumber*)rating:(PanicServiceSuccess)panicService{
    
    //http://ios.localoye.com/customerapp/panic_alert?lead_id=14402493436740&escalation_cause=partner_not_arrived&rescheduled_to=NULL
    
    NSString *urlStr;
    if([escalationCause isEqualToString:@"user_rating"]){
        NSLog(@"urlStr1 %@",urlStr);
        urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",getPanicAlertServiceURL,@"lead_id=",leadID,@"&",@"escalation_cause=",escalationCause,@"&",@"rating=",rating];
    }
    else{
        urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",getPanicAlertServiceURL,@"lead_id=",leadID,@"&",@"escalation_cause=",escalationCause,@"&",@"rescheduled_to=",rescheduledTo];
         NSLog(@"urlStr2 %@",urlStr);
    }
    //NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",getQuestionsServiceURL,@"city=",SHARED_DELEGATE.selectedCityID,@"&",@"category=",categoryName];
    
    
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"GET";
    // Invocation
    [client invokeMethod:@"panic_alert"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             NSLog(@"responseObject %@",responseObject);
             
             NSDictionary *array = (NSDictionary*)responseObject;
             NSArray *receivedObjStr = [array objectForKey:@"data"];
             
             if([receivedObjStr count]>0)
             {
                 if([[receivedObjStr objectAtIndex:0] isEqualToString:@"Panic alerts sent"])
                     panicService(true,nil);
                 else
                     panicService(false,nil);
             }else{
                panicService(false,nil);
             }
//             [DataModelManager updatePanicServiceDataModel:responseObject withPanicServiceSuccess:^(BOOL dm){
//                 
//                 //if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"])
//                 //{
//                 if (dm)
//                     panicService(true,nil);
//                 //}
//                 //else
//                 //{
//                 //citiesService(false,[responseObject objectForKey:@"error"]);
//                 //}
//             }];
         }
         else{
             panicService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         panicService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
}


+ (void)GetVersionCodeCheckService :(VersionCodeServiceSuccess)versionCodeService{
    
    //http://ios.localoye.com/customerapp/version_code
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",getVersionCodeServiceURL];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"GET";
    // Invocation
    [client invokeMethod:@"version_code"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             NSDictionary *array = (NSDictionary*)responseObject;
             NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
             
             //for(int i=0;i<[array count];i++){
             
             for(NSString *versionCode in diction){
                 SHARED_DELEGATE.versionCode = versionCode;
                 versionCodeService(true,nil);
             }
             NSLog(@"responseObject %@",responseObject);
         }
         else{
             versionCodeService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         versionCodeService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
}

+ (void)triggerApnsService :(id)apnsData :(APNSServiceSuccess)apnsService
{
    NSString *urlStr = [NSString stringWithFormat:@"%@",getAPNSServiceURL];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"POST";
    // Invocation
    [client invokeMethod:@"create_endpoint_apn"
                withParameters:apnsData
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
//             UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"APNS Accepted"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//             [wsAlert show];
//             
             NSLog(@"responseObject %@",responseObject);
             NSDictionary *array = (NSDictionary*)responseObject;
             NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
             
             //for(int i=0;i<[array count];i++){
             
             for(NSString *data in diction){
                 SHARED_DELEGATE.apnsVerified = data;
                 if([SHARED_DELEGATE.apnsVerified isEqualToString:kAPNSAcceptedVal])
                    apnsService(true,nil);
                 else
                    apnsService(false,nil);
             }
         }
         else{
            
             
             apnsService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error %@",error);
         apnsService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
}


+ (void)GetCountriesService :(getCountryServiceSuccess)countryCodeService{
    
    id responseObject = [APPDELEGATE_SHARED_MANAGER readJsonFile:@"getCountry"];
    [DataModelManager updateCountryDataModel:responseObject withCountrySuccess:^(BOOL dm){
        
        if (dm)
            countryCodeService(true,nil);
    }];

    
//    NSString *urlStr = [NSString stringWithFormat:@"%@",getCountryURL];
//    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
//    
//    SHARED_DELEGATE.methodType = @"GET";
//    // Invocation
//    [client invokeMethod:@"get_countries"
//                 success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         if (responseObject) {
//             
//             
//             [DataModelManager updateCountryDataModel:responseObject withCountrySuccess:^(BOOL dm){
//                 
//                 if (dm)
//                     countryCodeService(true,nil);
//                
//             }];
//             
//         }
//         else{
//             countryCodeService(false,@"Unable to connect server");
//         }
//         
//     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         
//         countryCodeService(false,@"Unable to connect server");
//         //NSLog(@"Failure");
//     }];
}

+ (void)GetStatesService :(getStateServiceSuccess)stateCodeService{
    
    id responseObject = [APPDELEGATE_SHARED_MANAGER readJsonFile:@"getStates"];
    [DataModelManager updateStateDataModel:responseObject withStateSuccess:^(BOOL dm){
        
        if (dm)
            stateCodeService(true,nil);
    }];
    
    
//        NSString *urlStr = [NSString stringWithFormat:@"%@",getCountryURL];
//        AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
//    
//        SHARED_DELEGATE.methodType = @"GET";
//        // Invocation
//        [client invokeMethod:@"get_countries"
//                     success:^(AFHTTPRequestOperation *operation, id responseObject)
//         {
//             if (responseObject) {
//    
//    
//                 [DataModelManager updateCountryDataModel:responseObject withCountrySuccess:^(BOOL dm){
//    
//                     if (dm)
//                         stateCodeService(true,nil);
//    
//                 }];
//    
//             }
//             else{
//                 stateCodeService(false,@"Unable to connect server");
//             }
//    
//         }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    
//             stateCodeService(false,@"Unable to connect server");
//             //NSLog(@"Failure");
//         }];
}

+ (void)GetMasterCitiService :(getCityServiceSuccess)cityCodeService{
    
    id responseObject = [APPDELEGATE_SHARED_MANAGER readJsonFile:@"getCitiesMaster"];
    [DataModelManager updateCityDataModel:responseObject withCitySuccess:^(BOOL dm){
        
        if (dm)
            cityCodeService(true,nil);
    }];
    
    
    //    NSString *urlStr = [NSString stringWithFormat:@"%@",getCountryURL];
    //    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    //
    //    SHARED_DELEGATE.methodType = @"GET";
    //    // Invocation
    //    [client invokeMethod:@"get_countries"
    //                 success:^(AFHTTPRequestOperation *operation, id responseObject)
    //     {
    //         if (responseObject) {
    //
    //
    //             [DataModelManager updateCountryDataModel:responseObject withCountrySuccess:^(BOOL dm){
    //
    //                 if (dm)
    //                     countryCodeService(true,nil);
    //
    //             }];
    //
    //         }
    //         else{
    //             countryCodeService(false,@"Unable to connect server");
    //         }
    //
    //     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //
    //         countryCodeService(false,@"Unable to connect server");
    //         //NSLog(@"Failure");
    //     }];
}

+ (void)SignUpApiService :(NSDictionary*)submitData:(signupServiceSuccess)signUpService{
    
    
//    id responseObject = [APPDELEGATE_SHARED_MANAGER readJsonFile:@"SignUpResponse"];
//    [DataModelManager updateSignUpDataModel:responseObject withSignUpSuccess:^(BOOL dm){
//        
//        if (dm)
//            signUpService(true,nil);
//    }];
//    
    
        NSString *urlStr = [NSString stringWithFormat:@"%@",getSignUpURL];
        AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
        SHARED_DELEGATE.methodType = @"POST";
        // Invocation
        [client invokeMethod:@"customersignup"
         withParameters:submitData
                     success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if (responseObject) {
                 
                 NSLog(@"responseObject %@",responseObject);
                 NSDictionary *userDictionary = (NSDictionary *)responseObject;
   
                NSDictionary *dict =[userDictionary objectForKey:@"response_header"];
                 NSString *dictresponse =[userDictionary objectForKey:@"response"];
                 NSNumber *code = [dict objectForKey:@"code"];
                 if([code isEqualToNumber:[NSNumber numberWithInt:1]])
                 {
                     
                     signUpService(false,dictresponse);
                 }
                 else{
                     
                     
                     [DataModelManager updateSignUpDataModel:responseObject withSignUpSuccess:^(BOOL dm){
                         
                         if (dm)
                             signUpService(true,nil);
                         
                     }];

                 }
                 
    
             }
             else{
                 signUpService(false,@"Unable to connect server");
             }
    
         }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
             signUpService(false,@"Unable to connect server");
             //NSLog(@"Failure");
         }];
}

+ (void)LoginApiService :(NSDictionary*)submitData:(loginServiceSuccess)loginService{
    
    
//    id responseObject = [APPDELEGATE_SHARED_MANAGER readJsonFile:@"LoginResponse"];
//    [DataModelManager updateLoginDataModel:responseObject withLoginSuccess:^(BOOL dm){
//        
//        if (dm)
//            loginService(true,nil);
//    }];
//    
//    
    NSString *urlStr = [NSString stringWithFormat:@"%@",getLoginURL];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"POST";
    // Invocation
    [client invokeMethod:@"customerlogin"
          withParameters:submitData
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             NSLog(@"Login responseObject %@",responseObject);
             NSDictionary *userDictionary = (NSDictionary *)responseObject;
             
             NSDictionary *dict =[userDictionary objectForKey:@"response_header"];
             NSDictionary *dictresponse =[userDictionary objectForKey:@"response"];
             NSString *errorStr =[dictresponse objectForKey:@"message"];
             NSNumber *code = [dict objectForKey:@"code"];
             if([code isEqualToNumber:[NSNumber numberWithInt:1]])
             {
                 loginService(false,errorStr);
             }
             else{
                 [DataModelManager updateLoginDataModel:responseObject withLoginSuccess:^(BOOL dm){
                 
                 if (dm)
                     loginService(true,nil);
             
                 }];
             }
         }
         else{
             loginService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         loginService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
}

+ (void)ResetPasswordApiService :(NSDictionary*)submitData:(resetPasswordServiceSuccess)resetPassService{
    
    
    id responseObject = [APPDELEGATE_SHARED_MANAGER readJsonFile:@"LoginResponse"];
    [DataModelManager updateLoginDataModel:responseObject withLoginSuccess:^(BOOL dm){
        
        if (dm)
            resetPassService(true,nil);
    }];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",getResetPasswordURL];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"POST";
    // Invocation
    [client invokeMethod:@"customerlogin"
          withParameters:submitData
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             
             [DataModelManager updateResetPassDataModel:responseObject withResetSuccess:^(BOOL dm){
                 
                 if (dm)
                     resetPassService(true,nil);
                 
             }];
             
         }
         else{
             resetPassService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         resetPassService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
}

+ (void)ActivateLoginApiService :(NSString*)user_id:(NSString*)email:(activateLoginServiceSuccess)activateLoginService{
    
    
    id responseObject = [APPDELEGATE_SHARED_MANAGER readJsonFile:@"getActiveUser"];
    [DataModelManager updateActiveDataModel:responseObject withActiveUserSuccess:^(BOOL dm){
        
        if (dm)
            activateLoginService(true,nil);
    }];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@&%@%@&%@%d",getActivateUserURL,@"user_id",user_id,@"email_id",email,@"active=",TRUE];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"POST";
    // Invocation
    [client invokeMethod:@"activate_user"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             
             [DataModelManager updateActiveDataModel:responseObject withActiveUserSuccess:^(BOOL dm){
                 
                 if (dm)
                     activateLoginService(true,nil);
                 
             }];
             
         }
         else{
             activateLoginService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         activateLoginService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
}

//http://android.dlocaloye.com/customerapp/customerprofile?mobile_number=9972007791

+ (void)LoginUsingMobileApiService :(NSString*)mobileNo:(loginUsingMobileServiceSuccess)loginService{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",getLoginUsingMobileURL,@"mobile_number=",mobileNo];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"GET";
    // Invocation
    [client invokeMethod:@"customerprofile"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             NSDictionary *userDictionary = (NSDictionary *)responseObject;
             
             NSDictionary *dict =[userDictionary objectForKey:@"response_header"];
             NSString *dictresponse =[userDictionary objectForKey:@"response"];
             NSNumber *code = [dict objectForKey:@"code"];
             if([code isEqualToNumber:[NSNumber numberWithInt:1]])
             {
                 
                 loginService(false,dictresponse);
             }
             else{
                 NSLog(@"success %@",responseObject);
//                 [DataModelManager updateLoginDataModel:responseObject withLoginSuccess:^(BOOL dm){
//                     
//                     if (dm)
//                         loginService(true,nil);
//                     
//                 }];
                 loginService(false,dictresponse);
             }
         }
         else{
             loginService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         loginService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
}

+ (void)GetCustomerProfileUsingUserIDService :(NSString*)userID:(NSString*)emaiID:(customerProfUsingUserServiceSuccess)profService{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",getCustomerProfileUsingUserIDURL,@"user_id=",userID,@"&",@"email_id=",emaiID];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"GET";
    // Invocation
    [client invokeMethod:@"customerprofile"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             NSDictionary *userDictionary = (NSDictionary *)responseObject;
             
             NSDictionary *dict =[userDictionary objectForKey:@"response_header"];
             NSString *dictresponse =[userDictionary objectForKey:@"response"];
             NSNumber *code = [dict objectForKey:@"code"];
             if([code isEqualToNumber:[NSNumber numberWithInt:1]])
             {
                 
                 profService(false,dictresponse);
             }
             else{
                 NSLog(@"success %@",responseObject);
                [DataModelManager updateCustomerProfileDataModel:responseObject withProfileSuccess:^(BOOL dm){
                 
                        if (dm)
                            profService(true,nil);
            
                }];
                 profService(true,dictresponse);
             }
         }
         else{
             profService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         profService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
}

+ (void)postCustomerProfile :(NSString*)userID:(NSString*)emaiID:(sendCustomerProfUsingUserServiceSuccess)customerProfSendService{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",getCustomerProfileUsingUserIDURL,@"user_id=",userID,@"&",@"email_id=",emaiID];
    AFJSONRPCClient *client = [AFJSONRPCClient clientWithEndpointURL:[NSURL URLWithString:urlStr]];
    
    SHARED_DELEGATE.methodType = @"GET";
    // Invocation
    [client invokeMethod:@"customerprofile"
                 success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject) {
             
             NSDictionary *userDictionary = (NSDictionary *)responseObject;
             
             NSDictionary *dict =[userDictionary objectForKey:@"response_header"];
             NSString *dictresponse =[userDictionary objectForKey:@"response"];
             NSNumber *code = [dict objectForKey:@"code"];
             if([code isEqualToNumber:[NSNumber numberWithInt:1]])
             {
                 
                 customerProfSendService(false,dictresponse);
             }
             else{
                 NSLog(@"success %@",responseObject);
                 [DataModelManager updateCustomerProfileDataModel:responseObject withProfileSuccess:^(BOOL dm){
                     
                     if (dm)
                         customerProfSendService(true,nil);
                     
                 }];
                 customerProfSendService(true,dictresponse);
             }
         }
         else{
             customerProfSendService(false,@"Unable to connect server");
         }
         
     }   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         customerProfSendService(false,@"Unable to connect server");
         //NSLog(@"Failure");
     }];
}

@end
