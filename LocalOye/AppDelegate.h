//
//  AppDelegate.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 09/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "SlideNavigationController.h"
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "QuestionRateCard.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    BOOL isApnsTriggered;
    
}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext          *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel            *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator    *persistentStoreCoordinator;


@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;


@property (nonatomic,strong) NSMutableArray *numberOfQuestions;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)insertCitiData:(NSMutableDictionary*)dict;
-(void)insertQuestionsData : (NSDictionary*)dictionary : (NSString*)category;
-(NSArray*)retrieveQuestionForServiceCategory:(NSString*)categoryService;
-(NSArray*)retrieveModelData:(NSString*) modelName;
-(void)insertMajorAndChildCategoryData:(NSMutableDictionary*)dict;
-(NSArray*)retrieveQuestionForSequence : (NSNumber*)sequence : (NSString*)categoryService;
- (UIImage *)imageWithColor : (UIColor *)color : (UIImage *)img;
-(void)insertSubmitLeadData : (NSDictionary*)dictionary : (NSString*)category;
-(void)insertPromoCodeData : (NSDictionary*)dictionary : (NSString*)category;
-(void)insertMyOrderListData : (NSDictionary*)dictionary : (NSString*)category;
-(void)insertQuoteListData : (NSDictionary*)dictionary : (NSString*)category;
-(void)insertOnlineQuoteListData : (NSDictionary*)dictionary : (NSString*)category;
-(void)insertMerchantProfileData : (NSDictionary*)dictionary : (NSString*)category;
-(void)insertPanicServiceData : (NSDictionary*)dictionary : (NSString*)category;
-(void) insertRateCard: (NSDictionary*)rateCardArra;

-(NSArray*)readJsonFile:(NSString*)fileName;
-(NSArray*)retrieveModelDataWithPredicate : (NSString*) modelName : (NSString*)predicateCol : (NSString*)predicateVal;
-(NSArray*)fetchMajorSku:(NSString*)majorSkuName;
-(NSArray*)retrieveModelDataWithCat :(NSString*) modelName : (NSString*) categoryName;
-(void)updateRateCardData:(QuestionRateCard*)rateCardObj :(NSString*)addCartStr;
- (BOOL)isConnected;
-(NSArray*)retrieveAddedSkus:(NSString*) categoryName;
-(NSString*)findDeviceVersion;
-(void)clearModelData:(NSString*)modelName;


-(void)insertCountryData : (NSDictionary*)dictionary;
-(void)insertStateData : (NSDictionary*)dictionary;
-(void)insertCitiMasterData : (NSDictionary*)dictionary;

-(void)insertSignUpDataUserId : (NSDictionary*)dictionary:(NSString*)email;
-(void)insertSignUpData : (NSDictionary*)dictionary:(NSString*)email;;
-(void)insertAddressData:(NSMutableDictionary*)dict;

@end

