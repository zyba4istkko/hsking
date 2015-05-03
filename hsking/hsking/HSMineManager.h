//
//  HSMineManager.h
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSMineManager : NSObject
+ (void) addToMine:(NSDictionary *)habbit;
+ (void) removeFromMine:(NSDictionary *)habbit;
+ (BOOL) isMine:(NSDictionary *)habbit;
+ (NSInteger) numberOfMine;
+ (NSArray *) mineHabbits;
+ (NSDictionary *) mineHabbitStateDict;
@end
