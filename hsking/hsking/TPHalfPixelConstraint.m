//
//  TPHalfPixelConstraint.m
//  taxi-price
//
//  Created by Иван Труфанов on 07.02.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "TPHalfPixelConstraint.h"

@implementation TPHalfPixelConstraint
- (void)awakeFromNib {
    [super awakeFromNib];
    
    if ([[UIScreen mainScreen] scale] == 1) {
        [self setConstant:1];
        return;
    }
    [self setConstant:0.5];
}
@end
