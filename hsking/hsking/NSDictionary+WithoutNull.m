//
//  NSDictionary+WithoutNull.m
//  Kefir
//
//  Created by Иван Труфанов on 29.01.14.
//  Copyright (c) 2014 wit. All rights reserved.
//

#import "NSDictionary+WithoutNull.h"
#import "NSArray+WithoutNull.h"

@implementation NSDictionary (WithoutNull)
- (NSDictionary *) dictionaryByRemovingNulls {
    if ([self isKindOfClass:[NSArray class]]) {
        return (NSDictionary *)[(NSArray *)self arrayByRemovingNulls];
    }
    
    NSMutableDictionary *dictRes = [NSMutableDictionary new];
    
    for (NSString *key in [self allKeys]) {
        id object = self[key];
        if ([object isKindOfClass:[NSDictionary class]]) {
            dictRes[key] = [(NSDictionary *)object dictionaryByRemovingNulls];
        } else if ([object isKindOfClass:[NSArray class]]) {
            dictRes[key] = [(NSArray *)object arrayByRemovingNulls];
        } else {
            if (object != [NSNull null]) {
                if ([key isEqualToString:@"Id"] && [object isKindOfClass:[NSNumber class]]) {
                    object = [(NSNumber *)object stringValue];
                }
                dictRes[key] = object;
            }
        }
    }
    
    return dictRes;
}
@end
