//
//  NSMutableURLRequest+MultipartForm.h
//  Kefir
//
//  Created by Иван Труфанов on 16.12.13.
//  Copyright (c) 2013 wit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (MultipartForm)
- (void) setMultipartData:(NSDictionary *)data;
@end
