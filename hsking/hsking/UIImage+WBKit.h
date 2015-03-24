//
//  UIImage+WBKit.h
//  WerbaryKit
//
//  Created by Иван Труфанов on 11.02.14.
//  Copyright (c) 2014 Werbary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WBKit)
- (UIImage *)imageWithTintColor:(UIColor *)color;

- (UIImage *) resizedImage:(CGSize)size;
- (UIImage *) roundedCornersImage:(CGFloat)cornerRadius;
@end
