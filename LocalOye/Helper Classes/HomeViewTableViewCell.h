//
//  HomeViewTableViewCell.h
//  HomeViewTableView
//
//  Created by John Paul Ranjith on 26/04/15.
//  Copyright (c) 2015 Mutual Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewTableViewCell : UITableViewCell
{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *serviceImage;
@property (weak, nonatomic) IBOutlet UILabel *serviceHeader;
@property (weak, nonatomic) IBOutlet UILabel *serviceDesc;

@end
