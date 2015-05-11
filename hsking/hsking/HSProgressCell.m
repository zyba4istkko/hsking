//
//  HSProgressCell.m
//  hsking
//
//  Created by Иван Труфанов on 11.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSProgressCell.h"

@implementation HSProgressCell

- (void)awakeFromNib {
    // Initialization code
    
    constrProgress.constant = self.frame.size.width * self.progress;
    [self layoutIfNeeded];
    
    [super awakeFromNib];
}
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    constrProgress.constant = self.frame.size.width * self.progress;
    [self layoutIfNeeded];
}

@end
