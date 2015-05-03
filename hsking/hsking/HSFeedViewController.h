//
//  HSFeedViewController.h
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSFeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *table;
}
@end
