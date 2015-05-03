//
//  UIColor+HEX.h
//  amoCRM
//
//  Created by Иван Труфанов on 02.07.14.
//  Copyright (c) 2014 Mike Zaslavskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HEX)
+ (UIColor *) colorWithHEXString:(NSString *)hexString;
+ (UIColor *) colorWithHEXString:(NSString *)hexString alpha:(CGFloat)alpha;
@end
