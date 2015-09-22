//
//  QuestionSubView.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 20/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionSubView : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic)     IBOutlet UIImageView    *bannerImg;
@property (weak, nonatomic)     IBOutlet UILabel        *questionDesc;
@property (nonatomic, strong)   IBOutlet UITableView    *tableView;
@property (weak, nonatomic)     IBOutlet UIButton       *letGoBtn;

@property (nonatomic, strong)   NSArray                 *questionList;

-(IBAction)letGo:(id)sender;

@end
