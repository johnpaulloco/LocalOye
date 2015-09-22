//
//  AddEditAddressViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 17/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "AddEditAddressViewController.h"
#import "LocalOyeConstants.h"
#import "AddressListViewController.h"
#import "ListViewController.h"
#import "Address.h"

@interface AddEditAddressViewController ()

@end

@implementation AddEditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.location = @"";
    self.houseNo = @"";
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.addAdrressBtn.backgroundColor = [UIColor orangeColor];
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.country =SHARED_DELEGATE.selectedCountry;
    self.state =SHARED_DELEGATE.selectedState;
    self.city =SHARED_DELEGATE.selectedCity;
    
    [self.tableViewObj reloadData];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 6;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    // Make cell unselectable
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.font = [UIFont fontWithName:kLocalOyeFontLight size:13.0];
    
    UITextField* tf = nil ;
    UIButton* btn = nil ;
    switch ( indexPath.row ) {
        case 0: {
            cell.textLabel.text = @"Address Type" ;
            tf = addressTypeField_ = [self makeTextField:self.addresType placeholder:@"Enter address type"];
            [cell addSubview:addressTypeField_];
            break ;
        }
        case 1: {
            cell.textLabel.text = @"Country" ;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            tf = country_ = [self makeTextField:self.country placeholder:@""];
            tf.userInteractionEnabled = NO;
            [cell addSubview:country_];
            
            break ;
        }
        case 2: {
            cell.textLabel.text = @"State" ;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            tf = state_ = [self makeTextField:self.state placeholder:@""];
            tf.userInteractionEnabled = NO;
            [cell addSubview:state_];
            break ;
        }
        case 3: {
            cell.textLabel.text = @"City" ;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            tf = city_ = [self makeTextField:self.city placeholder:@""];
            tf.userInteractionEnabled = NO;
            [cell addSubview:city_];
            
            break ;
        }

        case 4: {
            cell.textLabel.text = @"House/Office No" ;
            
            tf = houseNoField_ = [self makeTextField:self.houseNo placeholder:@"Enter house no"];
            [cell addSubview:houseNoField_];
            
            break ;
        }
        
        case 5: {
            cell.textLabel.text = @"Location" ;
            tf = locationField_ = [self makeTextField:self.location placeholder:@""];
            [cell addSubview:locationField_];
            tf.userInteractionEnabled = NO;
            
            btn = [self makeBtnField:@"Detect Location" placeholder:@""];
            [cell addSubview:btn];
            break ;
        }
            
    }
    
    // Textfield dimensions
    
    tf.frame = CGRectMake(180, 8, 130, 40);
    
    // Workaround to dismiss keyboard when Done/Return is tapped
    [tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    // We want to handle textFieldDidEndEditing
    tf.delegate = self ;
    
    return cell;
}

-(UIButton*) makeBtnField: (NSString*)text
              placeholder: (NSString*)placeholder  {
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(self.view.frame.size.width-100, 4, 90, 35)];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontBold size:9.0]];
    
    btn.backgroundColor = [UIColor clearColor];
    //[btn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    
    [btn addTarget:self action:@selector(detectLocation:) forControlEvents:UIControlEventTouchDown];
    
    return btn ;
}

-(IBAction)detectLocation:(id)sender
{
    if([APPDELEGATE_SHARED_MANAGER isConnected] && SHARED_DELEGATE.cusLatitude.length>0 && SHARED_DELEGATE.cusLongitude.length>0){
        [self findAddressWithLatLong:nil];
    }
    else{
        
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


-(UITextField*) makeTextField: (NSString*)text
                  placeholder: (NSString*)placeholder  {
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = placeholder ;
    tf.text = text ;
    tf.autocorrectionType = UITextAutocorrectionTypeNo ;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.adjustsFontSizeToFitWidth = YES;
    tf.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    return tf ;
}

// Workaround to hide keyboard when Done is tapped
- (IBAction)textFieldFinished:(id)sender {
    // [sender resignFirstResponder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
// Textfield value changed, store the new value.
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ( textField == addressTypeField_) {
        self.addresType = textField.text ;
        [addressTypeField_ nextResponder];
    } else if ( textField == houseNoField_ ) {
        self.houseNo = textField.text ;
    } else if ( textField == country_) {
        self.country = textField.text ;
    } else if ( textField == locationField_ ) {
        self.location = textField.text ;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"test");
    
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    ListViewController *orderView = (ListViewController*)[mainStoryboard
                                                                        instantiateViewControllerWithIdentifier: @"ListViewController"];
    
    if(indexPath.row == 0)
    {
        
    }
    else if(indexPath.row == 1)
    {
            orderView.viewType = @"Country";
        [[SlideNavigationController sharedInstance] pushViewController:orderView animated:NO];
    }
    else if(indexPath.row == 2){
            orderView.viewType = @"State";
        [[SlideNavigationController sharedInstance] pushViewController:orderView animated:NO];
    }
    else if(indexPath.row == 3)
    {
            orderView.viewType = @"CityData";
        [[SlideNavigationController sharedInstance] pushViewController:orderView animated:NO];
    }
    
    
}


-(IBAction)addAddress:(id)sender
{
    
    
    
    
    if(addressTypeField_.text.length>0 && houseNoField_.text.length>0 && country_.text.length>0  && state_.text.length>0 && city_.text.length>0)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:self.addresType forKey:@"addressType"];
        [dict setObject:SHARED_DELEGATE.selectedCountryId forKey:@"countryId"];
        [dict setObject:SHARED_DELEGATE.selectedStateId forKey:@"stateId"];
        [dict setObject:SHARED_DELEGATE.selectedCityId forKey:@"cityId"];
        [dict setObject:self.houseNo forKey:@"houesNo"];
        [dict setObject:self.location forKey:@"location"];
        [dict setObject:SHARED_DELEGATE.selectedCountry forKey:@"countryName"];
        [dict setObject:SHARED_DELEGATE.selectedState forKey:@"stateName"];
        [dict setObject:SHARED_DELEGATE.selectedCity forKey:@"cityName"];
        
        
        [APPDELEGATE_SHARED_MANAGER insertAddressData:dict];
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
//        AddressListViewController *orderView = (AddressListViewController*)[mainStoryboard
//                                                                            instantiateViewControllerWithIdentifier: @"AddressListViewController"];
//        
//        
//        [[SlideNavigationController sharedInstance] pushViewController:orderView animated:NO];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else{
        
        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter the required data"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [wsAlert show];
    }
}

-(IBAction)findAddressWithLatLong:(id)sender
//-(void)findAddressWithLatLong
{
    //[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/xml?location=%@,%@&radius=%@&name=
    //%@&sensor=false&key=YOU-API-KEY",currentLat,currentLong,appDeleg.strRadius,strSelectedCategory]
    
    //[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=12.943166,77.621885&sensor=true_or_false"]];
    
    NSString *urlString = @"http://maps.googleapis.com/maps/api/geocode/json?latlng=12.943166,77.621885&sensor=true_or_false";
    
    NSLog(@"urlString %@",urlString);
    
    NSData *returnData = [[NSData alloc]init];
    
    //Build the Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    //[request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //Send the Request
    returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    
    //Get the Result of Request
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    
    bool debug = YES;
    
    if (debug && response && returnData != nil) {
        NSLog(@"Address >>>> %@",response);
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:returnData
                                                             options:kNilOptions
                                                               error:&error];
        NSString *status = [json objectForKey:@"status"];
        if([status isEqualToString:@"OK"]){
            NSArray* results = [json objectForKey:@"results"];
            for(NSDictionary *data in results)
            {
                NSLog(@"data %@",[data objectForKey:@"formatted_address"]);
                self.retrievedAddress =[data objectForKey:@"formatted_address"];
                [self refreshRetrievedAddress];
                break;
            }
            //NSLog(@"results: %@", results);
        }
        
        
    }
    
}

-(void)refreshRetrievedAddress
{
    self.location = self.retrievedAddress;
    [self.tableViewObj reloadData];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    currentLat=newLocation.coordinate.latitude; // string value
    currentLong=newLocation.coordinate.longitude;
    //appDeleg.newlocation=newLocation;
    //12.943166
    //77.621885
    [locationManager stopUpdatingLocation]; // string Value
    
    SHARED_DELEGATE.cusLatitude = [NSString stringWithFormat:@"%f",currentLat];
    SHARED_DELEGATE.cusLongitude = [NSString stringWithFormat:@"%f",currentLat];
    
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
