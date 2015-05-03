//
//  HSDataManager.m
//  hsking
//
//  Created by Иван Труфанов on 25.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSDataManager.h"
#import "VMConnection.h"

#import "NSDictionary+WithoutNull.h"
#import "NSArray+WithoutNull.h"

#define cacheHabbitsKey @"habbits_cache"

@implementation HSDataManager

+ (NSArray *) habbitsCache {
    return [[NSUserDefaults standardUserDefaults] objectForKey:cacheHabbitsKey];
}
+ (void) getAllHabbits:(ArrayLoadingBlock)resBlock {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:cacheHabbitsKey]) {
        resBlock(YES,[[NSUserDefaults standardUserDefaults] objectForKey:cacheHabbitsKey],nil);
        return;
    }
    [VMConnection sendRequestToPath:@"Habits/GetHabits" withParameters:nil reqType:RequestTypePOST resBlock:^(BOOL success, NSHTTPURLResponse *resp, id respObj, NSError *err){
        if (success) {
            NSArray *habbits = respObj[@"Result"];
            NSMutableArray *mHabbits = [NSMutableArray new];
            for (NSDictionary *habbit in habbits) {
                NSMutableDictionary *habbitN = [[habbit dictionaryByRemovingNulls] mutableCopy];
                habbitN[@"objectId"] = [NSString stringWithFormat:@"%@",@([[NSUserDefaults standardUserDefaults] integerForKey:@"lastId"])];
                [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"lastId"]+1 forKey:@"lastId"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [mHabbits addObject:habbitN];
            }
            [[NSUserDefaults standardUserDefaults] setObject:mHabbits forKey:cacheHabbitsKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            resBlock(YES,habbits,nil);
        } else {
            resBlock(NO,nil,err);
        }
    }];
}
@end
