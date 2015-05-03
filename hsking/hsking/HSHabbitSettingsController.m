//
//  HSHabbitSettingsController.m
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSHabbitSettingsController.h"
#import "HSSelectorViewController.h"
#import "HSScheduleManager.h"
#import "HSActivityManager.h"

@interface HSHabbitSettingsController ()

@end

@implementation HSHabbitSettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Статус";
        cell.detailTextLabel.text = [HSActivityManager statusForHabbit:_habbitDictionary][@"name"];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Планировщик";
        NSMutableString *str = [NSMutableString new];
        for (NSDictionary *period in [HSScheduleManager periodsForHabbit:_habbitDictionary]) {
            if (str.length > 0) {
                [str appendString:@", "];
            }
            [str appendString:[period[@"name"] componentsSeparatedByString:@" ("][0]];
        }
        cell.detailTextLabel.text = str;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    HSSelectorViewController *selector = [sb instantiateViewControllerWithIdentifier:@"HSSelectorViewController"];
    if (indexPath.row == 0) {
        selector.values = [HSActivityManager availiableHabbitStatuses];
        selector.selectedValues = @[[HSActivityManager statusForHabbit:_habbitDictionary]];
        selector.callback = ^(NSArray *objects) {
            [HSActivityManager setStatusDict:objects[0] forHabbit:_habbitDictionary];
        };
    } else if (indexPath.row == 1) {
        selector.values = [HSScheduleManager availiablePeriods];
        selector.selectedValues = [HSScheduleManager periodsForHabbit:_habbitDictionary];
        selector.multiplySelection = YES;
        selector.callback = ^(NSArray *objects) {
            [HSScheduleManager setPeriodDictArray:objects forHabbit:_habbitDictionary];
        };
    }
    [self.navigationController pushViewController:selector animated:YES];
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
