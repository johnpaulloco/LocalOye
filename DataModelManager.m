//
//  DataModelManager.m
//  RadonGoSafe
//
//  Created by John Paul
//  Copyright (c) 2015 LocalOye. All rights reserved.
//

#import "DataModelManager.h"
#import "LocalOyeSharedManager.h"

#define ARC4RANDOM_MAX 0x100000000

@implementation DataModelManager


//Parse and update Login Datamodel, Login data model is stored in singleton because some value might be required in some future screens;
+(void)updateCitiDataModel:(id)loginObject withCitiUpdateSuccess:(CitiDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *array = (NSDictionary*)loginObject;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
    
    for(NSDictionary *dict in diction)
    {
        NSMutableDictionary *sendingD = [[NSMutableDictionary alloc] init];
        [sendingD setObject:[dict objectForKey:@"slug"] forKey:@"citiID"];
        [sendingD setObject:[dict objectForKey:@"name"] forKey:@"citiName"];
        [APPDELEGATE_SHARED_MANAGER insertCitiData:sendingD];
    }

    ldmSuccess(true);
}

//Parse and update Login Datamodel, Login data model is stored in singleton because some value might be required in some future screens;
+(void)updateCategoryDataModel:(id)loginObject withCategoryUpdateSuccess:(CategoryDMUpdateSuccess)ldmSuccess{

    NSDictionary *userDictionary = (NSDictionary *)loginObject;
    
    if (userDictionary) {
        
            [APPDELEGATE_SHARED_MANAGER insertMajorAndChildCategoryData:userDictionary];
    
    }
    
    ldmSuccess(true);
}

//Parse and update Login Datamodel, Login data model is stored in singleton because some value might be required in some future screens;
+(void)updateQuestionsDataModel:(id)loginObject withQuestionsUpdateSuccess:(QuestionsDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)loginObject;
    
    if (userDictionary) {
        
        [APPDELEGATE_SHARED_MANAGER insertRateCard:userDictionary];
    }
    
    ldmSuccess(true);
}


+(void)updateSubmitLeadDataModel:(id)responseObject withSubmitLeadUpdateSuccess:(SubmitLeadDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        NSDictionary *diction = (NSDictionary*)[userDictionary objectForKey:@"data"];
        
        for(NSDictionary *dict in diction){
            
            NSNumber *leadID = [dict objectForKey:@"lead_id"];
            SHARED_DELEGATE.recivedLeadID = leadID;
        }
        //[APPDELEGATE_SHARED_MANAGER insertSubmitLeadData:userDictionary:SHARED_DELEGATE.selectedServiceName];
    }
    
    ldmSuccess(true);
}

+(void)updatePromoCodeDataModel:(id)responseObject withPromoCodeUpdateSuccess:(PromoCodeDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        [APPDELEGATE_SHARED_MANAGER insertSubmitLeadData:userDictionary:SHARED_DELEGATE.selectedServiceName];
        
    }
    
    ldmSuccess(true);
}

+(void)updateMyOrderListDataModel:(id)responseObject withMyOrderUpdateSuccess:(MyOrderListDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        [APPDELEGATE_SHARED_MANAGER insertMyOrderListData:userDictionary:SHARED_DELEGATE.selectedServiceName];
        
    }
    
    ldmSuccess(true);
}

+(void)updateQuoteListDataModel:(id)responseObject withQuoteUpdateSuccess:(QuoteListDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        [APPDELEGATE_SHARED_MANAGER insertQuoteListData:userDictionary:SHARED_DELEGATE.selectedServiceName];
        
    }
    
    ldmSuccess(true);
}

+(void)updateOnlineQuoteListDataModel:(id)responseObject withQuoteUpdateSuccess:(OnlineQuoteListDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        [APPDELEGATE_SHARED_MANAGER insertOnlineQuoteListData:userDictionary:SHARED_DELEGATE.selectedServiceName];
        
    }
    
    ldmSuccess(true);
}

+(void)updateMerchantProfileDataModel:(id)responseObject withMerchantProfileSuccess:(MerchantProfileDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
    
        [APPDELEGATE_SHARED_MANAGER insertMerchantProfileData:userDictionary:SHARED_DELEGATE.selectedServiceName];
        
    }
    
    ldmSuccess(true);
}

+(void)updatePanicServiceDataModel:(id)responseObject withPanicServiceSuccess:(PanicServiceDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        [APPDELEGATE_SHARED_MANAGER insertPanicServiceData:userDictionary:SHARED_DELEGATE.selectedServiceName];
        
    }
    
    ldmSuccess(true);
}

+(void)updateCountryDataModel:(id)responseObject withCountrySuccess:(CountryDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        [APPDELEGATE_SHARED_MANAGER insertCountryData:userDictionary];
        
    }
    
    ldmSuccess(true);
}

+(void)updateStateDataModel:(id)responseObject withStateSuccess:(StateDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        [APPDELEGATE_SHARED_MANAGER insertStateData:userDictionary];
        
    }
    
    ldmSuccess(true);
}

+(void)updateCityDataModel:(id)responseObject withCitySuccess:(CityDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        [APPDELEGATE_SHARED_MANAGER insertCitiMasterData:userDictionary];
        
    }
    
    ldmSuccess(true);
}

+(void)updateSignUpDataModel:(id)responseObject withSignUpSuccess:(SigUpDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        //[APPDELEGATE_SHARED_MANAGER insertSignUpDataUserId:userDictionary:SHARED_DELEGATE.signUpEmail];
        
    }
    
    ldmSuccess(true);
}

+(void)updateLoginDataModel:(id)responseObject withLoginSuccess:(LoginDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        [APPDELEGATE_SHARED_MANAGER insertSignUpDataUserId:userDictionary:SHARED_DELEGATE.signUpEmail];
        
    }
    
    ldmSuccess(true);
}

+(void)updateCustomerProfileDataModel:(id)responseObject withProfileSuccess:(CustomerProfileDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        [APPDELEGATE_SHARED_MANAGER insertSignUpData:userDictionary:SHARED_DELEGATE.signUpEmail];
        
    }
    
    ldmSuccess(true);
}

+(void)updateResetPassDataModel:(id)responseObject withResetSuccess:(ResetPassDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        NSDictionary *array = (NSDictionary*)userDictionary;
        NSDictionary *diction = (NSDictionary*)[array objectForKey:@"response"];
        
        for(NSDictionary *dict in diction){
            NSString *messageStr = [dict objectForKey:@"message"];
            if([messageStr isEqualToString:@"Password updated successfully."])
                SHARED_DELEGATE.resetPasswordSucess = YES;
            else
                SHARED_DELEGATE.resetPasswordSucess = NO;
        }

        //[APPDELEGATE_SHARED_MANAGER insertSignUpDataUserId:userDictionary:SHARED_DELEGATE.signUpEmail];
        
    }
    
    ldmSuccess(true);
}

+(void)updateActiveDataModel:(id)responseObject withActiveUserSuccess:(ActiveUserDMUpdateSuccess)ldmSuccess{
    
    NSDictionary *userDictionary = (NSDictionary *)responseObject;
    
    if (userDictionary) {
        
        NSDictionary *array = (NSDictionary*)userDictionary;
        NSDictionary *diction = (NSDictionary*)[array objectForKey:@"response"];
        
        for(NSDictionary *dict in diction){
            NSString *messageStr = [dict objectForKey:@"message"];
            if([messageStr isEqualToString:@"Profile activated successfully."])
                SHARED_DELEGATE.userActivatedSucess = YES;
            else
                SHARED_DELEGATE.userActivatedSucess = NO;
        }
        
        //[APPDELEGATE_SHARED_MANAGER insertSignUpDataUserId:userDictionary:SHARED_DELEGATE.signUpEmail];
        
    }
    
    ldmSuccess(true);
}


//parse and update DashBoard datamodel, stored in singleton because some value might be required in some future screens;


@end
