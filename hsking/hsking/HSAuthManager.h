//
//  HSAuthManager.h
//  hsking
//
//  Created by Иван Труфанов on 24.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSAuthManager : NSObject
+ (void) makePasswordForPhone:(NSString *)phone resBlock:(ActionBlock)resBlock;
+ (void) checkPasswordForPhone:(NSString *)phone pass:(NSString *)pass resBlock:(ActionBlock)resBlock;
+ (BOOL) isAuthenticated;
+ (NSString *) authToken;
@end
