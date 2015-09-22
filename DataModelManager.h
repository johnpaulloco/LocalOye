//
//  DataModelManager.h
//  RadonGoSafe
//
//  Created by John Paul
//  
//


//This class is to update all type of Data models with the service responce we receive.

#import <Foundation/Foundation.h>

/**
 Citi datamodel update success and finishcall back Block
 */
typedef void (^CitiDMUpdateSuccess) (BOOL);


/**
 Category datamodel update success and finishcall back Block
 */
typedef void (^CategoryDMUpdateSuccess) (BOOL);


/**
 Category datamodel update success and finishcall back Block
 */
typedef void (^QuestionsDMUpdateSuccess) (BOOL);
typedef void (^SubmitLeadDMUpdateSuccess) (BOOL);
typedef void (^PromoCodeDMUpdateSuccess) (BOOL);
typedef void (^MyOrderListDMUpdateSuccess) (BOOL);
typedef void (^QuoteListDMUpdateSuccess) (BOOL);
typedef void (^OnlineQuoteListDMUpdateSuccess) (BOOL);
typedef void (^MerchantProfileDMUpdateSuccess) (BOOL);
typedef void (^PanicServiceDMUpdateSuccess) (BOOL);

typedef void (^CountryDMUpdateSuccess) (BOOL);
typedef void (^StateDMUpdateSuccess) (BOOL);
typedef void (^CityDMUpdateSuccess) (BOOL);
typedef void (^SigUpDMUpdateSuccess) (BOOL);
typedef void (^LoginDMUpdateSuccess) (BOOL);
typedef void (^ResetPassDMUpdateSuccess) (BOOL);
typedef void (^ActiveUserDMUpdateSuccess) (BOOL);
typedef void (^CustomerProfileDMUpdateSuccess) (BOOL);

@interface DataModelManager : NSObject


/**
 Methode to parse and update Logindata Model
 @param loginObject - Service Response Object
 @param ldmSuccess - callback finish and update datamodel call back
 */
+(void)updateCitiDataModel:(id)loginObject withCitiUpdateSuccess:(CitiDMUpdateSuccess)ldmSuccess;

/**
 Methode to parse and update Logindata Model
 @param loginObject - Service Response Object
 @param ldmSuccess - callback finish and update datamodel call back
 */
+(void)updateCategoryDataModel:(id)loginObject withCategoryUpdateSuccess:(CategoryDMUpdateSuccess)ldmSuccess;
+(void)updateQuestionsDataModel:(id)loginObject withQuestionsUpdateSuccess:(QuestionsDMUpdateSuccess)ldmSuccess;
+(void)updateSubmitLeadDataModel:(id)responseObject withSubmitLeadUpdateSuccess:(SubmitLeadDMUpdateSuccess)ldmSuccess;
+(void)updatePromoCodeDataModel:(id)responseObject withPromoCodeUpdateSuccess:(PromoCodeDMUpdateSuccess)ldmSuccess;
+(void)updateMyOrderListDataModel:(id)responseObject withMyOrderUpdateSuccess:(MyOrderListDMUpdateSuccess)ldmSuccess;
+(void)updateQuoteListDataModel:(id)responseObject withQuoteUpdateSuccess:(QuoteListDMUpdateSuccess)ldmSuccess;
+(void)updateOnlineQuoteListDataModel:(id)responseObject withQuoteUpdateSuccess:(OnlineQuoteListDMUpdateSuccess)ldmSuccess;
+(void)updateMerchantProfileDataModel:(id)responseObject withMerchantProfileSuccess:(MerchantProfileDMUpdateSuccess)ldmSuccess;
+(void)updatePanicServiceDataModel:(id)responseObject withPanicServiceSuccess:(PanicServiceDMUpdateSuccess)ldmSuccess;



+(void)updateCountryDataModel:(id)responseObject withCountrySuccess:(CountryDMUpdateSuccess)ldmSuccess;
+(void)updateStateDataModel:(id)responseObject withStateSuccess:(StateDMUpdateSuccess)ldmSuccess;
+(void)updateCityDataModel:(id)responseObject withCitySuccess:(CityDMUpdateSuccess)ldmSuccess;
+(void)updateSignUpDataModel:(id)responseObject withSignUpSuccess:(SigUpDMUpdateSuccess)ldmSuccess;
+(void)updateLoginDataModel:(id)responseObject withLoginSuccess:(LoginDMUpdateSuccess)ldmSuccess;
+(void)updateResetPassDataModel:(id)responseObject withResetSuccess:(ResetPassDMUpdateSuccess)ldmSuccess;
+(void)updateActiveDataModel:(id)responseObject withActiveUserSuccess:(ActiveUserDMUpdateSuccess)ldmSuccess;
+(void)updateCustomerProfileDataModel:(id)responseObject withProfileSuccess:(CustomerProfileDMUpdateSuccess)ldmSuccess;
@end
