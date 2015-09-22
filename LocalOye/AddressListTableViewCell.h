//
//  AddressListTableViewCell.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 18/09/15.
//  Copyright © 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *addressType;
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIImageView *tickMark;


@end
