//
//  UIViewController+Utils.h
//  podRukoy
//
//  Created by Иван Труфанов on 17.04.15.
//  Copyright (c) 2015 Ratmanskiy Alexey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)
+(UIViewController*) findBestViewController:(UIViewController*)vc;
+(UIViewController*) currentViewController;
@end
