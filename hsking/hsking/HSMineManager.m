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

#define mineDefaultsKey @"mine_habbits_array"

@implementation HSMineManager
+ (void) addToMine:(NSDictionary *)habbit {
    NSMutableArray *mine = [[self mineHabbitsIds] mutableCopy];
    if (![mine containsObject:habbit[@"objectId"]]) {
        [mine addObject:habbit[@"objectId"]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:mine forKey:mineDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [HSActivityManager setStatus:HabbitStatusDevelop forHabbit:habbit];
    [HSActivityManager setWorkStatus:HabbitWorkStatusNotWorking forHabbit:habbit];
}
+ (void) removeFromMine:(NSDictionary *)habbit {
    NSMutableArray *mine = [[self mineHabbitsIds] mutableCopy];
    if ([mine containsObject:habbit[@"objectId"]]) {
        [mine removeObject:habbit[@"objectId"]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:mine forKey:mineDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL) isMine:(NSDictionary *)habbit {
    return [[self mineHabbitsIds] containsObject:habbit[@"objectId"]];
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
            if ([habbit[@"objectId"] isEqualToString:objId]) {
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
