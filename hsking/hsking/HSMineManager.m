//
//  HSMineManager.m
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSMineManager.h"

#define mineDefaultsKey @"mine_habbits_array"

@implementation HSMineManager
+ (void) addToMine:(NSDictionary *)habbit {
    
}
+ (void) removeFromMine:(NSDictionary *)habbit {
    
}
+ (BOOL) isMine:(NSDictionary *)habbit {
    return NO;
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
    return @[];
}
+ (NSDictionary *) mineHabbitStateDict {
    return @{@"name":@""};
}
@end
