//
//  HSDataManager.h
//  hsking
//
//  Created by Иван Труфанов on 25.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSDataManager : NSObject
+ (NSArray *) habbitsCache;
+ (void) getAllHabbits:(ArrayLoadingBlock)resBlock;
@end
