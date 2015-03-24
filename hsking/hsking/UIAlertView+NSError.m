//
//  UIAlertView+NSError.m
//  WerbaryKit
//
//  Created by Ivan Trufanov on 09.01.14.
//  Copyright (c) 2014 Werbary. All rights reserved.
//

#import "UIAlertView+NSError.h"
#import "NSError+WBKit.h"

@implementation UIAlertView (NSError)
+ (UIAlertView *) alertFromError:(NSError *)err {
    return [[UIAlertView alloc] initWithTitle:[err errorTitle] message:[err errorDescription] delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil];
}
@end
