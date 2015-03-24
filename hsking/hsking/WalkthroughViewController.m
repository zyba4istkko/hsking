//
//  WalkthroughViewController.m
//  pdd
//
//  Created by Иван Труфанов on 04.12.14.
//  Copyright (c) 2014 werbary. All rights reserved.
//

#import "WalkthroughViewController.h"
#import "UIAlertView+Blocks.h"

@interface WalkthroughViewController ()

@end

@implementation WalkthroughViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide) name:@"hide_title" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show) name:@"show_title" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void) hide {
    [UIView animateWithDuration:0.25 animations:^{
        titleLabel.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}
- (void) show {
    [UIView animateWithDuration:0.25 animations:^{
        titleLabel.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Orientation
- (NSUInteger) supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return NO;
}

- (void)dismiss {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismiss_walkthrough" object:self];
}
@end
