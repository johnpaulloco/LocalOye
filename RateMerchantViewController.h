//
//  RateMerchantViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 21/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrder.h"

@interface RateMerchantViewController : UIViewController
{
    NSNumber *rating;
}
@property (weak, nonatomic) IBOutlet UIButton *star1;
@property (weak, nonatomic) IBOutlet UIButton *star2;
@property (weak, nonatomic) IBOutlet UIButton *star3;
@property (weak, nonatomic) IBOutlet UIButton *star4;
@property (weak, nonatomic) IBOutlet UIButton *star5;
 
@property (nonatomic, strong)  MyOrder *myOrderObj;
@property (nonatomic, strong)  NSString *causeEnum;
@property (nonatomic, strong)  NSString *rescheduleEnum;

@end
