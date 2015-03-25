//
//  NSString+Size.h
//  Kefir
//
//  Created by Иван Труфанов on 21.11.14.
//  Copyright (c) 2014 wit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)
- (CGSize) sizeWithFont:(UIFont *)font limitWidth:(CGFloat)maxWidth limitHeight:(CGFloat)maxHeight lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGFloat) heightWithFont:(UIFont *)font limitWidth:(CGFloat)maxWidth lineBreakMode:(NSLineBreakMode)lineBreakMode;
@end
