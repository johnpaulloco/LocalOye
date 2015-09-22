//
//  LocationViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 18/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "LocationViewController.h"
#import "NexmoOTPViewController.h"
#import "LocalOyeConstants.h"
#import "VerifyNumber.h"
#import "PersonalDetailsViewController.h"
#import "PromoCodeViewController.h"


@interface LocationViewController ()

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.headerTitle.font = [UIFont fontWithName:kLocalOyeFontMedium size:18.0];
    self.localityTitle.font = [UIFont fontWithName:kLocalOyeFontLight size:12.0];
    self.nearestLocalTitle.font = [UIFont fontWithName:kLocalOyeFontLight size:14.0];
    
    
     [self.nextBtn setBackgroundColor:[UIColor orangeColor]];
   
    [self.nextBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.backItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest ;
//    [locationManager startUpdatingLocation];
//    locationManager.delegate = self;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
    
    if([APPDELEGATE_SHARED_MANAGER isConnected])
        [self findAddressWithLatLong:nil];
    //[self findAddressWithUserText];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.bannerImg.image = SHARED_DELEGATE.receivedBannerImg;
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


-(void)getAddressFromLocation:(CLLocation *)location complationBlock:(addressCompletion)completionBlock
{
    __block CLPlacemark* placemark;
    __block NSString *address = nil;
    
    CLGeocoder* geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error == nil && [placemarks count] > 0)
         {
             placemark = [placemarks lastObject];
             address = [NSString stringWithFormat:@"%@, %@ %@", placemark.name, placemark.postalCode, placemark.locality];
             completionBlock(address);
         }
     }];
}


-(void)findAddressWithUserText
{
    NSArray *separatedData = [locationEntered componentsSeparatedByString:@" "];
    NSString *joinedString = [separatedData componentsJoinedByString:@"+"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",@"https://maps.googleapis.com/maps/api/geocode/json?address=",joinedString];
    
    //NSString *urlString = @"https://maps.googleapis.com/maps/api/geocode/json?address=kora mangala&region=in";

//    NSString *urlString = @"https://maps.googleapis.com/maps/api/geocode/json?address=Toledo&region=es&key=API_KEY";
    

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
    
    if (debug && response) {
        NSLog(@"Address from user text >>>> %@",response);
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
    self.textFieldLocation.text = self.retrievedAddress;
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
    
    
//    CLLocation* eventLocation = [[CLLocation alloc] initWithLatitude:currentLat longitude:currentLong];
//    
//    [self getAddressFromLocation:eventLocation complationBlock:^(NSString * address) {
//        if(address) {
//            //_address = address;
//            NSLog(@"Address %@",address);
//        }
//    }];

     
}

-(BOOL)isPhoneNumberVerified{
    
    BOOL ret = FALSE;
    NSArray *array = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"VerifyNumber"];
    
    if([array count]>0)
    {
        VerifyNumber *verifyNoObj = [array objectAtIndex:0];
        if([verifyNoObj.isVerified isEqualToString:kYesString])
            ret = TRUE;
    }
    return ret;
}

-(IBAction)nextBtnAction:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    PromoCodeViewController *promoCodeView = (PromoCodeViewController*)[mainStoryboard
                                                                        instantiateViewControllerWithIdentifier: @"PromoCodeViewController"];
    
    //pickerView.questionObj = self.questionObj;
    [[SlideNavigationController sharedInstance] pushViewController:promoCodeView animated:NO];
    

    
//    if([self isPhoneNumberVerified]){
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    
//        PersonalDetailsViewController *personalDetailView = (PersonalDetailsViewController*)[mainStoryboard
//                                                                     instantiateViewControllerWithIdentifier: @"PersonalDetailsViewController"];
//    
//    
//        [[SlideNavigationController sharedInstance] pushViewController:personalDetailView animated:NO];
//    }
//    else{
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//        
//        NexmoOTPViewController *nexmoView = (NexmoOTPViewController*)[mainStoryboard
//                                                                      instantiateViewControllerWithIdentifier: @"NexmoOTPViewController"];
//        
//        
//        [[SlideNavigationController sharedInstance] pushViewController:nexmoView animated:NO];
//    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    //mobileNo = (long)[self.textFieldMobileNo.text intValue];
    
    NSString *location = self.textFieldLocation.text;
    
    locationEntered = location;
    NSLog(@"entered %@",location);
    [self.textFieldLocation resignFirstResponder];
    
    [self findAddressWithUserText];
    
    NSLog(@"textFieldDidEndEditing");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:");
    [textField resignFirstResponder];
    return YES;
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
