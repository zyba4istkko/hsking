//
//  UIView+Shake.m
//  meeting
//
//  Created by Иван Труфанов on 22.08.13.
//  Copyright (c) 2013 werbary. All rights reserved.
//

#import "UIView+Shake.h"

@implementation UIView (Shake)
- (void) shake {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.08];
    [animation setRepeatCount:2];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake([self center].x - 5.0f, [self center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake([self center].x + 5.0f, [self center].y)]];
    [[self layer] addAnimation:animation forKey:@"position"];
}
@end
