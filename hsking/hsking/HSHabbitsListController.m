//
//  ViewController.m
//  hsking
//
//  Created by Иван Труфанов on 16.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSHabbitsListController.h"
#import "HSDataManager.h"

#import "NSString+Size.h"

#import "NSString+FontAwesome.h"
#import "HSHabbitViewController.h"
#import "UIColor+HEX.h"

#import "UIImageView+WebCache.h"
#import "HSMineManager.h"
#import "HSActivityManager.h"

@interface HSHabbitsListController () {
    NSArray *habbits;
    
    NSArray *myHabbitsStatuses;
    NSDictionary *myHabbits;
}
@end

@implementation HSHabbitsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    [mainTable registerNib:[UINib nibWithNibName:@"headerMain" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"headerMain"];
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [mainTable deselectRowAtIndexPath:[mainTable indexPathForSelectedRow] animated:NO];
    
    myHabbits = [HSMineManager mineHabbitStateDict];
    myHabbitsStatuses = [[myHabbits allKeys] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"enum" ascending:YES]]];
    [mainTable reloadData];
}
- (void)setType:(ScreenType)type {
    _type = type;
    
    myHabbits = [HSMineManager mineHabbitStateDict];
    
    [mainTable reloadData];
}
- (void) setup {
    mainTable.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    
    [HSDataManager getAllHabbits:^(BOOL success, NSArray *habbitsN, NSError *err){
        habbits = habbitsN;
        [mainTable reloadData];
        
        indicator.alpha = 0;
    }];
}
- (void)clickedSegment:(UISegmentedControl *)sender {
    self.type = sender.selectedSegmentIndex;
}
#pragma mark - <UITableViewDataSource> and <UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_type == ScreenTypeMain) {
        return [myHabbits count];
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_type == ScreenTypeMain) {
        return [myHabbits[myHabbitsStatuses[section]] count];
    }
    if (!habbits) {
        return 0;
    }
    return habbits.count;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cellHabbit";
    if (_type) {
        identifier = @"cellHabbitActive";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UILabel *labelTitle = (UILabel *)[cell viewWithTag:1];
    UILabel *labelCategory = (UILabel *)[cell viewWithTag:2];
    UILabel *labelDescription = (UILabel *)[cell viewWithTag:3];
    UIImageView *imgBack = (UIImageView *)[cell viewWithTag:4];
    
    NSDictionary *habbit = [self habbit:indexPath];
    labelTitle.text = habbit[@"Name"];
    labelDescription.attributedText = [[NSAttributedString alloc] initWithString:habbit[@"Description"] attributes:[self textAttributes]];
    labelCategory.text = [habbit[@"Category"][@"Name"] uppercaseString];
    
    NSString *hexColor = habbit[@"bg_color"];
    if (!hexColor) {
        hexColor = @"#1E1E1E";
    }
    imgBack.backgroundColor = [UIColor colorWithHEXString:hexColor];
    
    NSString *urlString = habbit[@"ImageUrl"];
    if (urlString && ![urlString isKindOfClass:[NSNull class]]) {
        NSURL *url = [NSURL URLWithString:habbit[@"ImageUrl"]];
        if (url) {
            [imgBack sd_setImageWithURL:url];
        }
    }
    
    if (_type == ScreenTypeMain) {
        UIImageView *imgViewIcon = (UIImageView *)[cell viewWithTag:5];
        imgViewIcon.tintColor = [UIColor whiteColor];
        
        HabbitWorkStatus state = [HSActivityManager workStatusForHabbit:habbit];
        if (state == HabbitWorkStatusCompleted) {
            [imgViewIcon setImage:[UIImage imageNamed:@"done_icon"]];
        } else if (state == HabbitWorkStatusDelayed) {
            [imgViewIcon setImage:[UIImage imageNamed:@"delayed_icon"]];
        } else if (state == HabbitWorkStatusFailed) {
            [imgViewIcon setImage:[UIImage imageNamed:@"failed_icon"]];
        } else if (state == HabbitWorkStatusNotWorking) {
            [imgViewIcon setImage:[UIImage imageNamed:@"play_icon"]];
        } else if (state == HabbitWorkStatusWorking) {
            
        }
    }
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_type == ScreenTypeMain) {
        return 56;
    }
    return 0;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_type == ScreenTypeMain) {
        UIView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerMain"];
        UILabel *label = (UILabel *)[view viewWithTag:1];
        label.text = [myHabbitsStatuses[section][@"name"] uppercaseString];
        return view;
    }
    return nil;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 97;
    
    NSDictionary *habbit = [self habbit:indexPath];
    
    CGFloat titleHeight = [habbit[@"Name"] heightWithFont:[UIFont fontWithName:@"HelveticaNeueCyr-Medium" size:17] limitWidth:tableView.frame.size.width-15*2 lineBreakMode:NSLineBreakByWordWrapping];
    NSAttributedString *description = [[NSAttributedString alloc] initWithString:habbit[@"Description"] attributes:[self textAttributes]];

    CGFloat descriptionHeight = [description boundingRectWithSize:CGSizeMake(tableView.frame.size.width - 15*2,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
    
    CGFloat otherHeight = 41;
    CGFloat minHeight = 60;
    
    CGFloat height = titleHeight + otherHeight + descriptionHeight;
    return MAX(height,minHeight);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    HSHabbitViewController *habbitController = [storyboard instantiateViewControllerWithIdentifier:@"HSHabbitViewController"];
    habbitController.habbitDictionary = [self habbit:indexPath];
    [self.navigationController pushViewController:habbitController animated:YES];
}

#pragma mark - Data
- (NSDictionary *) habbit:(NSIndexPath *)path {
    if (_type == ScreenTypeMain) {
        return myHabbits[myHabbitsStatuses[path.section]][path.row];
    }
    return habbits[path.row];
}
- (NSDictionary *)textAttributes {
 UIFont *font = [UIFont fontWithName:@"HelveticaNeueCyr-Italic" size:12.5];
 NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
 style.alignment = NSTextAlignmentCenter;
 style.lineSpacing = 5;
 style.lineBreakMode = NSLineBreakByWordWrapping;
 
 NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
 return attributes;
}

@end
