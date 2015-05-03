//
//  HSActivityManager.m
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSActivityManager.h"


@implementation HSActivityManager
+ (NSArray *) availiableHabbitStatuses {
    return @[@{@"name":@"Развивать",@"enum":@(HabbitStatusDevelop)},@{@"name":@"Завершена",@"enum":@(HabbitStatusFinished)},@{@"name":@"Отложена",@"enum":@(HabbitStatusPaused)},@{@"name":@"Не интересна",@"enum":@(HabbitStatusCancelled)}];
}
+ (NSDictionary *) statusForHabbit:(NSDictionary *)habbit {
    return [self availiableHabbitStatuses][3];
}
+ (void) setStatus:(NSDictionary *)status forHabbit:(NSDictionary *)habbit {
    
}
@end
