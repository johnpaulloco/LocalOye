//
//  Created by John Paul Ranjith on 26/04/15.
//  Copyright (c) 2015 Mutual Mobile. All rights reserved.
//

#import "UICollectionPickerView.h"


const CGFloat kUICollectionPickerItemWidth = 120.;
const CGFloat kUICollectionPickerSelectionLineWidth = 51.;


@interface UICollectionPickerCell ()

@property (strong, nonatomic) UILabel *dateLabel;
@property (nonatomic, strong) UIView *selectionView;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end


@implementation UICollectionPickerCell

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

- (void)prepareForReuse
{
    [self setSelected:NO];
    self.selectionView.alpha = 0.0f;
}

#pragma mark - Setters

- (void)setDate:(NSString *)categoryName
{
    NSString *firstWord = [[categoryName componentsSeparatedByString:@" "] objectAtIndex:0];
    
    //NSMutableAttributedString *categoryString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",firstWord]];
    
    //NSMutableAttributedString *categoryString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",categoryName]];
    
    //[self.dateLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:8]];
    [self.dateLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
    
    
    //self.dateLabel.attributedText = categoryString;
    self.dateLabel.text = categoryName;
    self.dateLabel.textColor = [UIColor whiteColor];
    

}

- (void)setItemSelectionColor:(UIColor *)itemSelectionColor
{
    //self.selectionView.backgroundColor = itemSelectionColor;
    self.selectionView.backgroundColor = [UIColor orangeColor];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    self.selectionView.hidden = NO;
    if (highlighted) {
        self.selectionView.alpha = self.isSelected ? 1 : .5;
    } else {
        self.selectionView.alpha = self.isSelected ? 1 : 0;
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.selectionView.alpha = (selected)?1.0f:0.0f;
}

#pragma mark - Getters

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _dateLabel.numberOfLines = 1;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dateLabel];
    }
    
    return _dateLabel;
}

- (UIView *)selectionView
{
    if (!_selectionView) {
        _selectionView = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - kUICollectionPickerItemWidth) / 2, CGRectGetHeight(self.frame) - 3, kUICollectionPickerItemWidth, 3)];
        _selectionView.alpha = 0.0f;
        _selectionView.backgroundColor = [UIColor colorWithRed:242./255. green:93./255. blue:28./255. alpha:1.];
        [self addSubview:_selectionView];
    }
    
    return _selectionView;
}

- (NSDateFormatter *)dateFormatter
{
    if(!_dateFormatter){
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    
    return _dateFormatter;
}

#pragma mark - Helper Methods

- (BOOL)isWeekday:(NSDate *)date
{
    NSInteger day = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday];
    
    const NSInteger kSunday = 1;
    const NSInteger kSaturday = 7;
    
    BOOL isWeekdayResult = day == kSunday || day == kSaturday;
    
    return isWeekdayResult;
}

@end
