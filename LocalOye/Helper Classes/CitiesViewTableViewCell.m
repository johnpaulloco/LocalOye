//
//  HomeViewTableViewCell.m
//  DIDatepicker
//
//  Created by John Paul Ranjith on 26/04/15.
//  Copyright (c) 2015 Mutual Mobile. All rights reserved.
//

#import "CitiesViewTableViewCell.h"

@implementation CitiesViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.cityName.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
