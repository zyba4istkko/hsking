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
        cell.detailTextLabel.text = [[HSScheduleManager periodForHabbit:_habbitDictionary][@"name"] componentsSeparatedByString:@"("][0];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    HSSelectorViewController *selector = [sb instantiateViewControllerWithIdentifier:@"HSSelectorViewController"];
    if (indexPath.row == 0) {
        selector.values = [HSActivityManager availiableHabbitStatuses];
        selector.selectedValue = [HSActivityManager statusForHabbit:_habbitDictionary];
        selector.callback = ^(NSDictionary *obj) {
            [HSActivityManager setStatus:obj forHabbit:_habbitDictionary];
        };
    } else if (indexPath.row == 1) {
        selector.values = [HSScheduleManager availiablePeriods];
        selector.selectedValue = [HSScheduleManager periodForHabbit:_habbitDictionary];
        selector.callback = ^(NSDictionary *obj) {
            [HSScheduleManager setPeriod:obj forHabbit:_habbitDictionary];
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
