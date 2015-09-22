//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "MyOrderListViewController.h"

@implementation LeftMenuViewController

#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self.slideOutAnimationEnabled = YES;
	
	return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.tableView.separatorColor = [UIColor lightGrayColor];
	
	//UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LeftMenuBg"]];
	//self.tableView.backgroundView = imageView;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    [self.customeName setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:15]];
   
    
    self.profileBannerView.backgroundColor =[UIColor colorWithRed:238.0f/255.0f  green:98.0f/255.0f blue:20.0f/255.0f alpha:1];
    //self.profileBannerView.backgroundColor =[UIColor orangeColor];

}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
	view.backgroundColor = [UIColor clearColor];
	return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 20;
}
-(void)triggerHelpShift
{
    [[SlideNavigationController sharedInstance] toggleHelpShift];
}
-(IBAction)loginAction:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                          bundle: nil];
    
    UIViewController *vc ;
    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"LoginDetailViewController"];
    
    [[SlideNavigationController sharedInstance] pushViewController:vc animated:NO];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:15]];
    cell.textLabel.textColor = [UIColor darkGrayColor];
	switch (indexPath.row)
	{
		case 0:
			cell.textLabel.text = @"My Orders";
			break;
			
		case 1:
			cell.textLabel.text = @"Support Chat";
			break;
			
//		case 2:
//			cell.textLabel.text = @"Special offers";
//			break;
//			
//		case 3:
//			cell.textLabel.text = @"Help & FAQs";
//			break;
//            
//        case 4:
//            cell.textLabel.text = @"Settings";
//            break;
//            
//        case 5:
//            cell.textLabel.text = @"Share";
//            break;
//            
//        case 6:
//            cell.textLabel.text = @"About LocalOye";
//            break;
//            
//        case 7:
//            cell.textLabel.text = @"Sign Out";
//            break;
	}
	
	cell.backgroundColor = [UIColor clearColor];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
															 bundle: nil];
	
	UIViewController *vc ;
	
	switch (indexPath.row)
	{
		case 0:
			//vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"MyOrderListViewController"];
            [[SlideNavigationController sharedInstance] pushViewController:vc animated:NO];
			break;
			
		case 1:
			//vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
            [[SlideNavigationController sharedInstance] toggleHelpShift];
			break;
			
//		case 2:
//			vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"FriendsViewController"];
//			break;
//		
//        case 3:
//            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
//            break;
//            
//        case 4:
//            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ProfileViewController"];
//            break;
//            
//        case 5:
//            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"FriendsViewController"];
//            break;
//        
//        case 6:
//            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"FriendsViewController"];
//            break;
//        
//        case 7:
//            [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
//            [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
//            return;
//            break;
            
			
	}
	
    //  [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
    //															 withSlideOutAnimation:self.slideOutAnimationEnabled
    //																	 andCompletion:nil];
    //    
    
    
}

@end
