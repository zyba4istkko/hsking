//
//  UIImage+WBKit.m
//  WerbaryKit
//
//  Created by Иван Труфанов on 11.02.14.
//  Copyright (c) 2014 Werbary. All rights reserved.
//

#import "UIImage+WBKit.h"

@implementation UIImage (WBKit)
- (UIImage *)imageWithTintColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *) resizedImage:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *) roundedCornersImage:(CGFloat)cornerRadius {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height)
                                cornerRadius:cornerRadius] addClip];
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
