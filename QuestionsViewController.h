//
//  QuestionsViewController.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 17/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"

@interface QuestionsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
{
    NSIndexPath             *lastIndexPath;
    NSNumber                *sequenceDisplaying;
    NSString                *questionType;
    NSArray                 *questionOption;
    NSMutableArray          *numberOfQuestions;
    NSString                *requirmentStr;
    
}

@property (nonatomic, strong)   IBOutlet UIButton       *userTextField;
@property (nonatomic, strong)   IBOutlet UIButton       *nextBtn;
@property (nonatomic, strong)   IBOutlet UIButton       *previousQuestion;
@property (nonatomic, strong)   IBOutlet UILabel        *questionDesc;
@property (nonatomic, weak)     IBOutlet UITableView    *tableView;
@property (nonatomic, weak)     IBOutlet UIImageView    *bannerImg;

@property (nonatomic, strong)   NSArray         *questionList;
@property (nonatomic)           BOOL            isMultiSelect;
@property (nonatomic, strong)   Questions       *questionObj;
@property (nonatomic, strong)   Options         *optionsObj;

@property (nonatomic, assign)   BOOL            isItemSelected;
@property (nonatomic, strong)  UIImage          *receivedBanerImg;

@property (nonatomic, strong)   IBOutlet UITextView       *testViewCtrl;

@end
