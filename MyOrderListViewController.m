//
//  MyOrderListViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 25/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "MyOrderListViewController.h"
#import "OrderListTableViewCell.h"
#import "LocalOyeConstants.h"
#import "RequestResposeHandler.h"
#import "QuotesAwaitingViewController.h"
#import "QuotesViewController.h"
#import "Quotes.h"

#import "MyOrder.h"
#import "MerchantOnlineQuoteViewController.h"

@interface MyOrderListViewController ()

@end

@implementation MyOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    //self.navigationController.navigationBar.backItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    if(SHARED_DELEGATE.userID.length>0){
        [self addProgressIndicator];
    }
    
        
    
    self.view.backgroundColor =[UIColor colorWithRed:236.0f/255.0f  green:236.0f/255.0f blue:236.0f/255.0f alpha:1];
    
//    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
//
//    [self.navigationItem setLeftBarButtonItem:back];
//    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"ic-arrow-left"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
    
}

- (void)goBack
{
    if(self.viewFromOrderSummary){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
        
        UIViewController *vc ;
        
        vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
        
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                 withSlideOutAnimation:YES
                                                                         andCompletion:nil];
        
   
        
        //[self.navigationController popViewControllerAnimated:NO];
    }
    else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //if([cityList count]>0)
    //    self.nextBtn.enabled = YES;
    
    return [myOrderList count];
    //return 1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10; // you can have your own choice, of course
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [myOrderList count]; // in your case, there are 3 cells
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeViewTableViewCell"];
    
    OrderListTableViewCell *cell = (OrderListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"OrderListTableViewCell"];
    
    
    //if(indexPath.row == 0 && (cell.accessoryType == UITableViewCellAccessoryNone))
    //    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    //cell.backgroundColor = [UIColor clearColor];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MyOrder *myOrderObj = [myOrderList objectAtIndex:indexPath.row];
    
    if([myOrderObj.status_text isEqualToString:@"Booking confirmed"])
       cell.loadingImg.image = [UIImage imageNamed:@"ic-select-check"];
    else
       cell.loadingImg.image = [UIImage imageNamed:@"loadingIcon.png"];
    
    
    cell.categoryImg.image = [UIImage imageNamed:@"defaultTableCellIcon.png"]; // or cell.poster.image = [UIImage imageNamed:@"placeholder.png"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.localoye.MyQueue1", NULL);
    
    dispatch_async(queue, ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageBaseUrl,myOrderObj.category_icon]]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    OrderListTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.categoryImg.image = image;
                });
            }
        }
    });
    
    //cell.categoryImg.image = []
    
    cell.categoryNameLbl.text = myOrderObj.category;
    cell.orderDateLbl.text = myOrderObj.created_at;
    cell.awaitingResponseLbl.text = myOrderObj.status_text;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    [cell.layer setBorderWidth:2.0f];
    cell.layer.borderColor = [[UIColor whiteColor] CGColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyOrder *myOrderObj = [myOrderList objectAtIndex:indexPath.row];
    
    if([myOrderObj.no_of_quotes isEqualToNumber:[NSNumber numberWithInt:0]]){
    
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
        QuotesAwaitingViewController *quotesAwaitingView = (QuotesAwaitingViewController*)[mainStoryboard
                                                                                  instantiateViewControllerWithIdentifier: @"QuotesAwaitingViewController"];
    
        quotesAwaitingView.myOrderObj= myOrderObj;
        
        [[SlideNavigationController sharedInstance] pushViewController:quotesAwaitingView animated:NO];
    }
    else if([myOrderObj.category_type isEqualToString:@"Online"]){
        NSLog(@"");
         UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        MerchantOnlineQuoteViewController *merchantView = (MerchantOnlineQuoteViewController*)[mainStoryboard
                                                                                               instantiateViewControllerWithIdentifier: @"MerchantOnlineQuoteViewController"];
        
        
        merchantView.myOderObject = myOrderObj;
        [[SlideNavigationController sharedInstance] pushViewController:merchantView animated:NO];
        
    }
    else{
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        QuotesViewController *quotesView = (QuotesViewController*)[mainStoryboard
                                                                                    instantiateViewControllerWithIdentifier: @"QuotesViewController"];
        
        NSArray *quote = [myOrderObj.quotes allObjects];
        
        if([quote count]>0)
        {
            Quotes *quoteData = [quote objectAtIndex:0];
            quotesView.leadID =quoteData.lead_id;
        }else{
            quotesView.leadID = myOrderObj.booking_id;
        }
        
        quotesView.myOrderObj = myOrderObj;
        [[SlideNavigationController sharedInstance] pushViewController:quotesView animated:NO];
    }

}
-(void) initiateQuoteService
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addProgressIndicator
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(initiateMyOrderListAPI) onTarget:self withObject:nil animated:YES];
    
   
}

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    [self initiateMyOrderListAPI];
    sleep(3);
}


-(void)initiateMyOrderListAPI
{
    
    if([APPDELEGATE_SHARED_MANAGER isConnected]){
        
        [RequestResposeHandler GetMyOrderListingService:SHARED_DELEGATE.selectedServiceName :^(BOOL success, NSString *error){ //need to use error appropriatly according to service for alerts.
            
            if (success)
            {
                NSLog(@"sucess");
                //[APPDELEGATE_SHARED_MANAGER clearFeedData];
                [self fetchMyOrderListData];
                //[APPDELEGATE_SHARED_MANAGER dismissGlobalHUD];
                [self.tableView reloadData];
                
                //[self launchSlideViewController];
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


-(void)fetchMyOrderListData
{
    myOrderList = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"MyOrder"];
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
