//
//  PickerViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 18/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionsViewController.h"
#import "AddressLandingViewController.h"
@interface PickerViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSString *selectedDate;
    NSMutableArray *pickerData1;
    NSMutableArray *pickerData2;
    
    NSString *todayDateStr;
    NSString *todayTimeStr;
    
    int  todayStartTime;
    int  todayEndTime;
    BOOL isNextDaySlot;
    int availableSlot;
    
    
}
@property (nonatomic, strong) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@property (nonatomic, weak) IBOutlet UILabel *headerTitle;
@property (nonatomic, weak) IBOutlet UIImageView *bannerImg;

@property (nonatomic, strong)  Questions *questionObj;
@property (weak, nonatomic) IBOutlet UIPickerView *picker1;
@property (weak, nonatomic) IBOutlet UIPickerView *picker2;


- (IBAction)pickerDateAction:(id)sender;
- (IBAction)pickerTimeAction:(id)sender;

@end
