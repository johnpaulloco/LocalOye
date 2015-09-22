//
//  ListViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 20/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewCell.h"
#import "LocalOyeConstants.h"
#import "Country.h"
#import "States.h"
#import "CityData.h"
#import "RequestResposeHandler.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listData = [[NSMutableArray alloc] init];
    
    if([self.viewType isEqualToString:@"Country"]){
         array  = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"Country"];
            for (Country *data in array) {
                [self.listData addObject:data.country_name];
            }
    }
    else if([self.viewType isEqualToString:@"State"]){
        [self getMasterStateData];
        array  = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"States"];
        for (States *data in array) {
            [self.listData addObject:data.state_name];
        }
    }
    else if([self.viewType isEqualToString:@"CityData"]){
        [self getMasterCityData];
        array  = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"CityData"];
        for (CityData *data in array) {
            [self.listData addObject:data.city_name];
        }
    }
        
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = (ListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell"];
    
    if([self.viewType isEqualToString:@"Country"]){
        Country *countryObj = [array objectAtIndex:indexPath.row];
        cell.textLabel.text = countryObj.country_name;
    }
    else if([self.viewType isEqualToString:@"State"]){
        States *stateObj = [array objectAtIndex:indexPath.row];
        cell.textLabel.text = stateObj.state_name;
    }
    else if([self.viewType isEqualToString:@"CityData"]){
        CityData *cityObj = [array objectAtIndex:indexPath.row];
        cell.textLabel.text = cityObj.city_name;
    }
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.viewType isEqualToString:@"Country"]){
        Country *countryObj = [array objectAtIndex:indexPath.row];
        SHARED_DELEGATE.selectedCountry = countryObj.country_name;
        SHARED_DELEGATE.selectedCountryId = countryObj.country_id;
    }
    else if([self.viewType isEqualToString:@"State"]){
        States *stateObj = [array objectAtIndex:indexPath.row];
        SHARED_DELEGATE.selectedState = stateObj.state_name;
        SHARED_DELEGATE.selectedStateId = stateObj.state_id;
    }
    else if([self.viewType isEqualToString:@"CityData"]){
        CityData *cityObj = [array objectAtIndex:indexPath.row];
        SHARED_DELEGATE.selectedCity = cityObj.city_name;
        SHARED_DELEGATE.selectedCityId = cityObj.city_id;
    }
    
    [self.navigationController popViewControllerAnimated:NO];
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
-(IBAction)nextBtnAction:(id)sender
{
    
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
