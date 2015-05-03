//
//  HSActivityManager.h
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HabbitStatusDevelop,
    HabbitStatusFinished,
    HabbitStatusPaused,
    HabbitStatusCancelled
} HabbitStatus;

typedef enum : NSUInteger {
    HabbitWorkStatusNotWorking,
    HabbitWorkStatusWorking,
    HabbitWorkStatusFailed,
    HabbitWorkStatusCompleted,
    HabbitWorkStatusDelayed
} HabbitWorkStatus;

@interface HSActivityManager : NSObject
+ (NSArray *) availiableHabbitStatuses;
+ (NSDictionary *) statusForHabbit:(NSDictionary *)habbit;
+ (NSString *)listNameFromEnum:(HabbitStatus)state;
+ (void) setStatusDict:(NSDictionary *)status forHabbit:(NSDictionary *)habbit;
+ (void) setStatus:(HabbitStatus)state forHabbit:(NSDictionary *)habbit;

+ (HabbitWorkStatus) workStatusForHabbit:(NSDictionary *)habbit;
+ (void) setWorkStatus:(HabbitWorkStatus)state forHabbit:(NSDictionary *)habbit;

@end
