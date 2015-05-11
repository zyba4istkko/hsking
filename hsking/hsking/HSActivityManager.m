//
//  HSActivityManager.m
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSActivityManager.h"

#define defaultsKeyStatus @"statusStorageLog"
#define defaultsKeyWorkStatuses @"workStatusStorageLog"

@implementation HSActivityManager
+ (NSArray *) availiableHabbitStatuses {
    return @[@{@"name":@"Развивать",@"enum":@(HabbitStatusDevelop)},@{@"name":@"Завершена",@"enum":@(HabbitStatusFinished)},@{@"name":@"Отложена",@"enum":@(HabbitStatusPaused)},@{@"name":@"Не интересна",@"enum":@(HabbitStatusCancelled)}];
}
+ (NSString *)listNameFromEnum:(HabbitStatus)state {
    if (state == HabbitStatusDevelop) {
        return @"Развиваю";
    } else if (state == HabbitStatusFinished) {
        return @"Изучены";
    } else if (state == HabbitStatusPaused) {
        return @"Приостановлены";
    } else if (state == HabbitStatusCancelled) {
        return @"Не интересны";
    }
    return @"ХУЙНЯ КАКАЯ-ТА";
}
+ (NSDictionary *) statusForHabbit:(NSDictionary *)habbit {
    NSDictionary *statuses = [[NSUserDefaults standardUserDefaults] objectForKey:defaultsKeyStatus];
    for (NSDictionary *status in [self availiableHabbitStatuses]) {
        if ([status[@"enum"] unsignedIntegerValue] == [statuses[habbit[@"Id"]] integerValue]) {
            return status;
        }
    }
    return nil;
}
+ (void) setStatusDict:(NSDictionary *)status forHabbit:(NSDictionary *)habbit {
    [self setStatus:[status[@"enum"] unsignedIntegerValue] forHabbit:habbit];
}
+ (void) setStatus:(HabbitStatus)state forHabbit:(NSDictionary *)habbit {
    NSMutableDictionary *dictStatus = [[[NSUserDefaults standardUserDefaults] objectForKey:defaultsKeyStatus] mutableCopy];
    if (!dictStatus) {
        dictStatus = [NSMutableDictionary new];
    }
    NSString *idStr = habbit[@"Id"];
    if ([idStr isKindOfClass:[NSNumber class]]) {
        idStr = [(NSNumber *)idStr stringValue];
    }
    dictStatus[idStr] = @(state);
    [[NSUserDefaults standardUserDefaults] setObject:dictStatus forKey:defaultsKeyStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Work statuses
+ (HabbitWorkStatus) workStatusForHabbit:(NSDictionary *)habbit {
    NSDictionary *storage = [[NSUserDefaults standardUserDefaults] objectForKey:defaultsKeyWorkStatuses];
    NSArray *array = storage[habbit[@"Id"]];
    return [[array lastObject] unsignedIntegerValue];
}
+ (void) setWorkStatus:(HabbitWorkStatus)state forHabbit:(NSDictionary *)habbit {
    NSMutableDictionary *workStatusesStorage = [[[NSUserDefaults standardUserDefaults] objectForKey:defaultsKeyWorkStatuses] mutableCopy];
    if (!workStatusesStorage) {
        workStatusesStorage = [NSMutableDictionary new];
    }
    
    NSMutableArray *habbitStatuses = [workStatusesStorage[habbit[@"Id"]] mutableCopy];
    if (!habbitStatuses) {
        habbitStatuses = [NSMutableArray new];
    }
    [habbitStatuses addObject:@(state)];
    
    NSString *idStr = habbit[@"Id"];
    if ([idStr isKindOfClass:[NSNumber class]]) {
        idStr = [(NSNumber *)idStr stringValue];
    }
    workStatusesStorage[idStr] = habbitStatuses;
    
    [[NSUserDefaults standardUserDefaults] setObject:workStatusesStorage forKey:defaultsKeyWorkStatuses];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (CGFloat) progressForHabbit:(NSDictionary *)habbit {
    return 0.3;
}
@end
