//
//  ViewController.h
//  hsking
//
//  Created by Иван Труфанов on 16.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ScreenTypeAll,
    ScreenTypeMain
} ScreenType;

@interface HSHabbitsListController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *mainTable;
    
    IBOutlet UIActivityIndicatorView *indicator;
    IBOutlet UISegmentedControl *segmentedControl;
}
@property (nonatomic) ScreenType type;
- (IBAction)clickedSegment:(UISegmentedControl *)sender;
@end

