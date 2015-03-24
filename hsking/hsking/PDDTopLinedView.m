//
//  PDDTopLinedView.m
//  pdd
//
//  Created by Иван Труфанов on 03.12.14.
//  Copyright (c) 2014 werbary. All rights reserved.
//

#import "PDDTopLinedView.h"

@implementation PDDTopLinedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.8 alpha:1];
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:line];
}

@end
