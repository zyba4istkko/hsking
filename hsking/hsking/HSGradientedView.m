//
//  HSGradientedView.m
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSGradientedView.h"

@implementation HSGradientedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = self.bounds;
//    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[_gradient CGColor], nil];
//    [self.layer addSublayer:gradient];
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = self.bounds;
    gradient.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
    gradient.locations = @[@0.0, @1.0];
    
    self.layer.mask = gradient;
}
//- (void)setGradient:(UIColor *)gradient {
//    _gradient = gradient;
//    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = self.bounds;
//    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[_gradient CGColor], nil];
//    [self.layer addSublayer:gradientLayer];
//}
@end
