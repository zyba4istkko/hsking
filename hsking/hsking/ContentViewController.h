//
//  ContentViewController.h
//  pdd
//
//  Created by Иван Труфанов on 04.12.14.
//  Copyright (c) 2014 werbary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController {
    IBOutlet UILabel *textLabel;
    IBOutlet UIButton *priceBtn;
    IBOutlet UIImageView *imgView;
    IBOutlet UIImageView *iconImgView;
    IBOutlet UIImageView *discountImgView;
}
@property (nonatomic) NSInteger pageIndex;
- (IBAction)makeRegistration;
- (BOOL) hideTopTitle;
@end
