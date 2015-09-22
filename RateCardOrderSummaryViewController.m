//
//  RateCardOrderSummaryViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 13/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "RateCardOrderSummaryViewController.h"
#import "LocalOyeConstants.h"
#import "QuestionsViewController.h"
#import "PickerViewController.h"
#import "RateCardTableViewCell.h"
#import "QuestionsViewController.h"

@interface RateCardOrderSummaryViewController ()

@end

@implementation RateCardOrderSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.continueBtn setBackgroundColor:[UIColor orangeColor]];
    [self.continueBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    [self.headerTitle setFont:[UIFont fontWithName:kLocalOyeFontMedium size:18.0]];
    
    [self fetchRateCardData];
    
    
    
    if([self.rateCardList count]>0)
        self.continueBtn.enabled = TRUE;
    else
        self.continueBtn.enabled = FALSE;
    [self calculateTotalval];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.bannerImg.image = self.receivedBanerImg;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [self.rateCardList count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeViewTableViewCell"];
    
    RateCardTableViewCell *cell = (RateCardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RateCardTableViewCell"];
    
    
    QuestionRateCard *rateCard = [self.rateCardList objectAtIndex:indexPath.row];
    
    cell.skuLbl.text= rateCard.sku_name;
    cell.skuPrice.text= rateCard.sku_price;
    
    
    
    [cell setTintColor:[UIColor orangeColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //lastIndexPath = indexPath;
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(IBAction)nextBtnAction:(id)sender
{
    
    
}

-(void)calculateTotalval
{
    totalVal = 0;
    
    for (QuestionRateCard *rateCard in self.rateCardList) {
        NSInteger price = [rateCard.sku_price integerValue];
        totalVal = totalVal + price;
    }
    NSLog(@"total val %ld",totalVal);
    
    self.totalval.text = [NSString stringWithFormat:@"RS.%ld",totalVal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchRateCardData
{
    self.rateCardList = [APPDELEGATE_SHARED_MANAGER retrieveAddedSkus:SHARED_DELEGATE.selectedServiceName];
    //self.data = [quotesList mutableCopy];
}


-(IBAction)continueAction:(id)sender
{
   
    NSInteger minimumOrdervalue = [self.minimumOrderVal integerValue];
    
    if(totalVal>=minimumOrdervalue)
    {
    self.rateCardList = [APPDELEGATE_SHARED_MANAGER retrieveAddedSkus:SHARED_DELEGATE.selectedServiceName];

    self.questionArrayList = [APPDELEGATE_SHARED_MANAGER retrieveQuestionForServiceCategory:SHARED_DELEGATE.selectedServiceName];
    

    if([self.questionArrayList count]>0){
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        QuestionsViewController *questionView = (QuestionsViewController*)[mainStoryboard
                                                                           instantiateViewControllerWithIdentifier: @"QuestionsViewController"];
        
        questionView.questionList = self.questionArrayList;
        
        [[SlideNavigationController sharedInstance] pushViewController:questionView animated:NO];
    }
    else{
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        PickerViewController *pickerView = (PickerViewController*)[mainStoryboard
                                                                           instantiateViewControllerWithIdentifier: @"PickerViewController"];
        
        [[SlideNavigationController sharedInstance] pushViewController:pickerView animated:NO];
    }
    }
    else{
        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:[NSString stringWithFormat:@"%@%ld",@"Minimum order value should be Rs.",(long)minimumOrdervalue]  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [wsAlert show];
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
