//
//  HSAuthManager.m
//  hsking
//
//  Created by Иван Труфанов on 24.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSAuthManager.h"

@implementation HSAuthManager
+ (void) makePasswordForPhone:(NSString *)phone resBlock:(ActionBlock)resBlock {
    resBlock(YES,nil);
}
+ (void) checkPasswordForPhone:(NSString *)phone pass:(NSString *)pass resBlock:(ActionBlock)resBlock {
    resBlock(YES,nil);
}
@end
