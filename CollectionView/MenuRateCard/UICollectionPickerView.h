//
//  Created by John Paul Ranjith on 26/04/15.
//  Copyright (c) 2015 Mutual Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>


extern const CGFloat kUICollectionPickerItemWidth;
extern const CGFloat kUICollectionPickerSelectionLineWidth;

@interface UICollectionPickerCell : UICollectionViewCell

// data
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) UIColor *itemSelectionColor;

@end
