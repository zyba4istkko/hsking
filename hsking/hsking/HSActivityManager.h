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

@interface HSActivityManager : NSObject
+ (NSArray *) availiableHabbitStatuses;
+ (NSDictionary *) statusForHabbit:(NSDictionary *)habbit;
+ (void) setStatus:(NSDictionary *)status forHabbit:(NSDictionary *)habbit;
@end
