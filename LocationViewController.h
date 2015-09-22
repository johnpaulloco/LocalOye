//
//  LocationViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 18/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationDegrees currentLat;
    CLLocationDegrees currentLong;
    CLLocationManager *locationManager;
    NSString *locationEntered;
}
typedef void(^addressCompletion)(NSString *);
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLocation;
@property (nonatomic, weak) IBOutlet UILabel *headerTitle;
@property (nonatomic, weak) IBOutlet UILabel *localityTitle;
@property (nonatomic, weak) IBOutlet UILabel *nearestLocalTitle;

@property (nonatomic, strong)  NSString *retrievedAddress;
@property (nonatomic, weak) IBOutlet UIImageView *bannerImg;

@property (nonatomic, strong)  NSArray *questionArray;
@end
