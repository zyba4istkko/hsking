//
//  HSHabbitViewController.h
//  hsking
//
//  Created by Иван Труфанов on 28.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BFPaperButton.h"

@interface HSHabbitViewController : UIViewController {
    BFPaperButton *plusButton;
}
@property (nonatomic, strong) NSDictionary *habbitDictionary;
@end
