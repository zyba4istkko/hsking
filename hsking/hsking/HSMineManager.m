//
//  HSMineManager.m
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSMineManager.h"
#import "HSDataManager.h"
#import "HSActivityManager.h"
#import "HSScheduleManager.h"

#define mineDefaultsKey @"mine_habbits_array"

@implementation HSMineManager
+ (void) addToMine:(NSDictionary *)habbit {
    NSMutableArray *mine = [[self mineHabbitsIds] mutableCopy];
    if (![mine containsObject:[habbit[@"Id"] stringValue]]) {
        NSString *idStr = habbit[@"Id"];
        if ([idStr isKindOfClass:[NSNumber class]]) {
            idStr = [(NSNumber *)idStr stringValue];
        }
        [mine addObject:idStr];
    }
    [[NSUserDefaults standardUserDefaults] setObject:mine forKey:mineDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //Periods
    NSMutableArray *periodsDefault = [NSMutableArray new];
    for (NSDictionary *schedule in habbit[@"DefaultShedules"]) {
        NSString *value = schedule[@"Value"];
        
//        Morning
//        Firstlunch
//        Lunch
//        Afternoon
//        Evening
//        Night
        if ([value isEqualToString:@"Morning"]) {
            [periodsDefault addObject:@(PeriodEnumMorning)];
        } else if ([value isEqualToString:@"Firstlunch"]) {
            [periodsDefault addObject:@(PeriodEnumFirstHalf)];
        } else if ([value isEqualToString:@"Lunch"]) {
            [periodsDefault addObject:@(PeriodEnumObed)];
        } else if ([value isEqualToString:@"Afternoon"]) {
            [periodsDefault addObject:@(PeriodEnumSecondHalf)];
        } else if ([value isEqualToString:@"Evening"]) {
            [periodsDefault addObject:@(PeriodEnumVecher)];
        } else if ([value isEqualToString:@"Night"]) {
            [periodsDefault addObject:@(PeriodEnumNight)];
        }
    }
    [HSScheduleManager setPeriodArray:periodsDefault forHabbit:habbit];
    [HSActivityManager setStatus:HabbitStatusDevelop forHabbit:habbit];
    [HSActivityManager setWorkStatus:HabbitWorkStatusNotWorking forHabbit:habbit];
}
+ (void) removeFromMine:(NSDictionary *)habbit {
    NSMutableArray *mine = [[self mineHabbitsIds] mutableCopy];
    if ([mine containsObject:[habbit[@"Id"] stringValue]]) {
        [mine removeObject:[habbit[@"Id"] stringValue]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:mine forKey:mineDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL) isMine:(NSDictionary *)habbit {
    NSString *idStr = habbit[@"Id"];
    if ([idStr isKindOfClass:[NSNumber class]]) {
        idStr = [(NSNumber *)idStr stringValue];
    }
    return [[self mineHabbitsIds] containsObject:idStr];
}
+ (NSInteger) numberOfMine {
    return [[self mineHabbitsIds] count];
}
+ (NSArray *) mineHabbitsIds {
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:mineDefaultsKey];
    if (!array)
        array = @[];
    return array;
}
+ (NSArray *) mineHabbits {
    NSMutableArray *resultArray = [NSMutableArray new];
    for (NSString *objId in [self mineHabbitsIds]) {
        for (NSDictionary *habbit in [HSDataManager habbitsCache]) {
            if ([habbit[@"Id"] isEqualToString:objId]) {
                [resultArray addObject:habbit];
                break;
            }
        }
    }
    return resultArray;
}
+ (NSDictionary *) mineHabbitStateDict {
    NSMutableDictionary *dictionaryHabbitsState = [NSMutableDictionary new];
    
    for (NSDictionary *habbit in [self mineHabbits]) {
        NSDictionary *state = [HSActivityManager statusForHabbit:habbit];
        NSMutableArray *sameState = dictionaryHabbitsState[state];
        if (!sameState) {
            sameState = [NSMutableArray new];
        }
        [sameState addObject:habbit];
        dictionaryHabbitsState[state] = sameState;
    }
    
    return [dictionaryHabbitsState copy];
}
@end
