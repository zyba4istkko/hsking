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
+ (NSArray *) periodsForHabbit:(NSDictionary *)habbit;
+ (void) setPeriodDictArray:(NSArray *)periods forHabbit:(NSDictionary *)habbit;
+ (void) setPeriodArray:(NSArray *)periods forHabbit:(NSDictionary *)habbit;
@end
