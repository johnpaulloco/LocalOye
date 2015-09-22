//
//  RateMerchantViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 21/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "RateMerchantViewController.h"
#import "RequestResposeHandler.h"
#import "LocalOyeConstants.h"

@interface RateMerchantViewController ()

@end

@implementation RateMerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =kOfflineBGColor;
}

-(void)initiatePanicAlertAPI
{
    //if([APPDELEGATE_SHARED_MANAGER isConnected]){
    
    //SHARED_DELEGATE.recivedLeadID= [NSNumber numberWithInt:1];
    [RequestResposeHandler SubmitPanicAlert:self.myOrderObj.booking_id :self.causeEnum : self.rescheduleEnum : rating:^(BOOL success, NSString *error){ //need to use
        if (success)
        {
            NSLog(@"sucess");
            UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Alert Raised"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [wsAlert show];
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

-(IBAction)starTapAction:(id)sender
{
    UIImage *defaultImage = [UIImage imageNamed:@"ic-star-filled.png"];
    UIImage *starImage = [UIImage imageNamed:@"ic-star-filled-yellow"];
    if ([sender isSelected]) {
        [sender setImage:defaultImage forState:UIControlStateNormal];
        [sender setSelected:NO];
    } else {
        [sender setImage:starImage forState:UIControlStateSelected];
        [sender setSelected:YES];
    }
    
    
}

-(void)calculateRating
{
    int ratingVal = 0;
    
    if([self.star1 isSelected]){
        ratingVal=ratingVal+1;
    }
    if([self.star2 isSelected]){
        ratingVal=ratingVal+1;
    }
    if([self.star3 isSelected]){
        ratingVal=ratingVal+1;
    }
    if([self.star4 isSelected]){
        ratingVal=ratingVal+1;
    }
    if([self.star5 isSelected]){
        ratingVal=ratingVal+1;
    }
    
    rating = [NSNumber numberWithInt:ratingVal];
}
-(IBAction)submitRating:(id)sender
{
    [self calculateRating];
    [self initiatePanicAlertAPI];
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
