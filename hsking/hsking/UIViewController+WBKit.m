//
//  UIViewController+WBKit.m
//  WerbaryKit
//
//  Created by Ivan Trufanov on 10.01.14.
//  Copyright (c) 2014 Werbary. All rights reserved.
//

#import "UIViewController+WBKit.h"

@implementation UIViewController (WBKit)
- (IBAction)back {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
    }
}
- (IBAction)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
