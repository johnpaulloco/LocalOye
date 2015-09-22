//
//  QuotesTableViewCell.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 31/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuotesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *merchantImg;
@property (weak, nonatomic) IBOutlet UILabel *merchantName;
@property (weak, nonatomic) IBOutlet UILabel *quotePrice;



@end
