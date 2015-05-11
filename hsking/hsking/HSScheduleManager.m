//
//  HSScheduleManager.m
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSScheduleManager.h"

#define defaultsKeyStatus @"scheduleDefaultsKey"

@implementation HSScheduleManager
+ (NSArray *) availiablePeriods {
    return @[@{@"name":@"Утро (07:00 - 10:00)",@"enum":@(PeriodEnumMorning)},@{@"name":@"До обеда (10:00 - 12:00)",@"enum":@(PeriodEnumFirstHalf)},@{@"name":@"Обед (12:00 - 14:00)",@"enum":@(PeriodEnumObed)},@{@"name":@"После обеда (14:00 - 18:00)",@"enum":@(PeriodEnumSecondHalf)},@{@"name":@"Вечер (18:00 - 23:00)",@"enum":@(PeriodEnumVecher)},@{@"name":@"Ночь (23:00 - 07:00)",@"enum":@(PeriodEnumNight)}];
}
+ (NSArray *) periodsForHabbit:(NSDictionary *)habbit {
    NSMutableArray *result = [NSMutableArray new];
    NSDictionary *statuses = [[NSUserDefaults standardUserDefaults] objectForKey:defaultsKeyStatus];
    for (NSDictionary *status in [self availiablePeriods]) {
        NSString *idStr = habbit[@"Id"];
        if ([idStr isKindOfClass:[NSNumber class]]) {
            idStr = [(NSNumber *)idStr stringValue];
        }
        for (NSNumber *statusSaved in statuses[idStr]) {
            if ([status[@"enum"] unsignedIntegerValue] == [statusSaved unsignedIntegerValue]) {
                [result addObject:status];
                break;
            }
        }
    }
    return result;
}
+ (void) setPeriodDictArray:(NSArray *)periods forHabbit:(NSDictionary *)habbit {
    NSMutableArray *res = [NSMutableArray new];
    for (NSDictionary *dict in periods) {
        [res addObject:dict[@"enum"]];
    }
    [self setPeriodArray:res forHabbit:habbit];
}
+ (void) setPeriodArray:(NSArray *)periods forHabbit:(NSDictionary *)habbit {
    NSMutableDictionary *dictStatus = [[[NSUserDefaults standardUserDefaults] objectForKey:defaultsKeyStatus] mutableCopy];
    if (!dictStatus) {
        dictStatus = [NSMutableDictionary new];
    }
    NSString *idStr = habbit[@"Id"];
    if ([idStr isKindOfClass:[NSNumber class]]) {
        idStr = [(NSNumber *)idStr stringValue];
    }
    dictStatus[idStr] = periods;
    [[NSUserDefaults standardUserDefaults] setObject:dictStatus forKey:defaultsKeyStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void) setPeriod:(PeriodEnum)period forHabbit:(NSDictionary *)habbit {
    NSMutableDictionary *dictStatus = [[[NSUserDefaults standardUserDefaults] objectForKey:defaultsKeyStatus] mutableCopy];
    if (!dictStatus) {
        dictStatus = [NSMutableDictionary new];
    }
    dictStatus[habbit[@"Id"]] = @(period);
    [[NSUserDefaults standardUserDefaults] setObject:dictStatus forKey:defaultsKeyStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
