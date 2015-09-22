//
//  ServiceDetailViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 13/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "ServiceDetailViewController.h"
#import "LocalOyeConstants.h"
#import "ServiceDetailViewTableViewCell.h"
#import "QuestionsViewController.h"
#import "RateCardViewController.h"
#import "PickerViewController.h"

@interface ServiceDetailViewController ()

@end

@implementation ServiceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    //UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    //[self.navigationItem setLeftBarButtonItem:back];
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"ic-arrow-left"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
    
    [self.letGoBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    

}
- (void)goBack
{
    NSLog(@"pop");
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    ChildCategory *childCat = self.childCat;
    
    NSArray *headerArray = [childCat.landing_header componentsSeparatedByString:@"|"];
    NSArray *headerContent = [childCat.landing_content componentsSeparatedByString:@"|"];
    
    [[SlideNavigationController sharedInstance].navigationController popViewControllerAnimated:NO];
    UIImage *image = [UIImage imageNamed:@"Cook-Offer"];
    //UIImage *newImg = [APPDELEGATE_SHARED_MANAGER imageWithColor:[UIColor redColor]:image];
    self.serviceImage.image = image;
    
    
    self.serviceHeader.font = [UIFont fontWithName:kLocalOyeFontMedium size:24.0];
    self.serviceDesc.font = [UIFont fontWithName:kLocalOyeFontMedium size:12.0];
    
    
    if([headerArray count]>0)
        self.serviceHeader.text= [headerArray objectAtIndex:0];
    
    if([headerArray count]>1)
        self.serviceDesc.text= [headerArray objectAtIndex:1];
        //@"The smartest way to complete a service booking request it's easy and takes only seconds";
    
    if([headerContent count]>0)
        self.serviceCoveredList = headerContent;
        //[NSArray arrayWithObjects:@"We assign best matching service expert",@"Every expert is high quality and verfied",@"Say goodbye to phone calls",@"Chat with our support centre for help", nil];
    
    if([APPDELEGATE_SHARED_MANAGER isConnected])
    {
        if(childCat.banner.length>0)
            [self downloadBannerImg:childCat.banner];
    }
    else
    {
        self.bannerImg.image = nil;
        self.bannerImg.backgroundColor =kOfflineBGColor;
    }
    
    [self.letGoBtn setBackgroundColor:[UIColor orangeColor]];
    
}

-(void)downloadBannerImg:(NSString*)url
{
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageBaseUrl,url]]];
    if (imgData){
        self.bannerImg.image = [UIImage imageWithData:imgData];
        self.bannerImg.contentMode = UIViewContentModeScaleAspectFill;
        [self.bannerImg setClipsToBounds:YES];
        
        SHARED_DELEGATE.receivedBannerImg = self.bannerImg.image;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return  1;
//}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = NSLocalizedString(@"We have you covered", @"We have you covered");
    return sectionName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.serviceCoveredList count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeViewTableViewCell"];
    
    ServiceDetailViewTableViewCell *cell = (ServiceDetailViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ServiceDetailViewTableViewCell"];
    
    cell.serviceDesc.font = [UIFont fontWithName:kLocalOyeFontMedium size:10.0];
    
    [[cell contentView] setBackgroundColor:[UIColor clearColor]];
    [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.serviceDesc.textColor = [UIColor whiteColor];
    cell.serviceDesc.numberOfLines = 3;
    //cell.serviceDesc.font =[UIFont boldSystemFontOfSize:10];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.backgroundColor = [UIColor clearColor];
    
    if([self.serviceCoveredList count]>0)
    {
        //ChildCategory *service = [self.serviceCoveredList objectAtIndex:indexPath.row];
        
        cell.serviceDesc.text = [self.serviceCoveredList objectAtIndex:indexPath.row];
        //cell.arrowImg.image = [UIImage imageNamed:@"arrowImgCell"];
        
    }
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    
//    ServiceDetailViewController *serviceView = (ServiceDetailViewController*)[mainStoryboard
//                                                                              instantiateViewControllerWithIdentifier: @"ServiceDetailViewController"];
//    
//    
//    [[SlideNavigationController sharedInstance] pushViewController:serviceView animated:YES];
    
}

- (BOOL)navigationController:(UINavigationController *)navigationController
     shouldPopViewController:(UIViewController *)controller pop:(void(^)())pop
{
    NSLog(@"pop");
    return YES;
}

-(BOOL)isRateCardAvailable
{
    NSLog(@"SHARED_DELEGATE.selectedServiceHeader %@",SHARED_DELEGATE.selectedServiceHeader);
    
    BOOL ret = FALSE;
    //NSArray *data = [APPDELEGATE_SHARED_MANAGER retrieveModelDataWithPredicate:@"QuestionRateCard":@"category":SHARED_DELEGATE.selectedServiceHeader];
    NSArray *data = [APPDELEGATE_SHARED_MANAGER retrieveModelDataWithPredicate:@"QuestionRateCard":@"category":SHARED_DELEGATE.selectedServiceName];
    if([data count]>0)
        ret = TRUE;
    
    return ret;
}

-(IBAction)letsProceed:(id)sender
{
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    PickerViewController *questionView = (PickerViewController*)[mainStoryboard
//                                                                       instantiateViewControllerWithIdentifier: @"PickerViewController"];
//    [[SlideNavigationController sharedInstance] pushViewController:questionView animated:NO];
//    
    isRateCardDataAvailable = [self isRateCardAvailable];
    
    if(isRateCardDataAvailable){
        
        //[APPDELEGATE_SHARED_MANAGER insertRateCard];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        RateCardViewController *rateCardView = (RateCardViewController*)[mainStoryboard
                                                                           instantiateViewControllerWithIdentifier: @"RateCardViewController"];
        [[SlideNavigationController sharedInstance] pushViewController:rateCardView animated:NO];
    }
    else
    {
        questionArrayList = [APPDELEGATE_SHARED_MANAGER retrieveQuestionForServiceCategory:SHARED_DELEGATE.selectedServiceName];
        
        if([questionArrayList count]>0){
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            
            QuestionsViewController *questionView = (QuestionsViewController*)[mainStoryboard
                                                                               instantiateViewControllerWithIdentifier: @"QuestionsViewController"];
            
            questionView.questionList = questionArrayList;
            
            [[SlideNavigationController sharedInstance] pushViewController:questionView animated:NO];
        }
        else{
            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Internet connection appears to be offline"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [wsAlert show];
        }
    }
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
