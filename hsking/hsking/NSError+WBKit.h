//
//  NSError+WBKit.h
//  WerbaryKit
//
//  Created by Ivan Trufanov on 09.01.14.
//  Copyright (c) 2014 Werbary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (WBKit)

+ (NSError *) errorWithTitle:(NSString *)title;
+ (NSError *) errorWithDescription:(NSString *)description;
+ (NSError *) errorWithTitle:(NSString *)title description:(NSString *)description;
+ (NSError *) errorWithTitle:(NSString *)title description:(NSString *)description code:(NSInteger)code;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *errorDescription;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *errorTitle;
@end
