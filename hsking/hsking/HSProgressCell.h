//
//  HSProgressCell.h
//  hsking
//
//  Created by Иван Труфанов on 11.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNSSwipeableCell.h"

@interface HSProgressCell : DNSSwipeableCell {
    IBOutlet NSLayoutConstraint *constrProgress;
}
@property (nonatomic) CGFloat progress;
@end
