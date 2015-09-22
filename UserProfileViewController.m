//
//  UserProfileViewController.m
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 17/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import "UserProfileViewController.h"
#import "LocalOyeConstants.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    // Make cell unselectable
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.font = [UIFont fontWithName:kLocalOyeFontLight size:14.0];
    
    UITextField* tf = nil ;
    switch ( indexPath.row ) {
        case 0: {
            cell.textLabel.text = @"FIRST NAME" ;
            tf = firstNameField_ = [self makeTextField:self.firstName placeholder:@""];
            [cell addSubview:firstNameField_];
            break ;
        }
        case 1: {
            cell.textLabel.text = @"LAST NAME" ;
            
            tf = lastNameField_ = [self makeTextField:self.lastName placeholder:@""];
            [cell addSubview:lastNameField_];
            
            break ;
        }
        case 2: {
            cell.textLabel.text = @"EMAIL" ;
            tf = emailField_ = [self makeTextField:self.email placeholder:@""];
            [cell addSubview:emailField_];
            break ;
        }
        case 3: {
            cell.textLabel.text = @"PHONE NO" ;
            tf = phoneNoField_ = [self makeTextField:self.phoneNo placeholder:@""];
            [cell addSubview:phoneNoField_];
            
            break ;
        }
        case 4: {
            cell.textLabel.text = @"ADDRESS" ;
            tf = addressField_ = [self makeTextField:self.address placeholder:@""];
            [cell addSubview:addressField_];
            
            break ;
        }
            
    }
    
    // Textfield dimensions
    tf.frame = CGRectMake(140, 8, 170, 25);
    
    // Workaround to dismiss keyboard when Done/Return is tapped
    [tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    // We want to handle textFieldDidEndEditing
    tf.delegate = self ;
    
    return cell;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


-(UITextField*) makeTextField: (NSString*)text
                  placeholder: (NSString*)placeholder  {
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = placeholder ;
    tf.text = text ;
    tf.autocorrectionType = UITextAutocorrectionTypeNo ;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.adjustsFontSizeToFitWidth = YES;
    tf.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    return tf ;
}

// Workaround to hide keyboard when Done is tapped
- (IBAction)textFieldFinished:(id)sender {
    // [sender resignFirstResponder];
}

// Textfield value changed, store the new value.
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ( textField == firstNameField_) {
        self.firstName = firstNameField_.text ;
    } else if ( textField == lastNameField_ ) {
        self.lastName = lastNameField_.text ;
    } else if ( textField == emailField_) {
        self.email = emailField_.text ;
    } else if ( textField == phoneNoField_ ) {
        self.phoneNo = phoneNoField_.text ;
    }else if ( textField == addressField_ ) {
        self.address = addressField_.text ;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
