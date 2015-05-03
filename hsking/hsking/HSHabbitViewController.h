//
//  HSHabbitViewController.h
//  hsking
//
//  Created by Иван Труфанов on 28.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BFPaperButton.h"

@interface HSHabbitViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *table;
    IBOutlet UIImageView *imgView;
    IBOutlet UILabel *labelCategory;
    IBOutlet UILabel *labelName;
    
    IBOutlet UIView *viewAdd;
    IBOutlet UIView *viewProgress;
    IBOutlet NSLayoutConstraint *progressWidth;
    IBOutlet UIView *viewRemove;
}
@property (nonatomic, strong) NSDictionary *habbitDictionary;
- (IBAction)addToMyHabbits;
- (IBAction)removeFromMyHabbits;
@end
