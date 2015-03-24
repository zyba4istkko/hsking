//
//  UIAlertView+NSError.h
//  WerbaryKit
//
//  Created by Ivan Trufanov on 09.01.14.
//  Copyright (c) 2014 Werbary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (NSError)
+ (UIAlertView *) alertFromError:(NSError *)err;
@end
