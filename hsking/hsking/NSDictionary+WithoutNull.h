//
//  NSDictionary+WithoutNull.h
//  Kefir
//
//  Created by Иван Труфанов on 29.01.14.
//  Copyright (c) 2014 wit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (WithoutNull)
- (NSDictionary *) dictionaryByRemovingNulls;
@end
