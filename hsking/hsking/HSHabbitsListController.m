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

@interface HSHabbitsListController () {
    NSArray *habbits;
}
@end

@implementation HSHabbitsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [mainTable deselectRowAtIndexPath:[mainTable indexPathForSelectedRow] animated:NO];
}
- (void) setup {
    [HSDataManager getAllHabbits:^(BOOL success, NSArray *habbitsN, NSError *err){
        habbits = habbitsN;
        [mainTable reloadData];
        
        indicator.alpha = 0;
    }];
}

#pragma mark - <UITableViewDataSource> and <UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!habbits) {
        return 0;
    }
    return habbits.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellHabbit"];
    UILabel *labelTitle = (UILabel *)[cell viewWithTag:1];
    UILabel *labelCategory = (UILabel *)[cell viewWithTag:2];
    UILabel *labelDescription = (UILabel *)[cell viewWithTag:3];
    
    NSDictionary *habbit = [self habbit:indexPath];
    labelTitle.text = habbit[@"Name"];
    labelDescription.attributedText = [[NSAttributedString alloc] initWithString:habbit[@"Description"] attributes:[self textAttributes]];
    labelCategory.text = habbit[@"Category"][@"Name"];
    
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    return habbits[path.row];
}
- (NSDictionary *)textAttributes {
 UIFont *font = [UIFont fontWithName:@"HelveticaNeueCyr-Roman" size:13.0];
 NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
 style.alignment = NSTextAlignmentLeft;
 style.lineSpacing = 5;
 style.lineBreakMode = NSLineBreakByWordWrapping;
 
 NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
 return attributes;
}

@end
