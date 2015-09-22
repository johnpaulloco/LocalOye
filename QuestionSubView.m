//
//  QuestionSubView.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 20/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "QuestionSubView.h"
#import "QuestionTableViewCell.h"
#import "Questions.h"

@interface QuestionSubView ()

@end

@implementation QuestionSubView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.questionList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionTableViewCell *cell = (QuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QuestionTableViewCell"];
    
    if([self.questionList count]>0)
    {
        Questions *questions = [self.questionList objectAtIndex:indexPath.row];
        cell.textLabel.text = questions.questionDesc;
    }
    
    cell.backgroundColor = [UIColor blueColor];
    cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"ic-select-check"]];
    [cell.accessoryView setFrame:CGRectMake(0, 0, 24, 24)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

-(IBAction)letGo:(id)sender
{
    
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
