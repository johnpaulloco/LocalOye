//
//  OrderListTableViewCell.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 25/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListTableViewCell : UITableViewCell
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *categoryImg;
@property (weak, nonatomic) IBOutlet UIImageView *loadingImg;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *awaitingResponseLbl;

@end
