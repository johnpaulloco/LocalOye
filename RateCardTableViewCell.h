//
//  RateCardTableViewCell.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 06/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RateCardTableViewCell : UITableViewCell
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *tickMarkImgView;
@property (weak, nonatomic) IBOutlet UILabel *skuLbl;
@property (weak, nonatomic) IBOutlet UILabel *skuPrice;

@end
