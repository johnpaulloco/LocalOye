//
//  HomeViewTableViewCell.m
//  DIDatepicker
//
//  Created by John Paul Ranjith on 26/04/15.
//  Copyright (c) 2015 Mutual Mobile. All rights reserved.
//

#import "ServiceDetailViewTableViewCell.h"

@implementation ServiceDetailViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.serviceDesc.textColor = [UIColor grayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
