//
//  NSString+Size.m
//  Kefir
//
//  Created by Иван Труфанов on 21.11.14.
//  Copyright (c) 2014 wit. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
- (CGSize) sizeWithFont:(UIFont *)font limitWidth:(CGFloat)limitWidth limitHeight:(CGFloat)limitHeight lineBreakMode:(NSLineBreakMode)lineBreakMode {
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = lineBreakMode;
    style.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributesDictionary = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self attributes:attributesDictionary];
    
    CGSize newSize = [attributedString boundingRectWithSize:CGSizeMake(limitWidth,limitHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return newSize;
}
- (CGFloat) heightWithFont:(UIFont *)font limitWidth:(CGFloat)limitWidth lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize size = [self sizeWithFont:font limitWidth:limitWidth limitHeight:CGFLOAT_MAX lineBreakMode:lineBreakMode];
    return size.height;
}
@end
