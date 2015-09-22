//
//  RateCardDetailViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 13/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "RateCardDetailViewController.h"
#import "RateCardDetailTableViewCell1.h"
#import "RateCardDetailTableViewCell2.h"
#import "LocalOyeConstants.h"

@interface RateCardDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation RateCardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    list1 = [[NSMutableArray alloc] init];
    list2 = [[NSMutableArray alloc] init];
    
    [list1 addObject:@"1"];
    [list1 addObject:@"2"];
    
    [list2 addObject:@"3"];
    [list2 addObject:@"4"];
    
    [self.addToCardBtn setBackgroundColor:[UIColor orangeColor]];
    
    self.tableviewDetail.hidden = YES;
    self.tableviewService.hidden = YES;
    
    if([self.rateCardObj.added_cart isEqualToString:kYesString])
       [self.addToCardBtn setTitle:@"REMOVE FROM CART" forState:UIControlStateNormal];
    else
       [self.addToCardBtn setTitle:@"ADD TO CART" forState:UIControlStateNormal];
    
    self.titleLbl.text = self.rateCardObj.sku_name;
    self.descTextView.userInteractionEnabled = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.bannerImg.image = self.receivedBanerImg;
    
    self.descTextView.text = self.rateCardObj.descriptionStr;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.tableviewDetail == tableView)
        return [list1 count];
    else
        return [list2 count];
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
    if(self.tableviewDetail == tableView){
        
        RateCardDetailTableViewCell1 *cell1 = (RateCardDetailTableViewCell1 *)[tableView dequeueReusableCellWithIdentifier:@"RateCardDetailTableViewCell1"];
        
        //QuotesList *quoteListObj = [quotesList objectAtIndex:indexPath.row];
        
        cell1.textLabel.text = [list1 objectAtIndex:indexPath.row];
        
        return cell1;
    }
    else{
        
        RateCardDetailTableViewCell2 *cell2 = (RateCardDetailTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:@"RateCardDetailTableViewCell2"];
        
        //QuotesList *quoteListObj = [quotesList objectAtIndex:indexPath.row];
        
        cell2.textLabel.text = [list2 objectAtIndex:indexPath.row];
    
        return cell2;
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(IBAction)addToCart:(id)sender
{
    if([self.rateCardObj.added_cart isEqualToString:kYesString])
        [APPDELEGATE_SHARED_MANAGER updateRateCardData:self.rateCardObj : kNoString];
    else
        [APPDELEGATE_SHARED_MANAGER updateRateCardData:self.rateCardObj : kYesString];
        
    [self.navigationController popViewControllerAnimated:NO];
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
