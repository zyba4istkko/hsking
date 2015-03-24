//
//  NSError+WBKit.m
//  WerbaryKit
//
//  Created by Ivan Trufanov on 09.01.14.
//  Copyright (c) 2014 Werbary. All rights reserved.
//

#import "NSError+WBKit.h"

@implementation NSError (WBKit)


+ (NSError *) errorWithTitle:(NSString *)title {
    return [NSError errorWithTitle:title description:nil];
}
+ (NSError *) errorWithDescription:(NSString *)description {
    return [NSError errorWithTitle:nil description:description];
}
+ (NSError *) errorWithTitle:(NSString *)title description:(NSString *)description {
    return [NSError errorWithTitle:title description:description code:0];
}
+ (NSError *) errorWithTitle:(NSString *)title description:(NSString *)description code:(NSInteger)code {
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    
    if (title) {
        userInfo[NSLocalizedDescriptionKey] = title;
    }
    
    if (description) {
        userInfo[NSLocalizedRecoverySuggestionErrorKey] = description;
    }
    
    return [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:code userInfo:userInfo];
}


- (NSString *) errorDescription {
    return [self userInfo][NSLocalizedRecoverySuggestionErrorKey];
}
- (NSString *) errorTitle {
    return [self userInfo][NSLocalizedDescriptionKey];
}
@end
