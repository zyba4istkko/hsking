//
//  HSSelectorViewController.h
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Callback)(NSArray *newSelectedValues);
@interface HSSelectorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *table;
    
    NSMutableArray *selectedNew;
}
@property (nonatomic, copy) Callback callback;
@property (nonatomic) BOOL multiplySelection;
@property (nonatomic, strong) NSArray *values;
@property (nonatomic, strong) NSArray *selectedValues;
@end
