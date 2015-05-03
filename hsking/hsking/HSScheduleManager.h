//
//  HSScheduleManager.h
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PeriodEnumMorning,
    PeriodEnumFirstHalf,
    PeriodEnumObed,
    PeriodEnumSecondHalf,
    PeriodEnumVecher,
    PeriodEnumNight
} PeriodEnum;

@interface HSScheduleManager : NSObject
+ (NSArray *) availiablePeriods;
+ (NSDictionary *) periodForHabbit:(NSDictionary *)habbit;
+ (void) setPeriod:(NSDictionary *)period forHabbit:(NSDictionary *)habbit;
@end
