//
//  HSSelectorViewController.m
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSSelectorViewController.h"

@interface HSSelectorViewController () {
//    NSInteger selected;
}
@end

@implementation HSSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    selectedNew = [_selectedValues mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _values.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = _values[indexPath.row][@"name"];
    
    NSRange firstBracket = [cell.textLabel.text rangeOfString:@"("];
    NSRange secondBracket = [cell.textLabel.text rangeOfString:@")"];
    if (firstBracket.location != NSNotFound) {
        cell.detailTextLabel.text = [cell.textLabel.text substringWithRange:NSMakeRange(firstBracket.location+1, secondBracket.location-firstBracket.location-1)];
        cell.textLabel.text = [cell.textLabel.text substringToIndex:firstBracket.location];
    } else {
        cell.detailTextLabel.text = @"";
    }
    
    if ([selectedNew containsObject:_values[indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_multiplySelection) {
        if (_callback) {
            _callback(@[_values[indexPath.row]]);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        if ([selectedNew containsObject:_values[indexPath.row]]) {
            [selectedNew removeObject:_values[indexPath.row]];
        } else {
            [selectedNew addObject:_values[indexPath.row]];
        }
        
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
        self.navigationItem.rightBarButtonItem = doneBtn;
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
    }
}

- (void) done {
    _callback(selectedNew);
    
    [self.navigationController popViewControllerAnimated:YES];
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
