//
//  QuestionsViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 17/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "QuestionsViewController.h"
#import "QuestionTableViewCell.h"
#import "PickerViewController.h"
#import "LocalOyeConstants.h"
#import "Questions.h"
#import "QuestionSubView.h"
#import "Options.h"
#import "LocationViewController.h"
#import "PromoCodeViewController.h"


@interface QuestionsViewController ()

@end

@implementation QuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
   
    //self.questionList = [NSArray arrayWithObjects:@"Within next two weeks",@"Right away",@"Not sure still exploring options", nil];
    
    
    //Number of Question Calculation
//    for (id data in self.questionList) {
//        Questions *questionObj = data;
//        [numberOfQuestions addObject:questionObj.sequenceNumber];
//    }
//    
    
   // NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"optionStr" ascending:NO selector:@selector(localizedCompare:)];
 //   self.questionOption = [self.questionOption sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    if(![APPDELEGATE_SHARED_MANAGER isConnected])
        [self.bannerImg setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"OfflineBGImg"]]];
    
    

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.bannerImg.image = SHARED_DELEGATE.receivedBannerImg;
    
    
    self.tableView.dataSource=self;
    self.questionDesc.textColor = [UIColor whiteColor];
    self.nextBtn.backgroundColor = [UIColor orangeColor];
    [self.nextBtn.titleLabel setFont:[UIFont fontWithName:kLocalOyeFontMedium size:16.0]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if([self.questionList count]>0){
        self.questionObj = [self.questionList objectAtIndex:0];
        
        questionOption = [self.questionObj.options allObjects];
        //sequenceDisplaying = self.questionObj.sequenceNumber;
        
        if([self.questionObj.questionType isEqualToString:@"Radio"]){
            self.tableView.allowsMultipleSelection = NO;
            self.testViewCtrl.hidden = YES;
        }
        else if([self.questionObj.questionType isEqualToString:@"Check"]){
            self.tableView.allowsMultipleSelection = YES;
            self.testViewCtrl.hidden = YES;
        }
        else if([self.questionObj.questionType isEqualToString:@"TextBox"]){
            self.tableView.hidden = YES;
            //[self addTextField];
            self.testViewCtrl.hidden = NO;
            self.testViewCtrl.layer.cornerRadius = 3.0;
            self.testViewCtrl.layer.borderColor = [[UIColor grayColor] CGColor];
            self.testViewCtrl.layer.borderWidth = 1.0;
            
            self.optionsObj = [questionOption objectAtIndex:0];
        }
        
    }
    
//    if([questionOption count]==0 && [self.questionList count]>0){
//        self.tableView.hidden = YES;
//        if(self.questionObj.questionDesc != nil)
//        {
//            [self addTextField];
//            
//        }else{
//            //[self letsProceed:nil];
//        }
//        
//    }
    
    self.questionDesc.font = [UIFont fontWithName:kLocalOyeFontMedium size:12.0];
    self.questionDesc.text = self.questionObj.questionDesc;
    
    self.tableView.layer.cornerRadius = 2.0;
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    self.isItemSelected = YES;
    NSLog(@"Did End editing");
    
    

}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    self.isItemSelected = YES;
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
    }
    
    return YES;
    
}
-(void)addTextField
{
    
    self.isItemSelected = YES;
    
    //UITextField* text = [[UITextField alloc] initWithFrame:CGRectMake(50, 250, 300, 50)];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 250, 300, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholder = @"enter text";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = self;
    [self.view addSubview:textField];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)fetchServiceForSelectedCategory:(NSIndexPath*)indexPath
//{
//    if([self.categoryList count]>0)
//    {
//        MajorCategory *cat = [self.categoryList objectAtIndex:indexPath.row];
//        
//        self.serviceList  = [cat.childCategory allObjects];
//        [self.tableView reloadData];
//    }
//}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [questionOption count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionTableViewCell *cell = (QuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QuestionTableViewCell"];
    
    if([questionOption count]>0)
    {
        Options *optionObj = [questionOption objectAtIndex:indexPath.row];
        
        
        //Questions *questions = [self.questionList objectAtIndex:indexPath.row];
        
        //NSLog(@"service name %@",service.name);
        //cell.serviceHeader.text = service.name;
        //   cell.serviceHeader.text = @"Home service";
        //cell.serviceDesc.text = @"Free yoga session for first 100 customers Free yoga session for first 100 customers";
        //cell.serviceImage.image = [UIImage imageNamed:@"TableCellImg"];
        //cell.serviceImage.image = [UIImage imageNamed:@"ic-menu-hamburger"];
    
        cell.questionDescStr.text = optionObj.optionStr;
    }
    cell.questionDescStr.font = [UIFont fontWithName:kLocalOyeFontLight size:14.0];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    
//        cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"ic-select-blank"]];
//        [cell.accessoryView setFrame:CGRectMake(0, 0, 24, 24)];
    
    [cell setTintColor:[UIColor orangeColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.isItemSelected = YES;
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    self.optionsObj = [questionOption objectAtIndex:indexPath.row];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    lastIndexPath = indexPath;
//    [self.tableView reloadData];
//    //[tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([lastIndexPath isEqual:indexPath])
//    {
//         if([self.questionObj.questionType isEqualToString:@"Check"])
//             cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic-select-check"]];
//        else
//             cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic-select-radio"]];
//        
//    } else {
//        cell.accessoryView = nil;
//    }
//}
//
//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//}

-(void)showNextQuestions{

}
-(IBAction)previousQuestion:(id)sender
{
    NSLog(@"");
}
-(IBAction)letsProceed:(id)sender
{
    if(!self.testViewCtrl.hidden)
        requirmentStr = self.testViewCtrl.text;
    
    NSLog(@"entered text %@",requirmentStr);
    if(self.isItemSelected){
        if([self.optionsObj.nextQuestionIndex isEqualToNumber:[NSNumber numberWithInt:0]])
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            
            PromoCodeViewController *promoCodeView = (PromoCodeViewController*)[mainStoryboard
                                                                       instantiateViewControllerWithIdentifier: @"PromoCodeViewController"];
            
            //pickerView.questionObj = self.questionObj;
            [[SlideNavigationController sharedInstance] pushViewController:promoCodeView animated:NO];
            
        }
        else{
            NSArray *array = [APPDELEGATE_SHARED_MANAGER retrieveQuestionForSequence:self.optionsObj.nextQuestionIndex:SHARED_DELEGATE.selectedServiceName];
            
            if([array count]>0){
                self.questionObj = [array objectAtIndex:0];
                
                if([self.questionObj.questionType isEqualToString:@"DatePicker"]){
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    
                    PickerViewController *pickerView = (PickerViewController*)[mainStoryboard
                                                                               instantiateViewControllerWithIdentifier: @"PickerViewController"];
                    
                    [[SlideNavigationController sharedInstance] pushViewController:pickerView animated:NO];
                }
                else if([self.questionObj.questionType isEqualToString:@"Location"]){
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    
                    LocationViewController *locationView = (LocationViewController*)[mainStoryboard
                                                                               instantiateViewControllerWithIdentifier: @"LocationViewController"];
                    locationView.questionArray = array;
                    [[SlideNavigationController sharedInstance] pushViewController:locationView animated:NO];
                }
                else if([self.questionObj.questionType isEqualToString:@"Radio"]){
                    self.tableView.allowsMultipleSelection = NO;
                    self.testViewCtrl.hidden = YES;
                    
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    
                    QuestionsViewController *nextView = (QuestionsViewController*)[mainStoryboard
                                                                                   instantiateViewControllerWithIdentifier: @"QuestionsViewController"];
                    nextView.questionList = array;
                    [[SlideNavigationController sharedInstance] pushViewController:nextView animated:NO];
                    
                }
                else if([self.questionObj.questionType isEqualToString:@"Check"]){
                    self.tableView.allowsMultipleSelection = YES;
                    self.testViewCtrl.hidden = YES;
                    
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    
                    QuestionsViewController *nextView = (QuestionsViewController*)[mainStoryboard
                                                                                   instantiateViewControllerWithIdentifier: @"QuestionsViewController"];
                    nextView.questionList = array;
                    [[SlideNavigationController sharedInstance] pushViewController:nextView animated:NO];
                    
                }
                else if([self.questionObj.questionType isEqualToString:@"TextBox"]){
                    self.tableView.hidden = YES;
                    //[self addTextField];
                    self.testViewCtrl.hidden = NO;
                    self.testViewCtrl.layer.cornerRadius = 3.0;
                    self.testViewCtrl.layer.borderColor = [[UIColor grayColor] CGColor];
                    self.testViewCtrl.layer.borderWidth = 1.0;
                    
                    self.optionsObj = [questionOption objectAtIndex:0];
                    
                    
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    
                    QuestionsViewController *nextView = (QuestionsViewController*)[mainStoryboard
                                                                                   instantiateViewControllerWithIdentifier: @"QuestionsViewController"];
                    nextView.questionList = array;
                    [[SlideNavigationController sharedInstance] pushViewController:nextView animated:NO];
                    
                }
                
                
            }
            
            else{
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                
                QuestionsViewController *nextView = (QuestionsViewController*)[mainStoryboard
                                                                               instantiateViewControllerWithIdentifier: @"QuestionsViewController"];
                nextView.questionList = array;
                [[SlideNavigationController sharedInstance] pushViewController:nextView animated:NO];
            }
        }
    }
    else{
        UIAlertView *wsAlert=[[UIAlertView alloc] initWithTitle:@"Info" message:@"Please select an item or enter requirement"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [wsAlert show];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
