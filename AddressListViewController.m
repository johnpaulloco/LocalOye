//
//  AddressListViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 18/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "AddressListViewController.h"
#import "AddressListTableViewCell.h"
#import "PromoCodeViewController.h"
#import "LocalOyeConstants.h"
#import "Address.h"
#import "AddEditAddressViewController.h"

@interface AddressListViewController ()

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.addAddresBtn.backgroundColor = [UIColor orangeColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    addressList = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"Address"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [addressList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeViewTableViewCell"];
    
    AddressListTableViewCell *cell = (AddressListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AddressListTableViewCell"];
    
    Address *addressObj = (Address*)[addressList objectAtIndex:indexPath.row];
    
    cell.addressType.text = addressObj.addressType;
    cell.address.text = addressObj.location;
    cell.address.text = addressObj.location;
    
    //cell.backgroundColor = [UIColor lightGrayColor];
    
    [cell setTintColor:[UIColor orangeColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    [self triggerPromoPage];
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

-(void)triggerPromoPage
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    PromoCodeViewController *promoView = (PromoCodeViewController*)[mainStoryboard
                                                          instantiateViewControllerWithIdentifier: @"PromoCodeViewController"];
    
    [[SlideNavigationController sharedInstance] pushViewController:promoView animated:NO];
    
}
-(IBAction)nextBtnAction:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    AddEditAddressViewController *addAddress = (AddEditAddressViewController*)[mainStoryboard
                                                                    instantiateViewControllerWithIdentifier: @"AddEditAddressViewController"];
    
    [[SlideNavigationController sharedInstance] pushViewController:addAddress animated:NO];
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
