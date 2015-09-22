//
//  Created by John Paul Ranjith on 26/04/15.
//  Copyright (c) 2015 Mutual Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>


extern const CGFloat kDIDatepickerHeight;

@interface DIDatepicker : UIControl <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

// data
@property (strong, nonatomic) NSArray *dates;
@property (strong, nonatomic, readonly) NSDate *selectedDate;

@property (strong,nonatomic) NSIndexPath *selectedCat;


// UI
@property (strong, nonatomic) UIColor *bottomLineColor;
@property (strong, nonatomic) UIColor *selectedDateBottomLineColor;

// methods
- (void)fillDatesFromDate:(NSDate *)fromDate numberOfDays:(NSInteger)nextDatesCount;
- (void)fillCurrentWeek;
- (void)fillCurrentMonth;
- (void)fillCurrentYear;
- (void)selectDate:(NSDate *)date;
- (void)selectDateAtIndex:(NSUInteger)index;

@end
