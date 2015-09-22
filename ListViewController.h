//
//  ListViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 20/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSNumber *stateID;
    NSNumber *countryID;
    NSNumber *cityID;
    NSArray *array;
}

@property (nonatomic, weak) IBOutlet UIButton *nextBtn;
@property (nonatomic, weak) IBOutlet UITableView *listTableView;

@property (nonatomic, strong)  NSMutableArray *listData;
@property (nonatomic, strong)  NSString *viewType;



-(IBAction)nextBtnAction:(id)sender;


@end
