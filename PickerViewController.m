//
//  PickerViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 18/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "PickerViewController.h"
#import "LocalOyeConstants.h"
#import "LocationViewController.h"
#import "SignUpViewController.h"
#import "LoginDetailViewController.h"

#import "AddressListViewController.h"
#import "SignUpDetails.h"

@interface PickerViewController ()

@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:1];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    
    [self.datePicker setMinimumDate: [NSDate date]];
     [self.datePicker setMaximumDate:maxDate];
    
    todayStartTime = 12;
    todayEndTime = 19;
    
    self.headerTitle.font = [UIFont fontWithName:kLocalOyeFontMedium size:18.0];
    self.nextBtn.backgroundColor = [UIColor orangeColor];
    [self.nextBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
     [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *today = [NSDate date];
    NSString *formatedTodayDate = [dateFormatter stringFromDate:today];
    selectedDate = formatedTodayDate;
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    //self.timePicker.datePickerMode = UIDatePickerModeTime;
    
    if(![APPDELEGATE_SHARED_MANAGER isConnected])
        [self.bannerImg setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"OfflineBGImg"]]];
    
    
    pickerData1 = [[NSMutableArray alloc] init];
    pickerData2 = [[NSMutableArray alloc] init];
    
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    components.timeZone = [NSTimeZone localTimeZone];
    components.hour =  14;
    components.minute = 30;
    components.second = 0;
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    NSLog(@"formatedTodayDate -->%@",formatedTodayDate);
    NSString *newDteStr = [NSString stringWithFormat:@"%@",formatedTodayDate];
    todayDateStr=[newDteStr substringWithRange: NSMakeRange(0,10)];
    todayTimeStr=[newDteStr substringWithRange: NSMakeRange(11,2)];
    
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    for (int i=1; i<24; i++) {
        
        NSUInteger seconds = (3600 * i);
        NSDate *newDate= [NSDate dateWithTimeInterval:seconds sinceDate:date];
        NSLog(@"newDate = %@", newDate);
        NSString *newDateStr = [NSString stringWithFormat:@"%@",newDate];
        NSLog(@"newDateStr = %@", newDateStr);
        
        NSString *dateStr=[newDateStr substringWithRange: NSMakeRange(0,10)];
        NSString *timeStr=[newDateStr substringWithRange: NSMakeRange(11,2)];
        
        [pickerData1 addObject:dateStr];
        
        
        NSLog(@"dateStr = %@", dateStr);
        NSLog(@"timeStr = %@", timeStr);
    }

    [self calculateTodaySlot:NO];
    
    // Connect data
    self.picker1.dataSource = self;
    self.picker1.delegate = self;
    
    
    
    
    
    
}

-(void)calculateTodaySlot:(BOOL)isNextday
{
    NSLog(@"todayDateStr = %@", todayDateStr);
    NSLog(@"todayTimeStr = %@", todayTimeStr);
    
    
    int timeDelta = 2;
    int currentTimeSlot = [todayTimeStr intValue];
    
    availableSlot =0 ;
    if(isNextday)
        currentTimeSlot = 11;
    
    int diffTime;
    
    if(currentTimeSlot>todayEndTime){
        diffTime = currentTimeSlot - todayEndTime;
        //availableSlot = todayStartTime + timeDelta;
        isNextDaySlot = YES;
    }
    else{
        diffTime = todayEndTime -currentTimeSlot;
        availableSlot = currentTimeSlot + timeDelta;
    }

    
    if(availableSlot == 10){
        
            [pickerData2 addObject:@"11 - 12"];
        
        [pickerData2 addObject:@"12 - 13"];
        
        [pickerData2 addObject:@"13 - 14"];
        
        [pickerData2 addObject:@"13 - 14"];
        
        [pickerData2 addObject:@"14 - 15"];
        
        [pickerData2 addObject:@"15 - 16"];
        
        [pickerData2 addObject:@"16 - 17"];
        
        [pickerData2 addObject:@"17 - 18"];    }
    else if(availableSlot == 11)
    {
        
            [pickerData2 addObject:@"12 - 13"];
        
            [pickerData2 addObject:@"13 - 14"];
        
        [pickerData2 addObject:@"13 - 14"];
        
        [pickerData2 addObject:@"14 - 15"];
        
        [pickerData2 addObject:@"15 - 16"];
        
        [pickerData2 addObject:@"16 - 17"];
        
        [pickerData2 addObject:@"17 - 18"];
    }
    else if(availableSlot == 12)
    {
        
            [pickerData2 addObject:@"13 - 14"];
        
        [pickerData2 addObject:@"14 - 15"];
        
        [pickerData2 addObject:@"15 - 16"];
        
        [pickerData2 addObject:@"16 - 17"];
        
        [pickerData2 addObject:@"17 - 18"];
    }
    else if(availableSlot == 13)
    {
        
            [pickerData2 addObject:@"14 - 15"];
        
            [pickerData2 addObject:@"15 - 16"];
        
            [pickerData2 addObject:@"16 - 17"];
        
            [pickerData2 addObject:@"17 - 18"];
        
            [pickerData2 addObject:@"18 - 19"];
    }
    else if(availableSlot == 14)
    {
        
            [pickerData2 addObject:@"15 - 16"];
        
            [pickerData2 addObject:@"16 - 17"];
        
            [pickerData2 addObject:@"17 - 18"];
        
            [pickerData2 addObject:@"18 - 19"];
    }
    else if(availableSlot == 15)
    {
        
            [pickerData2 addObject:@"16 - 17"];
        
            [pickerData2 addObject:@"17 - 18"];
        
            [pickerData2 addObject:@"18 - 19"];
    }
    else if(availableSlot == 16)
    {
        
            [pickerData2 addObject:@"17 - 18"];
        
            [pickerData2 addObject:@"18 - 19"];
    }
    else if(availableSlot == 17)
    {
        
            [pickerData2 addObject:@"18 - 19"];
    }
    
    [self.picker2 reloadAllComponents];
    NSLog(@"availableSlot %d",availableSlot);
    
}

//- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
//    // Handle the selection
//    if(self.picker1 == pickerView){
//    if(![todayDateStr isEqualToString:[pickerData1 objectAtIndex:row]])
//        [self calculateTodaySlot:YES];
//        NSLog(@"data selected %@",[pickerData1 objectAtIndex:row]);
//    }
//    
//}
-(void)calculateNextDaySlot
{
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(self.picker1 == pickerView)
    {
        return pickerData1.count;
    }
    else{
        return pickerData2.count;
    }
    
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(self.picker1 == pickerView)
    {
        return pickerData1[row];
    }
    else{
        return pickerData2[row];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickerDateAction:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *formatedDate = [dateFormatter stringFromDate:self.datePicker.date];
    
    selectedDate =formatedDate;
    
    NSLog(@"selectedDate %@",selectedDate);
    
    SHARED_DELEGATE.cusSelectedDateTime = selectedDate;
    
    [pickerData2 removeAllObjects];
    
    if([todayDateStr isEqualToString:selectedDate])
        [self calculateTodaySlot:NO];
    else
        [self calculateTodaySlot:YES];
    
    
}

- (IBAction)pickerTimeAction:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    
    NSString *formatedDate = [dateFormatter stringFromDate:self.datePicker.date];
    
    selectedDate =formatedDate;
    
    NSLog(@"selectedDate %@",selectedDate);
    
    SHARED_DELEGATE.cusSelectedDateTime = selectedDate;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.bannerImg.image = SHARED_DELEGATE.receivedBannerImg;
}
-(BOOL)validateDate
{
    BOOL ret = FALSE;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSDate *today = [NSDate date];
    NSString *formatedTodayDate = [dateFormatter stringFromDate:today];
    
    NSLog(@"formatedTodayDate %@",formatedTodayDate);
    NSLog(@"selectedDate %@",selectedDate);
    
    //if(![formatedTodayDate isEqualToString:selectedDate])
    if(availableSlot >= 10)
        ret = TRUE;
    
    NSString  *timeDelta = @"480";
    NSInteger minutes = [timeDelta integerValue];
    NSInteger hours = minutes/60;
   
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    components.timeZone = [NSTimeZone localTimeZone];
    components.hour =  14;
    components.minute = 30;
    components.second = 0;
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    for (int i=1; i<24; i++) {
        
        NSUInteger seconds = (3600 * i);
        NSDate *newDate= [NSDate dateWithTimeInterval:seconds sinceDate:date];
        NSLog(@"newDate = %@", newDate);
        NSString *formatted = [timeFormatter stringFromDate:newDate];
        NSLog(@"Formatted = %@", formatted);
    }
    
    return ret;
}

-(IBAction)letsProceed:(id)sender
{
    if([self validateDate]){
        SignUpDetails *signUpDetailsObj;
        NSArray *addressList = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"Address"];
        NSArray *signUpDetailsList = [APPDELEGATE_SHARED_MANAGER retrieveModelData:@"SignUpDetails"];
        if([signUpDetailsList count]>0)
            signUpDetailsObj =   (SignUpDetails*)[signUpDetailsList objectAtIndex:0];
        
        
        if([signUpDetailsObj.userId intValue] != 0){
            if([addressList count]>0){
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            AddressListViewController *addressListView = (AddressListViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"AddressListViewController"];
            [[SlideNavigationController sharedInstance] pushViewController:addressListView animated:NO];
            }
            else{
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                AddressLandingViewController *addressLandingView = (AddressLandingViewController*)[mainStoryboard
                                                                                                   instantiateViewControllerWithIdentifier: @"AddressLandingViewController"];
                
                
                [[SlideNavigationController sharedInstance] pushViewController:addressLandingView animated:NO];
            }

        }
        else{
            
        
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            
            SignUpViewController *locationView = (SignUpViewController*)[mainStoryboard
                                                                         instantiateViewControllerWithIdentifier: @"SignUpViewController"];
            
            
            
            [[SlideNavigationController sharedInstance] pushViewController:locationView animated:NO];
        }
    }
    else{
        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Choose available slots"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
