//
//  AppDelegate.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 09/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworkReachabilityManager.h"
#import "Cities.h"
#import "MajorCategory.h"
#import "ChildCategory.h"
//#import <Analytics/Analytics.h>
#import "Questions.h"
#import "Location.h"
#import "Options.h"
#import "Questions.h"
#import "MyOrder.h"
#import "Quotes.h"
#import "QuotesList.h"
#import "MerchantProfile.h"
#import "RateCard.h"
#import "RequestResposeHandler.h"
#import "LocalOyeConstants.h"

#import "QuestionRateCard.h"
#import "Skus.h"
#import "MajorSku.h"
#import "MinorSku.h"

#import "Localytics.h"
#import <sys/sysctl.h>

#import "Country.h"
#import "States.h"
#import "CityData.h"
#import "SignUpDetails.h"
#import "DataModelManager.h"
#import "Address.h"

#import "SignUpDetails.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
   
    
    NSLog(@"fonts %@",[UIFont fontNamesForFamilyName:@"Gotham Rounded"]);
    
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    NSLog(@"retrieveDeviceID %@",[self retrieveDeviceID].UUIDString);
    
    SHARED_DELEGATE.deviceID = [self retrieveDeviceID].UUIDString;
    
    self.numberOfQuestions = [[NSMutableArray alloc] init];
    
    
    //Method to invoke network rechability
    [self enableNetworkRechability];
    
    //Method to invoke Slide view navigation
    [self enableSlideViewNavigation];
    SHARED_DELEGATE.methodType = @"POST";
    
    [self registerAppForNotifications];
    
    
    [Localytics integrate:LOCALYTICS_API_KEY];
    
    if (application.applicationState != UIApplicationStateBackground)
    {
        [Localytics openSession];
    }
    
    [self getMasterCountryData];
    [self getMasterStateData];
    [self getMasterCityData];
    
    
    NSArray *array = [self retrieveModelData:@"SignUpDetails"];
    if([array count]>0){
       SignUpDetails *userDetails =  [array objectAtIndex:0];
        SHARED_DELEGATE.userID = [NSString stringWithFormat:@"%@",userDetails.userId];
        ;
    }
    
    
    return YES;
}

-(void)getMasterCountryData
{
    [RequestResposeHandler GetCountriesService:^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
        
        if (success)
        {
            NSLog(@"sucess");
        }
        else{
            //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(error,@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [wsAlert show];
        }
        
    }];
}

-(void)getMasterStateData
{
    [RequestResposeHandler GetStatesService:^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
        
        if (success)
        {
            NSLog(@"sucess");
        }
        else{
            //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(error,@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [wsAlert show];
        }
        
    }];
    
}
-(void)getMasterCityData
{
    [RequestResposeHandler GetMasterCitiService:^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
        
        if (success)
        {
            NSLog(@"sucess");
        }
        else{
            //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(error,@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [wsAlert show];
        }
        
    }];
    
}


-(void)addLocalytics
{
    
    
}
-(void)registerAppForNotifications{
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [Localytics handlePushNotificationOpened:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"userInfo %@",userInfo);
    
    if ( application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground  )
    {
        //opened from a push notification when the app was on background
    }
    
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        NSLog(@"didRegisterUser");
        [application registerForRemoteNotifications];
    }
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *deviceTokenStr = [[[[deviceToken description]
                                stringByReplacingOccurrencesOfString: @"<" withString: @""]
                               stringByReplacingOccurrencesOfString: @">" withString: @""]
                              stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    SHARED_DELEGATE.deviceToken = deviceTokenStr;
    
    [Localytics setPushToken:deviceToken];
    
    if(!isApnsTriggered)
    {
        NSDictionary *apns = [self frameAPNSJson];
        [self initiateAPNSAPI:apns];
        isApnsTriggered = YES;
    }
    
    NSLog(@"My token is: %@", deviceTokenStr);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

-(void)enableSlideViewNavigation
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    LeftMenuViewController *leftMenu = (LeftMenuViewController*)[mainStoryboard
                                                                 instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
    
    RightMenuViewController *rightMenu = (RightMenuViewController*)[mainStoryboard
                                                                    instantiateViewControllerWithIdentifier: @"RightMenuViewController"];
    
    [SlideNavigationController sharedInstance].rightMenu = rightMenu;
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .38;
    
    // Creating a custom bar button for right menu
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"ic-chat"] forState:UIControlStateNormal];
    
    //Target commented for testing
    
    [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleHelpShift) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [SlideNavigationController sharedInstance].rightBarButtonItem = rightBarButtonItem;
    
    
    [SlideNavigationController sharedInstance].navigationBar.backgroundColor = [UIColor clearColor];
    
    [SlideNavigationController sharedInstance].navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [[SlideNavigationController sharedInstance].navigationBar setTranslucent:YES];
    [SlideNavigationController sharedInstance].navigationBar.shadowImage = [UIImage new];
    [[SlideNavigationController sharedInstance].navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [SlideNavigationController sharedInstance].navigationBar.shadowImage = [[UIImage alloc] init];
    [SlideNavigationController sharedInstance].navigationBar.backgroundColor = [UIColor clearColor];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidClose object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Closed %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidOpen object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Opened %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidReveal object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Revealed %@", menu);
    }];
}


-(void)enableNetworkRechability
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    NSString *remoteHostName = @"www.apple.com";
    
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    
    
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
    [self.wifiReachability startNotifier];
}

/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
}

//Method to check whether the device is recheble through wifi or 3g
- (BOOL)isConnected {
    
    NetworkStatus netStatus = [self.internetReachability currentReachabilityStatus];
    
    BOOL ret = FALSE;
    
    switch (netStatus)
    {
        case NotReachable:        {
            NSLog(@"1");
            ret = FALSE;
            break;
        }
            
        case ReachableViaWWAN:        {
            ret = TRUE;
            break;
        }
        case ReachableViaWiFi:        {
            NSLog(@"3");
            ret = TRUE;
            break;
        }
    }
    return ret;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [Localytics dismissCurrentInAppMessage];
    [Localytics closeSession];
    [Localytics upload];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [Localytics openSession];
    [Localytics upload];
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [Localytics openSession];
    [Localytics upload];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.localoye.localoye.LocalOye" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LocalOye" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    NSLog(@"sqlite path %@",[self applicationDocumentsDirectory]);
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LocalOye.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(void)clearFeedData
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest * feedDataObj = [[NSFetchRequest alloc] init];
    [feedDataObj setEntity:[NSEntityDescription entityForName:@"FeedData" inManagedObjectContext:context]];
    [feedDataObj setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * feedArray = [context executeFetchRequest:feedDataObj error:&error];
    
    //error handling goes here
    for (NSManagedObject * feed in feedArray) {
        [context deleteObject:feed];
    }
    NSError *saveError = nil;
    [context save:&saveError];
    
    
}
-(void)insertCitiData:(NSMutableDictionary*)dict
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Cities"];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"citiID == %@",[dict objectForKey:@"citiID"]];
    [fetchRequest setPredicate:predicate];
    
    
    NSError *errorFetch = nil;
    NSArray *array = [context executeFetchRequest:fetchRequest error:&errorFetch];
    
    
    if([array count]>0){
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    else{
        Cities *requestData = (Cities *)[NSEntityDescription
                                         insertNewObjectForEntityForName:@"Cities"
                                         inManagedObjectContext:context];
        
        
        requestData.citiID = [dict objectForKey:@"citiID"];
        requestData.citiName = [dict objectForKey:@"citiName"];
        
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
    }
}

-(void)insertMajorAndChildCategoryData:(NSDictionary*)dictionary
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
    
    for(NSDictionary *dict in diction)
    {
    //for( NSDictionary *dict in dictionary )
    //{
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MajorCategory"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"slug == %@",[dict objectForKey:@"slug"]];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        MajorCategory *majorCat;
        
        if([results count]>0){
            
            majorCat = [results objectAtIndex:0];
        }
        else{
            majorCat = (MajorCategory *)[NSEntityDescription
                                         insertNewObjectForEntityForName:@"MajorCategory"
                                         inManagedObjectContext:context];
        }
        
        NSString *categoryName = [dict objectForKey:@"name"];
        NSString *icon = [dict objectForKey:@"icon"];
        NSString *banner =[dict objectForKey:@"banner"];
        NSString *slug =[dict objectForKey:@"slug"];
        
        majorCat.name = categoryName;
        majorCat.banner = banner;
        majorCat.icon = icon;
        majorCat.slug = slug;
        
        NSArray *childCat = [dict objectForKey:@"categories"];
        
        for ( NSDictionary *dictn in childCat) {
            
            NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ChildCategory"];
            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"slug == %@",[dictn objectForKey:@"slug"]];
            [fetchRequest setPredicate:predicate];
            
            
            NSError *errorFetch = nil;
            NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
            
            ChildCategory *childCat;
            
            if([results count]>0){
                
                childCat = [results objectAtIndex:0];
            }
            else{
                childCat = (ChildCategory *)[NSEntityDescription
                                             insertNewObjectForEntityForName:@"ChildCategory"
                                             inManagedObjectContext:context];
            }
            
            NSString *cat_type = [dictn objectForKey:@"type"];
            NSString *icon = [dictn objectForKey:@"icon"];
            NSString *name =[dictn objectForKey:@"name"];
            NSString *slug =[dictn objectForKey:@"slug"];
            NSString *banner = [dictn objectForKey:@"banner"];
            NSString *landing_content = [dictn objectForKey:@"landing_content"];
            NSString *landing_header = [dictn objectForKey:@"landing_header"];
            
            
            childCat.cat_type = cat_type;
            childCat.slug = slug;
            childCat.name = name;;
            childCat.icon = icon;
            childCat.banner = banner;
            childCat.landing_content = landing_content;
            childCat.landing_header = landing_header;
            
            [majorCat addChildCategoryObject:childCat];
        }
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

-(void)insertQuestionsData : (NSDictionary*)dictionary : (NSString*)category
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    int seqNo = -1;
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
    
    for(NSDictionary *dict1 in diction){
        
        NSDictionary *dict = [dict1 objectForKey:@"questions"];
        
        for(NSDictionary *dic in dict)
        {
            NSLog(@"dic %@",dic);
        }
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Questions"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"questionDesc == %@",[dict objectForKey:@"question"]];
        [fetchRequest setPredicate:predicate];
        

        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        Questions *questions;

        if([results count]>0){
            
            questions = [results objectAtIndex:0];
        }
        else{
            seqNo = seqNo+1;
            questions = (Questions *)[NSEntityDescription
                                         insertNewObjectForEntityForName:@"Questions"
                                         inManagedObjectContext:context];
            
            
            NSNumber *seqNoN =[NSNumber numberWithInt:seqNo];
            questions.sequenceNumber = seqNoN;
            
        }
        
        NSString *questionDesc = [dict objectForKey:@"question"];
        NSString *questionType =[dict objectForKey:@"type"];
        
        questions.category = category;
        questions.questionDesc = questionDesc;
        questions.questionType = questionType;
        
        NSArray *childCat = [dict objectForKey:@"options"];
        
        for ( NSDictionary *data in childCat) {
            
            NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Options"];
            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"optionStr == %@",[data objectForKey:@"option_text"]];
            [fetchRequest setPredicate:predicate];
            
            NSError *errorFetch = nil;
            NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
            
            Options *options;

            if([results count]>0){
                
                options = [results objectAtIndex:0];
            }
            else{
                options = (Options *)[NSEntityDescription
                                             insertNewObjectForEntityForName:@"Options"
                                             inManagedObjectContext:context];
                NSString *optionString = [data objectForKey:@"option_text"];
                
                options.optionStr = optionString;
                options.nextQuestionIndex =[data objectForKey:@"next_question_index"];
                options.questionStr = questionDesc;
            }
            [questions addOptionsObject:options];
        }
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

-(void)updateRateCardData:(QuestionRateCard*)rateCardObj :(NSString*)addCartStr
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"QuestionRateCard"];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"sku_name == %@ && major_sku_name == %@ && minor_sku_name == %@",rateCardObj.sku_name,rateCardObj.major_sku_name,rateCardObj.minor_sku_name];
    [fetchRequest setPredicate:predicate];
    
    NSError *errorFetch = nil;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
    
    QuestionRateCard *rateCard;
    
    if([results count]>0){
        
        rateCard = [results objectAtIndex:0];
        
        rateCard.added_cart = addCartStr;
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    
}

-(void) insertRateCard: (NSDictionary*)rateCardArra
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSString *majorSkuName = @"";
    NSString *minorSkuName = @"";
    NSString *skuName = @"";
    
    NSDictionary *array = (NSDictionary*)rateCardArra;
    NSArray *diction = (NSArray*)[array objectForKey:@"data"];
    NSMutableDictionary *rateCardArr = [diction objectAtIndex:0];
    NSMutableDictionary *rateCardArray = [rateCardArr objectForKey:@"rate_card"];
    NSMutableDictionary *questions = [rateCardArr objectForKey:@"questions"];
    NSNumber *minimum_order_value = [rateCardArr objectForKey:@"minimum_order_value"];
    
    NSMutableDictionary *majorSku = [rateCardArray objectForKey:@"major_skus"];
    
    for(NSMutableDictionary *data in majorSku)
    {
        majorSkuName = [data objectForKey:@"major_sku_name"];
        
        NSMutableDictionary *minorSku = [data objectForKey:@"minor_skus"];
        for (NSMutableDictionary *data in minorSku)
        {
            minorSkuName = [data objectForKey:@"minor_sku_name"];
            
            NSArray *skus = [data objectForKey:@"skus"];
            
            
            for(NSMutableDictionary *dict in skus)
            {
                skuName = [dict objectForKey:@"sku_name"];
                NSLog(@"sku.. %@",[dict objectForKey:@"description"]);
                
                NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"QuestionRateCard"];
                NSPredicate * predicate = [NSPredicate predicateWithFormat:@"sku_name == %@ && minor_sku_name == %@ && category == %@",skuName,minorSkuName,SHARED_DELEGATE.selectedServiceName];
                [fetchRequest setPredicate:predicate];
                
                
                NSError *errorFetch = nil;
                NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
                
                QuestionRateCard *rateCard;
                
                if([results count]>0){
                    
                    rateCard = [results objectAtIndex:0];
                }
                else{
                    
                    rateCard = (QuestionRateCard *)[NSEntityDescription
                                                    insertNewObjectForEntityForName:@"QuestionRateCard"
                                                    inManagedObjectContext:context];
                }
                
                NSNumber *skuId =[dict objectForKey:@"sku_id"];
                NSString *skuPriceType = [NSString stringWithFormat:@"%@",[dict objectForKey:@"sku_price_type"]];
                
                rateCard.descriptionStr= [dict objectForKey:@"description"];
                rateCard.sku_id= skuId;
                rateCard.sku_img= [dict objectForKey:@"sku_img"];
                rateCard.sku_name= skuName;
                rateCard.sku_price= [dict objectForKey:@"sku_price"];
                rateCard.sku_price_type= skuPriceType;
                rateCard.sku_unit_type= [dict objectForKey:@"sku_unit_type"];
                rateCard.major_sku_name= majorSkuName;
                rateCard.minor_sku_name= minorSkuName;
                rateCard.category= SHARED_DELEGATE.selectedServiceName;
                rateCard.minimum_order_value = minimum_order_value;
                NSError *error;
                if (![context save:&error]) {
                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                }
                
            }
        }
    }
    //Rate card ends
    
    //Question starts
    
    for(NSDictionary *dict in questions)
    {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Questions"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"questionDesc == %@  && category == %@",[dict objectForKey:@"question"],SHARED_DELEGATE.selectedServiceName];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        Questions *questions;
        
        if([results count]>0){
            
            questions = [results objectAtIndex:0];
        }
        else{
            
            questions = (Questions *)[NSEntityDescription
                                      insertNewObjectForEntityForName:@"Questions"
                                      inManagedObjectContext:context];
            
            
            
        }
        
        NSString *questionDesc = [dict objectForKey:@"question"];
        //NSString *inputyType = [dict objectForKey:@"inputtype"];
        //NSString *hintText =[dict objectForKey:@"hinttext"];
        NSString *questionType =[dict objectForKey:@"type"];
        NSNumber *seqNo =[dict objectForKey:@"question_id"];
        
        questions.category = SHARED_DELEGATE.selectedServiceName;
        //questions.hintText = hintText;
        questions.questionDesc = questionDesc;
        questions.questionType = questionType;
        questions.sequenceNumber = seqNo;
        
        NSArray *childCat = [dict objectForKey:@"options"];
     
        for ( NSDictionary *data in childCat) {
            
            NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Options"];
            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"optionStr == %@",[data objectForKey:@"option_text"]];
            [fetchRequest setPredicate:predicate];
            
            
            NSError *errorFetch = nil;
            NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
            
            Options *options;
            
            if([results count]>0){
                
                options = [results objectAtIndex:0];
            }
            else{
                options = (Options *)[NSEntityDescription
                                      insertNewObjectForEntityForName:@"Options"
                                      inManagedObjectContext:context];
                NSString *optionString = [data objectForKey:@"option_text"];
                
                options.optionStr = optionString;
                options.nextQuestionIndex =[data objectForKey:@"next_question_index"];
                options.questionStr = questionDesc;
            }
            
            [questions addOptionsObject:options];
            
        }
        
    }
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
}


-(void) insertRateCardBack: (NSDictionary*)rateCardArra
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSString *majorSkuName = @"";
    NSString *minorSkuName = @"";
    NSString *skuName = @"";
    
    NSDictionary *array = (NSDictionary*)rateCardArra;
    NSArray *diction = (NSArray*)[array objectForKey:@"data"];
    NSMutableDictionary *rateCardArr = [diction objectAtIndex:0];
    NSMutableDictionary *rateCardArray = [rateCardArr objectForKey:@"rate_card"];
    NSMutableDictionary *questions = [rateCardArr objectForKey:@"questions"];
    
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RateCard"];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"category == %@",SHARED_DELEGATE.selectedServiceHeader];
    [fetchRequest setPredicate:predicate];
    
    
    NSError *errorFetch = nil;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
    
    RateCard *rateCard;
    
    if([results count]>0){
        
        rateCard = [results objectAtIndex:0];
    }
    else{
        
        rateCard = (RateCard *)[NSEntityDescription
                                        insertNewObjectForEntityForName:@"RateCard"
                                        inManagedObjectContext:context];
    }

    rateCard.category = SHARED_DELEGATE.selectedServiceHeader;
    
    NSMutableDictionary *majorSku = [rateCardArray objectForKey:@"major_skus"];
    
    for(NSMutableDictionary *data in majorSku)
    {
        majorSkuName = [data objectForKey:@"majorSkuName"];
        
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MajorSku"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"majorSkuName == %@",majorSkuName];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        MajorSku *majorSkuRateCard;
        
        if([results count]>0){
            
            majorSkuRateCard = [results objectAtIndex:0];
        }
        else{
            
            majorSkuRateCard = (MajorSku *)[NSEntityDescription
                                    insertNewObjectForEntityForName:@"MajorSku"
                                    inManagedObjectContext:context];
        }

        majorSkuRateCard.majorSkuName = majorSkuName;
        
        
        
        NSMutableDictionary *minorSku = [data objectForKey:@"minor_skus"];
        for (NSMutableDictionary *data in minorSku)
        {
            minorSkuName = [data objectForKey:@"minorSkuName"];
            
            NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MinorSku"];
            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"minorSkuName == %@",minorSkuName];
            [fetchRequest setPredicate:predicate];
            
            
            NSError *errorFetch = nil;
            NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
            
            MinorSku *minorSkuRateCard;
            
            if([results count]>0){
                
                minorSkuRateCard = [results objectAtIndex:0];
            }
            else{
                
                minorSkuRateCard = (MinorSku *)[NSEntityDescription
                                                insertNewObjectForEntityForName:@"MinorSku"
                                                inManagedObjectContext:context];
            }

            minorSkuRateCard.minorSkuName = minorSkuName;
            
            NSArray *skus = [data objectForKey:@"skus"];
            for(NSMutableDictionary *dict in skus)
            {
                skuName = [dict objectForKey:@"skuName"];
                NSLog(@"sku.. %@",[dict objectForKey:@"descriptionStr"]);
                
                NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Skus"];
                NSPredicate * predicate = [NSPredicate predicateWithFormat:@"skuName == %@",skuName];
                [fetchRequest setPredicate:predicate];
                
                
                NSError *errorFetch = nil;
                NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
                
                Skus *skuRateCard;
                
                if([results count]>0){
                    
                    skuRateCard = [results objectAtIndex:0];
                }
                else{
                    
                    skuRateCard = (Skus *)[NSEntityDescription
                                                    insertNewObjectForEntityForName:@"Skus"
                                                    inManagedObjectContext:context];
                }
                
            
                
                NSNumber *skuId =[dict objectForKey:@"skuID"];
                NSString *skuPriceType = [NSString stringWithFormat:@"%@",[dict objectForKey:@"skuPriceType"]];
                
                
                skuRateCard.descriptionStr= [dict objectForKey:@"descriptionStr"];
                skuRateCard.skuID= skuId;
                skuRateCard.skuImg= [dict objectForKey:@"skuImg"];
                skuRateCard.skuName= skuName;
                skuRateCard.skuPrice= [dict objectForKey:@"skuPrice"];
                skuRateCard.skuPriceType= skuPriceType;
                skuRateCard.skuUnitType= [dict objectForKey:@"skuUnitType"];
                //rateCard.majorSkuName= majorSkuName;
                //rateCard.minorSkuName= minorSkuName;
                //rateCard.category= SHARED_DELEGATE.selectedServiceHeader;
                
                [minorSkuRateCard addSkusObject:skuRateCard];
                [majorSkuRateCard addMinorSkuObject:minorSkuRateCard];
                [rateCard addMajorSkusObject:majorSkuRateCard];
                
                NSError *error;
                if (![context save:&error]) {
                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                }
            }
        }
    }
}

//Need to change according to response
-(void)insertSubmitLeadData : (NSDictionary*)dictionary : (NSString*)category
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
    
    for(NSDictionary *dict in diction){
    
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Questions"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"questionDesc == %@",[dict objectForKey:@"question"]];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        Questions *questions;
        
        if([results count]>0){
            
            questions = [results objectAtIndex:0];
        }
        else{
            
            questions = (Questions *)[NSEntityDescription
                                      insertNewObjectForEntityForName:@"Questions"
                                      inManagedObjectContext:context];
        }
        
        NSString *questionDesc = [dict objectForKey:@"question"];
        //NSString *inputyType = [dict objectForKey:@"inputtype"];
        NSString *hintText =[dict objectForKey:@"hinttext"];
        NSString *questionType =[dict objectForKey:@"type"];
        //NSNumber *seqNo =[dict objectForKey:@"sequence_number"];
        
        questions.category = category;
        questions.questionDesc = questionDesc;
        questions.questionType = questionType;
        
        questions.hintText = hintText;
        
        NSArray *childCat = [dict objectForKey:@"options"];
        
        for ( NSDictionary *data in childCat) {
            
            NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Options"];
            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"optionStr == %@",[data objectForKey:@"option_text"]];
            [fetchRequest setPredicate:predicate];
            
            
            NSError *errorFetch = nil;
            NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
            
            Options *options;
            
            if([results count]>0){
                
                options = [results objectAtIndex:0];
            }
            else{
                options = (Options *)[NSEntityDescription
                                      insertNewObjectForEntityForName:@"Options"
                                      inManagedObjectContext:context];
                NSString *optionString = [data objectForKey:@"option_text"];
                
                options.optionStr = optionString;
                options.nextQuestionIndex =[data objectForKey:@"next_question_index"];
                options.questionStr = questionDesc;
            }
            [questions addOptionsObject:options];
        }
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}


//Need to change according to response
-(void)insertPromoCodeData : (NSDictionary*)dictionary : (NSString*)category
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
    
    for(NSDictionary *dict in diction){
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Questions"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"questionDesc == %@",[dict objectForKey:@"question"]];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        Questions *questions;
        
        if([results count]>0){
            
            questions = [results objectAtIndex:0];
        }
        else{
            
            questions = (Questions *)[NSEntityDescription
                                      insertNewObjectForEntityForName:@"Questions"
                                      inManagedObjectContext:context];
        }
        
        NSString *questionDesc = [dict objectForKey:@"question"];
        //NSString *inputyType = [dict objectForKey:@"inputtype"];
        NSString *hintText =[dict objectForKey:@"hinttext"];
        NSString *questionType =[dict objectForKey:@"type"];
        //NSNumber *seqNo =[dict objectForKey:@"sequence_number"];
        
        questions.category = category;
        questions.questionDesc = questionDesc;
        questions.questionType = questionType;
        
        
        questions.hintText = hintText;
        
        NSArray *childCat = [dict objectForKey:@"options"];
        
        for ( NSDictionary *data in childCat) {
            
            
            NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Options"];
            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"optionStr == %@",[data objectForKey:@"option_text"]];
            [fetchRequest setPredicate:predicate];
            
            
            NSError *errorFetch = nil;
            NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
            
            Options *options;
            
            if([results count]>0){
                
                options = [results objectAtIndex:0];
            }
            else{
                options = (Options *)[NSEntityDescription
                                      insertNewObjectForEntityForName:@"Options"
                                      inManagedObjectContext:context];
                NSString *optionString = [data objectForKey:@"option_text"];
                
                options.optionStr = optionString;
                options.nextQuestionIndex =[data objectForKey:@"next_question_index"];
                options.questionStr = questionDesc;
                
                
            }
            
            
            [questions addOptionsObject:options];
            
        }
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

//Need to change according to response
-(void)insertMyOrderListData : (NSDictionary*)dictionary : (NSString*)category
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
    
    if([diction count]>0){
        for(NSDictionary *dict in diction){
            if([dict count]>0){
                NSNumber *bookID =[dict objectForKey:@"booking_id"];
                NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MyOrder"];
                NSPredicate * predicate = [NSPredicate predicateWithFormat:@"booking_id == %@",bookID];
                [fetchRequest setPredicate:predicate];
                
                NSError *errorFetch = nil;
                NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
                
                MyOrder *myOrder;
                
                if([results count]>0){
                    
                    myOrder = [results objectAtIndex:0];
                    
                }
                else{
                    
                    myOrder = (MyOrder *)[NSEntityDescription
                                          insertNewObjectForEntityForName:@"MyOrder"
                                          inManagedObjectContext:context];
                    
                    NSNumber *booking_id =[dict objectForKey:@"booking_id"];
                    myOrder.booking_id = booking_id;
                }
                
                NSString *category = [dict objectForKey:@"category"];
                NSString *category_icon =[dict objectForKey:@"category_icon"];
                NSString *category_type =[dict objectForKey:@"category_type"];
                NSString *created_at =[dict objectForKey:@"created_at"];
                NSString *status =[dict objectForKey:@"status"];
                NSString *status_text =[dict objectForKey:@"status_text"];
                int  no_of_quotes =[[dict objectForKey:@"no_of_quotes"]intValue ];
                
                myOrder.category = category;
                myOrder.category_icon = category_icon;
                myOrder.category_type = category_type;
                myOrder.created_at = created_at;
                myOrder.status = status;
                myOrder.status_text = status_text;
                
                myOrder.no_of_quotes = [NSNumber numberWithInt:no_of_quotes];
                
                
                NSArray *quotes = [dict objectForKey:@"quotes"];
                
                for ( NSDictionary *data in quotes) {
                    
                    
                    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Quotes"];
                    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"merchant_id == %@",[data objectForKey:@"merchant_id"]];
                    [fetchRequest setPredicate:predicate];
                    
                    
                    NSError *errorFetch = nil;
                    NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
                    
                    Quotes *quotes;
                    
                    if([results count]>0){
                        
                        quotes = [results objectAtIndex:0];
                    }
                    else{
                        quotes = (Quotes *)[NSEntityDescription
                                            insertNewObjectForEntityForName:@"Quotes"
                                            inManagedObjectContext:context];
                    }
                    
                    
                    quotes.merchant_image = [data objectForKey:@"merchant_image"];
                    quotes.merchant_name =[data objectForKey:@"merchant_name"];
                    quotes.merchant_id =[data objectForKey:@"merchant_id"];
                    quotes.lead_id = [data objectForKey:@"lead_id"];
                    
                    [myOrder addQuotesObject:quotes];
                    
                }
                
                NSError *error;
                if (![context save:&error]) {
                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                }
            }
        }
    }
}


//Need to change according to response
-(void)insertQuoteListData : (NSDictionary*)dictionary : (NSString*)category
{
        
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
    
    //for(NSArray *dict1 in diction){
    for(NSDictionary *dict in diction){
        
        NSNumber *merchantID =[dict objectForKey:@"merchant_id"];
        //NSDictionary *dict = [dict1 objectAtIndex:0];
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"QuotesList"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"merchant_id == %@",merchantID];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        QuotesList *quotesList;
        
        if([results count]>0){
            
            quotesList = [results objectAtIndex:0];
        }
        else{
            
            quotesList = (QuotesList *)[NSEntityDescription
                                      insertNewObjectForEntityForName:@"QuotesList"
                                      inManagedObjectContext:context];
            
            
            
        }
        
        NSNumber *merchant_id =[dict objectForKey:@"merchant_id"];
        NSNumber *lead_id =[dict objectForKey:@"quote_id"];
        NSNumber *no_of_quotes =[dict objectForKey:@"no_of_quotes"];
        //NSString *quote_price =[dict objectForKey:@"quote_price"];
        NSNumber *time_delta =[dict objectForKey:@"time_delta"];
        
        quotesList.category = [dict objectForKey:@"category"];
        quotesList.category_type = [dict objectForKey:@"category_type"];
        quotesList.merchant_image = [dict objectForKey:@"merchant_image"];
        quotesList.merchant_name = [dict objectForKey:@"merchant_name"];
        quotesList.requirement = [dict objectForKey:@"requirement"];
        quotesList.server_timestamp = [dict objectForKey:@"server_timestamp"];
        
        quotesList.merchant_id = merchant_id;
        quotesList.lead_id = lead_id;
        //quotesList.no_of_quotes = no_of_quotes;
        quotesList.quote_price =[NSString stringWithFormat:@"%@",[dict objectForKey:@"quote_price"]];
        
        quotesList.time_delta = time_delta;
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}


-(void)insertOnlineQuoteListData : (NSDictionary*)dictionary : (NSString*)category
{
    //We need to correct it
    NSLog(@"dictionary %@",dictionary);
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
    NSString *downloadLinkStr = @"";
    
    for(NSDictionary *dictn in diction){
        //for( NSDictionary *dict in dictionary ){
        downloadLinkStr = [dictn objectForKey:@"download_link"];
        NSDictionary *diction1 = (NSDictionary*)[dictn objectForKey:@"merchant_profile"];
        for(NSDictionary *dict in diction1){
            
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MerchantProfile"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"merchant_name == %@",[dict objectForKey:@"merchant_name"]];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        MerchantProfile *merchantProfile;
        
        if([results count]>0){
            
            merchantProfile = [results objectAtIndex:0];
        }
        else{
            
            merchantProfile = (MerchantProfile *)[NSEntityDescription
                                                  insertNewObjectForEntityForName:@"MerchantProfile"
                                                  inManagedObjectContext:context];
        }
        
                merchantProfile.downLoadLink = downloadLinkStr;
            
        merchantProfile.banner = [dict objectForKey:@"banner"];
        merchantProfile.certifications = [dict objectForKey:@"certifications"];
        merchantProfile.descriptionStr = [dict objectForKey:@"description"];
        merchantProfile.merchant_name = [dict objectForKey:@"merchant_name"];
        merchantProfile.profile_pic = [dict objectForKey:@"profile_pic"];
        merchantProfile.phone = [dict objectForKey:@"phone"];
        merchantProfile.quote_text = [dict objectForKey:@"quote_text"];
        merchantProfile.rating = [dict objectForKey:@"rating"];
            
        
        }
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

-(void)insertMerchantProfileData : (NSDictionary*)dictionary : (NSString*)category
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
    
    for(NSDictionary *dict in diction){
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MerchantProfile"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"merchant_name == %@",[dict objectForKey:@"merchant_name"]];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        MerchantProfile *merchantProfile;
        
        if([results count]>0){
            
            merchantProfile = [results objectAtIndex:0];
        }
        else{
            
            merchantProfile = (MerchantProfile *)[NSEntityDescription
                                      insertNewObjectForEntityForName:@"MerchantProfile"
                                      inManagedObjectContext:context];
        }
        
        if([[dict objectForKey:@"download_link"] length]>0)
        {
            merchantProfile.downLoadLink = [dict objectForKey:@"download_link"];
        }
        merchantProfile.banner = [dict objectForKey:@"banner"];
        merchantProfile.certifications = [dict objectForKey:@"certifications"];
        merchantProfile.descriptionStr = [dict objectForKey:@"descriptionStr"];
        merchantProfile.merchant_name = [dict objectForKey:@"merchant_name"];
        merchantProfile.profile_pic = [dict objectForKey:@"profile_pic"];
        merchantProfile.phone = [dict objectForKey:@"phone"];
        merchantProfile.quote_text = [dict objectForKey:@"quote_text"];
        merchantProfile.rating = [dict objectForKey:@"rating"];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

-(void)insertOnlineMerchantQuoteData : (NSDictionary*)dictionary : (NSString*)category
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
    
    for(NSDictionary *dict in diction){
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"OnlineMerchantData"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"merchant_name == %@",[dict objectForKey:@"merchant_name"]];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        MerchantProfile *merchantProfile;
        
        if([results count]>0){
            
            merchantProfile = [results objectAtIndex:0];
        }
        else{
            
            merchantProfile = (MerchantProfile *)[NSEntityDescription
                                                  insertNewObjectForEntityForName:@"OnlineMerchantData"
                                                  inManagedObjectContext:context];
        }
        
        merchantProfile.banner = [dict objectForKey:@"banner"];
        merchantProfile.certifications = [dict objectForKey:@"certifications"];
        merchantProfile.descriptionStr = [dict objectForKey:@"descriptionStr"];
        merchantProfile.merchant_name = [dict objectForKey:@"merchant_name"];
        merchantProfile.profile_pic = [dict objectForKey:@"profile_pic"];
        merchantProfile.phone = [dict objectForKey:@"phone"];
        merchantProfile.quote_text = [dict objectForKey:@"quote_text"];
        merchantProfile.rating = [dict objectForKey:@"rating"];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}


-(void)insertPanicServiceData : (NSDictionary*)dictionary : (NSString*)category
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"data"];
    
    for(NSDictionary *dict in diction){
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Questions"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"questionDesc == %@",[dict objectForKey:@"question"]];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        Questions *questions;
        
        if([results count]>0){
            
            questions = [results objectAtIndex:0];
        }
        else{
            
            questions = (Questions *)[NSEntityDescription
                                      insertNewObjectForEntityForName:@"Questions"
                                      inManagedObjectContext:context];
        }
        
        NSString *questionDesc = [dict objectForKey:@"question"];
        //NSString *inputyType = [dict objectForKey:@"inputtype"];
        NSString *hintText =[dict objectForKey:@"hinttext"];
        NSString *questionType =[dict objectForKey:@"type"];
        //NSNumber *seqNo =[dict objectForKey:@"sequence_number"];
        
        questions.category = category;
        questions.questionDesc = questionDesc;
        questions.questionType = questionType;
        
        
        questions.hintText = hintText;
        
        NSArray *childCat = [dict objectForKey:@"options"];
        
        for ( NSDictionary *data in childCat) {
            
            
            NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Options"];
            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"optionStr == %@",[data objectForKey:@"option_text"]];
            [fetchRequest setPredicate:predicate];
            
            
            NSError *errorFetch = nil;
            NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
            
            Options *options;
            
            if([results count]>0){
                
                options = [results objectAtIndex:0];
            }
            else{
                options = (Options *)[NSEntityDescription
                                      insertNewObjectForEntityForName:@"Options"
                                      inManagedObjectContext:context];
                NSString *optionString = [data objectForKey:@"option_text"];
                
                options.optionStr = optionString;
                options.nextQuestionIndex =[data objectForKey:@"next_question_index"];
                options.questionStr = questionDesc;
                
                
            }
            
            
            [questions addOptionsObject:options];
            
        }
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

-(NSDictionary*)frameAPNSJson
{
    NSString *versionCode =@"1000";
    
    //SHARED_DELEGATE.deviceToken = @"038632601161EAA6B55377445FB54EFA3C7625DC229CF1FF72AA54910B697F16";
    SHARED_DELEGATE.appID = [[self retrieveDeviceID] UUIDString];
    
   NSDictionary *parametersVal = @{@"app_id":SHARED_DELEGATE.deviceID,
                      @"reg_id":SHARED_DELEGATE.deviceToken,
                      @"version_code":versionCode};
        
    return parametersVal;
    
}
-(NSArray*)retrieveModelDataWithCat:(NSString*) modelName : (NSString*) categoryName
{
    NSError *error;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"category == %@",categoryName];
    [fetchRequest setPredicate:predicate];

    
    NSEntityDescription *entity = [NSEntityDescription entityForName:modelName
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

-(NSArray*)retrieveAddedSkus:(NSString*) categoryName
{
    NSError *error;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"category == %@ && added_cart == %@",categoryName,kYesString];
    [fetchRequest setPredicate:predicate];
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"QuestionRateCard"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}


-(NSArray*)retrieveModelData:(NSString*) modelName
{
    NSError *error;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:modelName
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

-(NSArray*)retrieveModelDataWithPredicate:(NSString*)modelName : (NSString*)predicateCol : (NSString*)predicateVal
{
    NSError *error;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@",predicateVal];
    [fetchRequest setPredicate:predicate];

    
    NSEntityDescription *entity = [NSEntityDescription entityForName:modelName
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}


-(NSArray*)retrieveCategoryData
{
    NSError *error;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"MajorCategory"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

-(NSArray*)retrieveQuestionForServiceCategory:(NSString*)categoryService
{
    NSError *error;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"sequenceNumber" ascending:YES selector:@selector(localizedStandardCompare:)]];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"category == %@",categoryService];
    [fetchRequest setPredicate:predicate];

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Questions"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

-(NSArray*)retrieveQuestionForSequence:(NSNumber*)sequence : (NSString*)categoryService
{
    NSError *error;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"sequenceNumber == %@ && category == %@",sequence,categoryService];
    [fetchRequest setPredicate:predicate];
    
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Questions"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

- (UIImage *)imageWithColor:(UIColor *)color:(UIImage *)img
{
    // load the image
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(img.size);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode to color burn, and the original image
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    
    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
    
}

-(NSArray*)readJsonFile:(NSString*)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return json;
}

-(void)addProgressIndicator
{
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    [self.window addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(initiateVersionCodeCheckAPI) onTarget:self withObject:nil animated:YES];

}

-(void)initiateVersionCodeCheckAPI
{
    if([APPDELEGATE_SHARED_MANAGER isConnected]){
        
        [RequestResposeHandler GetVersionCodeCheckService:^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
            
            if (success)
            {
                NSLog(@"sucess");
            }
            else{
                //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
                UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(error,@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [wsAlert show];
            }
            
        }];
    }
    else{
        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [wsAlert show];
    }
}


-(void)initiateAPNSAPI:(NSDictionary*)apnsData
{
    
//    UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:SHARED_DELEGATE.deviceToken  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [wsAlert show];
    
    if([APPDELEGATE_SHARED_MANAGER isConnected]){
        
        [RequestResposeHandler triggerApnsService:apnsData:^(BOOL success, NSString *error){ //need to
        //appropriatly according to service for alerts.
            
            if (success)
            {
                NSLog(@"sucess");
            }
            else{
                //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
                UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(error,@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [wsAlert show];
            }
            
        }];
    }
    else{
        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [wsAlert show];
    }
}

-(NSUUID*)retrieveDeviceID
{
    NSUUID *deviceID;
    
//#if TARGET_IPHONE_SIMULATOR
    //deviceID = [NSUUID initWithUUIDString:@"sdfsnmbhjajhsdhjahjdjhahjd"];
//#else
    deviceID = [UIDevice currentDevice].identifierForVendor;
//#endif
    
    NSLog(@"deviceID %@",deviceID);
    
    return deviceID;
}

-(NSArray*)fetchMajorSku:(NSString*)majorSkuName
{
    NSError *error;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@",SHARED_DELEGATE.selectedServiceHeader];
    [fetchRequest setPredicate:predicate];
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"QuestionRateCard"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
    
}


-(NSString*)findDeviceVersion {
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    NSString *deviceVer =[self platformType:platform];
    
    NSLog(@"iPhone Device%@",deviceVer);
    return deviceVer;
}


- (NSString *) platformType:(NSString *)platform
{
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (China)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2G";
    if ([platform isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3";
    if ([platform isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3 (2013)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

-(void)clearModelData:(NSString*)modelName
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest * dataObj = [[NSFetchRequest alloc] init];
    [dataObj setEntity:[NSEntityDescription entityForName:modelName inManagedObjectContext:context]];
    [dataObj setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * dataArray = [context executeFetchRequest:dataObj error:&error];
    
    //error handling goes here
    for (NSManagedObject * data in dataArray) {
        [context deleteObject:data];
    }
    NSError *saveError = nil;
    [context save:&saveError];
    
    
}


-(void)insertCountryData : (NSDictionary*)dictionary
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"response"];
    
    for(NSDictionary *dict in diction){
        
        NSNumber *country_id = [dict objectForKey:@"country_id"];
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Country"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"country_id == %@",country_id];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        Country *country;
        
        if([results count]>0){
            
            country = [results objectAtIndex:0];
        }
        else{
            
            country = (Country *)[NSEntityDescription
                                                  insertNewObjectForEntityForName:@"Country"
                                                  inManagedObjectContext:context];
        }
        
        country.country_id = [dict objectForKey:@"country_id"];
        country.country_slug = [dict objectForKey:@"country_slug"];
        country.country_name = [dict objectForKey:@"country_name"];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

-(void)insertStateData : (NSDictionary*)dictionary
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"response"];
    
    for(NSDictionary *dict in diction){
        
        NSNumber *state_id = [dict objectForKey:@"state_id"];
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"States"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"state_id == %@",state_id];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        States *states;
        
        if([results count]>0){
            
            states = [results objectAtIndex:0];
        }
        else{
            
            states = (States *)[NSEntityDescription
                                  insertNewObjectForEntityForName:@"States"
                                  inManagedObjectContext:context];
        }
        
        states.state_id = [dict objectForKey:@"state_id"];
        states.state_slug = [dict objectForKey:@"state_slug"];
        states.state_name = [dict objectForKey:@"state_name"];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

-(void)insertCitiMasterData : (NSDictionary*)dictionary
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"response"];
    
    for(NSDictionary *dict in diction){
        
        NSNumber *city_id = [dict objectForKey:@"city_id"];
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CityData"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"city_id == %@",city_id];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        CityData *cities;
        
        if([results count]>0){
            
            cities = [results objectAtIndex:0];
        }
        else{
            
            cities = (CityData *)[NSEntityDescription
                                insertNewObjectForEntityForName:@"CityData"
                                inManagedObjectContext:context];
        }
        
        cities.city_id = [dict objectForKey:@"city_id"];
        cities.city_slug = [dict objectForKey:@"city_slug"];
        cities.city_name = [dict objectForKey:@"city_name"];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

-(void)insertSignUpDataUserId:(NSDictionary*)dictionary:(NSString*)email
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDictionary *array = (NSDictionary*)dictionary;
    NSDictionary *diction = (NSDictionary*)[array objectForKey:@"response"];
    
    for(NSDictionary *dict in diction){
        
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"SignUpDetails"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"email == %@",email];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        SignUpDetails *signUp;
        
        if([results count]>0){
            
            signUp = [results objectAtIndex:0];
        }
        else{
            
            signUp = (SignUpDetails *)[NSEntityDescription
                                  insertNewObjectForEntityForName:@"SignUpDetails"
                                  inManagedObjectContext:context];
        }
  
        
        signUp.userId = [diction objectForKey:@"user_id"];
        SHARED_DELEGATE.userID = [NSString stringWithFormat:@"%@",[diction objectForKey:@"user_id"]];
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}
-(void)insertSignUpData:(NSDictionary*)dictionary:(NSString*)email
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
        
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"SignUpDetails"];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"email == %@",email];
        [fetchRequest setPredicate:predicate];
        
        
        NSError *errorFetch = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&errorFetch];
        
        SignUpDetails *signUp;
        
        if([results count]>0){
            
            signUp = [results objectAtIndex:0];
        }
        else{
            
            signUp = (SignUpDetails *)[NSEntityDescription
                                       insertNewObjectForEntityForName:@"SignUpDetails"
                                       inManagedObjectContext:context];
        }
        
        
        
        signUp.firstName = [dictionary objectForKey:@"first_name"];
        signUp.lastName = [dictionary objectForKey:@"last_name"];
        signUp.email = [dictionary objectForKey:@"email_id"];
        signUp.phoneNo = [dictionary objectForKey:@"mobile_number"];
        signUp.pasword = [dictionary objectForKey:@"password"];
        
        
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    
}

-(void)insertAddressData:(NSMutableDictionary*)dict
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Address"];
    //NSPredicate * predicate = [NSPredicate predicateWithFormat:@"citiID == %@",[dict objectForKey:@"citiID"]];
    //[fetchRequest setPredicate:predicate];
    
    
        Address *addressData = (Address *)[NSEntityDescription
                                         insertNewObjectForEntityForName:@"Address"
                                         inManagedObjectContext:context];
        
        
        addressData.countryId = [dict objectForKey:@"countryId"];
        addressData.countryName = [dict objectForKey:@"countryName"];
        addressData.stateId = [dict objectForKey:@"stateId"];
        addressData.stateName = [dict objectForKey:@"stateName"];
        addressData.cityId = [dict objectForKey:@"cityId"];
        addressData.cityName = [dict objectForKey:@"cityName"];
        addressData.location = [dict objectForKey:@"location"];
        addressData.addressType = [dict objectForKey:@"addressType"];
        addressData.houesNo = [dict objectForKey:@"houesNo"];
        
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
    
}
@end
