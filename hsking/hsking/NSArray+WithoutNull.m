//
//  NSArray+WithoutNull.m
//  Kefir
//
//  Created by Иван Труфанов on 29.01.14.
//  Copyright (c) 2014 wit. All rights reserved.
//

#import "NSArray+WithoutNull.h"
#import "NSDictionary+WithoutNull.h"

@implementation NSArray (WithoutNull)
- (NSArray *) arrayByRemovingNulls {
    if ([self isKindOfClass:[NSDictionary class]]) {
        return (NSArray *)[(NSDictionary *)self dictionaryByRemovingNulls];
    }
    
    NSMutableArray *arrRes = [NSMutableArray new];
    
    for (id object in self) {
        if ([object isKindOfClass:[NSDictionary class]]) {
            [arrRes addObject:[(NSDictionary *)object dictionaryByRemovingNulls]];
        } else if ([object isKindOfClass:[NSArray class]]) {
            [arrRes addObject:[(NSArray *)object arrayByRemovingNulls]];
        } else {
            if (object != [NSNull null]) {
                [arrRes addObject:object];
            }
        }
    }
    
    return arrRes;
}


@end
