//
//  RateCardViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 02/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "RateCardViewController.h"
#import "RequestResposeHandler.h"
#import "LocalOyeConstants.h"
#import "QuotesTableViewCell.h"
#import "RateCardTableViewCell.h"
#import "QuestionRateCard.h"
#import "UICollectionPicker.h"
#import "MajorSku.h"
#import "MinorSku.h"
#import "Skus.h"
#import "RateCard.h"
#import "RateCardDetailViewController.h"
#import "RateCardOrderSummaryViewController.h"

@interface RateCardViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionPicker *datepicker;

@end

@implementation RateCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        //////[self setupViewController];
    }
    return self;
}

-(void)createCollectionViewForCategories
{
    [self.datepicker addTarget:self action:@selector(updateSelectedDate) forControlEvents:UIControlEventValueChanged];
    
    [self.datepicker fillCurrentYear];
    [self.datepicker selectDateAtIndex:0];
}

- (void)updateSelectedDate
{
    
    
    //self.minorSkuArray = [self fetchDataForMajorSku:SHARED_DELEGATE.selectedMajorSku];
    [self setupViewController];
    
    [self.rateCardTableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.nextBtn setBackgroundColor:[UIColor orangeColor]];
    
    [self.rateCardTableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViewController];
    
    [self.rateCardTableView reloadData];
    [self.rateCardTableView openSection:0 animated:NO];
    
    [self createCollectionViewForCategories];
    
}

-(void)addProgressMerchantProfIndicator
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(initiateMerchantProfileAPI) onTarget:self withObject:nil animated:YES];
}

-(void)initiateRateCardAPI
{
    //if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
    [RequestResposeHandler GetMerchantProfileService: @"": @"" :^(BOOL success, NSString *error)
     { //need to use error appropriatly according to service for alerts.
         
         if (success)
         {
             NSLog(@"sucess");
             //[APPDELEGATE_SHARED_MANAGER clearFeedData];
             [self fetchRateCardData];
             //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
             [self.rateCardTableView reloadData];
             
             //[self launchSlideViewController];
         }
         else{
             //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
             UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(error,@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [wsAlert show];
         }
         
     }];
    //    }
    //    else{
    //        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:NSLocalizedString(@"Internet connection appears to be offline",@"Alert")  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [wsAlert show];
    //    }
}

-(void)fetchRateCardData
{
    self.rateCardList = [APPDELEGATE_SHARED_MANAGER retrieveModelDataWithCat:@"QuestionRateCard":SHARED_DELEGATE.selectedServiceName];
    //self.data = [quotesList mutableCopy];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        //[self fetchQuotesData];
        SHARED_DELEGATE.selectedMajorSku = @"";
        
        /////////[self setupViewController];
    }
    return self;
}

- (void)setupViewController
{
    self.minorSkuArray = [[NSMutableArray alloc] init];
    self.skuArray = [[NSMutableArray alloc] init];
    
    [self fetchRateCardData];
    
    
    
    NSArray* colors = @[[UIColor lightGrayColor],
                        [UIColor orangeColor],
                        [UIColor yellowColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor purpleColor]
                        ];
    [SHARED_DELEGATE.majorSkuList removeAllObjects];
    if([self.rateCardList count]>0){
        for (QuestionRateCard *rateCard in self.rateCardList) {
           
        
            minimumOrder = rateCard.minimum_order_value ;
            //[self downloadBannerImg:rateCard.sku_img];
            if(![SHARED_DELEGATE.majorSkuList containsObject:rateCard.major_sku_name])
                [SHARED_DELEGATE.majorSkuList addObject:rateCard.major_sku_name];
        }
        
        
        if([SHARED_DELEGATE.majorSkuList count]>0 && [SHARED_DELEGATE.selectedMajorSku isEqualToString:@""]){
            SHARED_DELEGATE.selectedMajorSku = [SHARED_DELEGATE.majorSkuList objectAtIndex:0];
        }
        
        
        //self.minorSkuArray = [self fetchDataForMajorSku:[SHARED_DELEGATE.majorSkuList objectAtIndex:[SHARED_DELEGATE.selectedMajorSkuInt intValue]]];
        self.minorSkuArray = [self fetchDataForMajorSkuNew:SHARED_DELEGATE.selectedMajorSku];
        
        if([self.minorSkuArray count]>0){
            //QuestionRateCard *rateCard = [self.minorSkuArray objectAtIndex:0];////////////New
            //self.skuArray = [self fetchDataForMinorSku:rateCard.minor_sku_name];//////////New
            NSDictionary *rateCard = [self.minorSkuArray objectAtIndex:0];
            self.skuArray = [self fetchDataForMinorSku:[rateCard objectForKey:@"minor_sku_name"]];
        }
        
       
        
        
        self.data = [[NSMutableArray alloc] init];
        /*for (QuestionRateCard *minorSk in self.minorSkuArray)
        {
            NSMutableArray* section = [[NSMutableArray alloc] init];
            for (QuestionRateCard *sku in self.skuArray)
            {
                [section addObject:sku.sku_name];
            }
            [self.data addObject:section];
        }*/
        
        for(NSDictionary *minorSk in self.minorSkuArray)
        {
            NSMutableArray* section = [[NSMutableArray alloc] init];
            for (QuestionRateCard *sku in self.skuArray)
            {
                [section addObject:sku.sku_name];
            }
            [self.data addObject:section];
        }
        
        
        self.headers = [[NSMutableArray alloc] init];
        for (NSDictionary *minorSk in self.minorSkuArray)
        {
            UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
            UILabel* headerLbl = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 320, 40)];
            //headerLbl.text = minorSk.minor_sku_name;
            headerLbl.text = [minorSk objectForKey:@"minor_sku_name"];
            //headerView.backgroundColor = [UIColor orangeColor];
            headerView.backgroundColor =[UIColor colorWithRed:236.0f/255.0f  green:236.0f/255.0f blue:236.0f/255.0f alpha:1];
            
            
            [headerView addSubview:headerLbl];
            
            CGRect sepFrame = CGRectMake(8, headerView.frame.size.height-1, 360, 1);
            UIView *seperatorView = [[UIView alloc] initWithFrame:sepFrame];
            seperatorView.backgroundColor = [UIColor colorWithWhite:224.0/255.0 alpha:1.0];
            [headerView addSubview:seperatorView];
            

            UIImageView *plusBtnView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-40, 10, 20, 20)];
            plusBtnView.image = [UIImage imageNamed:@"ic-plus"];
            [headerView addSubview:plusBtnView];
            
            
            [self.headers addObject:headerView];
        }
        
        
    }
}
-(void)downloadBannerImg:(NSString*)url
{
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageBaseUrl,url]]];
    if (imgData){
        self.bannerImg.image = [UIImage imageWithData:imgData];
        self.bannerImg.contentMode = UIViewContentModeScaleAspectFill;
        [self.bannerImg setClipsToBounds:YES];
    }
    
}

-(void)updateSkuData
{
    self.data = [[NSMutableArray alloc] init];
    //for (QuestionRateCard *minorSk in self.minorSkuArray)
    for (NSDictionary *minorSk in self.minorSkuArray)
    {
        NSMutableArray* section = [[NSMutableArray alloc] init];
        for (QuestionRateCard *sku in self.skuArray)
        {
            [section addObject:sku.sku_name];
        }
        [self.data addObject:section];
    }
}

-(NSMutableArray*)fetchDataForMajorSku:(NSString*)majorSkuName
{
    NSMutableArray *array= [[NSMutableArray alloc] init];
    
    if([self.rateCardList count]>0)
    {
        for(QuestionRateCard *ratecard in self.rateCardList)
        {
            if([ratecard.major_sku_name isEqualToString:majorSkuName])
                    [array addObject:ratecard];
        }
    }
    return array;
}

-(NSMutableArray*)fetchDataForMajorSkuNew:(NSString*)majorSkuName
{
    NSMutableArray *array= [[NSMutableArray alloc] init];
    
    NSError *error;
    
    NSManagedObjectContext *context = [APPDELEGATE_SHARED_MANAGER managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"major_sku_name == %@",majorSkuName];
    [fetchRequest setPredicate:predicate];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"QuestionRateCard"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setResultType:NSDictionaryResultType];
    [fetchRequest setReturnsDistinctResults:YES];
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObject:@"minor_sku_name"]];
    
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    
    
    return [fetchedObjects mutableCopy];
}

-(NSArray*)fetchDataForMinorSkuFromDb : (NSString*)majorSkuName : (NSString*)minorSkuName : (NSString*)skuName
{
    NSMutableArray *array= [[NSMutableArray alloc] init];
    
    NSError *error;
    
    NSManagedObjectContext *context = [APPDELEGATE_SHARED_MANAGER managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //NSPredicate * predicate = [NSPredicate predicateWithFormat:@"major_sku_name == %@ && minor_sku_name == %@ && sku_name == %@",majorSkuName,minorSkuName,skuName];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"major_sku_name == %@ && minor_sku_name == %@ && category == %@",majorSkuName,minorSkuName,SHARED_DELEGATE.selectedServiceName];
    
    [fetchRequest setPredicate:predicate];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"QuestionRateCard"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects ;
}



-(NSMutableArray*)fetchDataForMinorSku:(NSString*)minorSkuName
{
    NSMutableArray *array= [[NSMutableArray alloc] init];
    
    if([self.rateCardList count]>0)
    {
        for(QuestionRateCard *ratecard in self.rateCardList)
        {
            if([ratecard.minor_sku_name isEqualToString:minorSkuName])
                [array addObject:ratecard];
        }
    }
    return array;
}


//- (void)setupViewController
//{
//   
//    NSArray* colors = @[[UIColor lightGrayColor],
//                        [UIColor orangeColor],
//                        [UIColor yellowColor],
//                        [UIColor greenColor],
//                        [UIColor blueColor],
//                        [UIColor purpleColor]
//                        ];
//    
//    
//    
//    self.data = [[NSMutableArray alloc] init];
//    for (int i = 0 ; i < [colors count] ; i++)
//    {
//        NSMutableArray* section = [[NSMutableArray alloc] init];
//        for (int j = 0 ; j < 3/*[quotesList count] */; j++)
//        {
//            [section addObject:[NSString stringWithFormat:@"Cell n°%i", j]];
//            //[section addObject:[quotesList objectAtIndex:j]];
//        }
//        [self.data addObject:section];
//    }
//    
//    self.headers = [[NSMutableArray alloc] init];
//    for (int i = 0 ; i < [colors count] ; i++)
//    {
//        UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
//        [header setBackgroundColor:[colors objectAtIndex:i]];
//        //UILabel* header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
//        //header.text = @"test";
//        
//        [self.headers addObject:header];
//    }
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[self.data objectAtIndex:section] count];
   
    //return [self.skuArray count];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
//    view.backgroundColor = [UIColor clearColor];
//    return view;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RateCardTableViewCell *cell = (RateCardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RateCardTableViewCell"];
    
    //QuestionRateCard *rateCar = [self.minorSkuArray objectAtIndex:indexPath.section];
    
//    NSDictionary *rateCarDict = [self.minorSkuArray objectAtIndex:indexPath.section];
//    NSArray *array = [self fetchDataForMinorSku:[rateCarDict objectForKey:@"minor_sku_name"]];
//    QuestionRateCard *rateCar;
//    if([array count]>0){
//        rateCar = [array objectAtIndex:0];
//        NSString *skuPrice = [NSString stringWithFormat:@"Rs.%@",rateCar.sku_price];
//        cell.skuLbl.text = rateCar.sku_name;
//        cell.skuPrice.text = skuPrice;
//    }
    cell.skuLbl.textColor = [UIColor lightGrayColor];
    cell.skuPrice.textColor = [UIColor lightGrayColor];
    cell.tickMarkImgView.image = [UIImage imageNamed:@"ic-select-blank"];
    
       NSString *rateCardN = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
       // cell.skuLbl.text = rateCardN;
    
    
    NSString *skuName = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSDictionary *rateCarDict = [self.minorSkuArray objectAtIndex:indexPath.section];
    NSArray *array = [self fetchDataForMinorSkuFromDb:SHARED_DELEGATE.selectedMajorSku:[rateCarDict objectForKey:@"minor_sku_name"]:skuName];
    QuestionRateCard *rateCar;
    if([array count]>0){
        rateCar = [array objectAtIndex:indexPath.row];
        cell.skuPrice.text = [NSString stringWithFormat:@"%@.%@",@"RS",rateCar.sku_price];
        cell.skuLbl.text = rateCar.sku_name;
        if([rateCar.added_cart isEqualToString:@"YES"])
            cell.tickMarkImgView.image = [UIImage imageNamed:@"ic-select-check"];
        else
            cell.tickMarkImgView.image = [UIImage imageNamed:@"ic-select-blank"];
        
    }
    
       // cell.textLabel.text = text;
    
        return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return [self.data count];

    
    //return [self.skuArray count];
   
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *aView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 55)];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 400, 55)];
    [btn setTag:section+1];
    [aView addSubview:btn];
    [btn addTarget:self action:@selector(sectionTapped:) forControlEvents:UIControlEventTouchDown];
    
    UIView *headerview = [self.headers objectAtIndex:section];
    //[headerview addSubview:btn];
    
    return headerview;
    //return [self.minorSkuArray objectAtIndex:section];
   
}

- (void)sectionTapped:(UIButton*)btn {
    
    
   //MinorSku *minorSk = [self.minorSkuArray objectAtIndex:btn.tag-1];
    
   // self.skuArray = [self fetchDataForMinorSku:minorSk.minorSkuName];

    //[self updateSkuData];
    
   // [self.rateCardTableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //QuestionRateCard *rateCar = [self.minorSkuArray objectAtIndex:indexPath.row];
   NSString *skuName = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSDictionary *rateCarDict = [self.minorSkuArray objectAtIndex:indexPath.section];
    NSArray *array = [self fetchDataForMinorSkuFromDb:SHARED_DELEGATE.selectedMajorSku:[rateCarDict objectForKey:@"minor_sku_name"]:skuName];
    QuestionRateCard *rateCar;
    if([array count]>0){
        rateCar = [array objectAtIndex:indexPath.row];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        RateCardDetailViewController *rateCardDetail = (RateCardDetailViewController*)[mainStoryboard
                                                                                       instantiateViewControllerWithIdentifier: @"RateCardDetailViewController"];
        rateCardDetail.receivedBanerImg = self.bannerImg.image;
        rateCardDetail.rateCardObj = rateCar;
        
        [[SlideNavigationController sharedInstance] pushViewController:rateCardDetail animated:NO];
    }
    
}

-(IBAction)continueAction:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    RateCardOrderSummaryViewController *rateOrderSummary = (RateCardOrderSummaryViewController*)[mainStoryboard
                                                                                   instantiateViewControllerWithIdentifier: @"RateCardOrderSummaryViewController"];
    rateOrderSummary.minimumOrderVal = minimumOrder;
    
    //rateOrderSummary.rateCardList = self.rateCardList;
    
    rateOrderSummary.receivedBanerImg = self.bannerImg.image;
    
    [[SlideNavigationController sharedInstance] pushViewController:rateOrderSummary animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
