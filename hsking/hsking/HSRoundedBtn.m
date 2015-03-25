//
//  HSRoundedBtn.m
//  hsking
//
//  Created by Иван Труфанов on 25.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSRoundedBtn.h"

@implementation HSRoundedBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.layer.cornerRadius = frame.size.width/2;
    self.layer.masksToBounds = YES;
}

@end
