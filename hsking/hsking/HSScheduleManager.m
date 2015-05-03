//
//  HSScheduleManager.m
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSScheduleManager.h"

@implementation HSScheduleManager
+ (NSArray *) availiablePeriods {
    return @[@{@"name":@"Утро (07:00 - 10:00)",@"enum":@(PeriodEnumMorning)},@{@"name":@"До обеда (10:00 - 12:00)",@"enum":@(PeriodEnumFirstHalf)},@{@"name":@"Обед (12:00 - 14:00)",@"enum":@(PeriodEnumObed)},@{@"name":@"После обеда (14:00 - 18:00)",@"enum":@(PeriodEnumSecondHalf)},@{@"name":@"Вечер (18:00 - 23:00)",@"enum":@(PeriodEnumVecher)},@{@"name":@"Ночь (23:00 - 07:00)",@"enum":@(PeriodEnumNight)}];
}
+ (NSDictionary *) periodForHabbit:(NSDictionary *)habbit {
    return [self availiablePeriods][3];
}
+ (void) setPeriod:(NSDictionary *)period forHabbit:(NSDictionary *)habbit {
    
}
@end
