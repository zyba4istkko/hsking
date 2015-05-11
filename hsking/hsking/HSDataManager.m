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
    }
    [VMConnection sendRequestToPath:@"Habits/GetHabits" withParameters:nil reqType:RequestTypePOST resBlock:^(BOOL success, NSHTTPURLResponse *resp, id respObj, NSError *err){
        if (success) {
            NSArray *habbits = respObj[@"Result"];
            [[NSUserDefaults standardUserDefaults] setObject:[habbits arrayByRemovingNulls] forKey:cacheHabbitsKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            resBlock(YES,habbits,nil);
        } else {
            resBlock(NO,nil,err);
        }
    }];
}
@end
