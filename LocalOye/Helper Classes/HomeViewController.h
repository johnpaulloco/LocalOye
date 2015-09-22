//
//  HomeViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "MBProgressHUD.h"
#import <unistd.h>

@interface HomeViewController : UIViewController <SlideNavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource,MBProgressHUDDelegate>
{
    NSMutableArray *dataArray ;
    MBProgressHUD *HUD;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) IBOutlet UISwitch *limitPanGestureSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *slideOutAnimationSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *shadowSwitch;
@property (nonatomic, strong) IBOutlet UISwitch *panGestureSwitch;
@property (nonatomic, strong) IBOutlet UISegmentedControl *portraitSlideOffsetSegment;
@property (nonatomic, strong) IBOutlet UISegmentedControl *landscapeSlideOffsetSegment;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) IBOutlet UILabel *headerLbl;


@property (nonatomic, weak) IBOutlet UIImageView *bannerImg;
@property (nonatomic, strong)  NSArray *categoryList;
@property (nonatomic, strong)  NSArray *serviceList;



- (IBAction)bounceMenu:(id)sender;
- (IBAction)slideOutAnimationSwitchChanged:(id)sender;
- (IBAction)limitPanGestureSwitchChanged:(id)sender;
- (IBAction)changeAnimationSelected:(id)sender;
- (IBAction)shadowSwitchSelected:(id)sender;
- (IBAction)enablePanGestureSelected:(id)sender;
- (IBAction)portraitSlideOffsetChanged:(id)sender;
- (IBAction)landscapeSlideOffsetChanged:(id)sender;

@end
