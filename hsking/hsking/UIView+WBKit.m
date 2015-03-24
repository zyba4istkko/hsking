//
//  UIView+WBKit.m
//  WerbaryKit
//
//  Created by Иван Труфанов on 17.01.14.
//  Copyright (c) 2014 werbary. All rights reserved.
//

#import "UIView+WBKit.h"

@implementation UIView (WBKit)

#pragma mark - Position
- (CGFloat) x {
    return self.frame.origin.x;
}
- (CGFloat) y {
    return self.frame.origin.y;
}
- (CGPoint) origin {
    return self.frame.origin;
}

- (CGFloat) width {
    return self.frame.size.width;
}
- (CGFloat) height {
    return self.frame.size.height;
}
- (CGSize) size {
    return self.frame.size;
}

- (void) setX:(CGFloat)x {
    if (!isnan(x)) {
        self.frame = CGRectMake(x, self.y, self.width, self.height);
    }
}
- (void) setY:(CGFloat)y {
    if (!isnan(y)) {
        self.frame = CGRectMake(self.x, y, self.width, self.height);
    }
}
- (void) setOrigin:(CGPoint)origin {
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
}
- (void) setWidth:(CGFloat)width {
    if (!isnan(width)) {
        self.frame = CGRectMake(self.x, self.y, width, self.height);
    }
}
- (void) setHeight:(CGFloat)height {
    if (!isnan(height)) {
        self.frame = CGRectMake(self.x, self.y, self.width, height);
    }
}
- (void) setSize:(CGSize)size {
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}



#pragma mark - HUD
- (void) showHUD:(BOOL)animated {
    
}
- (void) hideHUD:(BOOL)animated {
    
}
@end
