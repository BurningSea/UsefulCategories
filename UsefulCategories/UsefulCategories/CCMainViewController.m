//
//  CCMainViewController.m
//  UsefulCategories
//
//  Created by 何海 on 3/5/14.
//  Copyright (c) 2014 Sea. All rights reserved.
//

#import "CCMainViewController.h"
#import "CCUsefulCategories.h"
#import "CCNextViewController.h"

@interface CCMainViewController ()

@property (nonatomic, strong) NSArray *titles;

@end

@implementation CCMainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _titles = @[@"ActionSheet+Block", @"AlertView+Block", @"PresentViewLikeAlert", @"PresentViewLikePicker", @"GobackInModalView", @"GobackInPushedView"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = self.titles[indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // @"ActionSheet+Block", @"AlertView+Block", @"PresentViewLikeAlert", @"PresentViewLikePicker", @"GobackInModalView", @"GobackInPushedView"
    NSString *title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    if ([title isEqualToString:@"ActionSheet+Block"]) {
        [UIActionSheet showActionSheetInView:self.view title:@"ActionSheet" cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Done" otherButtonTitles:nil didClickAtIndex:^(NSInteger index) {
            NSLog(@"Click action sheet at index %d", index);
        }];
    } else if ([title isEqualToString:@"AlertView+Block"]) {
        [UIAlertView showAlertViewWithTitle:@"AlertView" message:@"An alert!" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Wow"] onClick:^(int buttonIndex) {
            NSLog(@"Click alert at index %d", buttonIndex);
        } onCancel:^{
            NSLog(@"Cancel alert");
        }];
    } else if ([title isEqualToString:@"PresentViewLikeAlert"]) {
        UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        testView.backgroundColor = [UIColor redColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:testView action:@selector(hideAlert)];
        [testView addGestureRecognizer:tap];
        [testView showAlert];
    } else if ([title isEqualToString:@"PresentViewLikePicker"]) {
        UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        testView.backgroundColor = [UIColor redColor];
        [testView showPickerWithCallback:^(UIView *picker) {
            NSLog(@"Picker did hide!");
        }];
    } else if ([title isEqualToString:@"GobackInModalView"]) {
        CCNextViewController *controller = [[CCNextViewController alloc] init];
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    } else if ([title isEqualToString:@"GobackInPushedView"]) {
        CCNextViewController *detailViewController = [[CCNextViewController alloc] init];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

@end
