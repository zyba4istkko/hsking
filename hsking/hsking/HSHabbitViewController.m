//
//  HSHabbitViewController.m
//  hsking
//
//  Created by Иван Труфанов on 28.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSHabbitViewController.h"
#import "UIColor+BFPaperColors.h"

@interface HSHabbitViewController ()

@end

@implementation HSHabbitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    plusButton = [[BFPaperButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-86)/2, self.view.frame.size.height - 86 - 40 - 64, 86, 86) raised:YES];
    [plusButton setImage:[UIImage imageNamed:@"x"] forState:UIControlStateSelected];
    [plusButton setImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
    [plusButton setTitleFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:40.f]];
    [plusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [plusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [plusButton addTarget:self action:@selector(plusPressed:) forControlEvents:UIControlEventTouchUpInside];
    plusButton.backgroundColor = [UIColor paperColorGreen300];
    plusButton.tapCircleColor = [UIColor paperColorGreen300];
    plusButton.cornerRadius = plusButton.frame.size.width / 2;
    plusButton.rippleFromTapLocation = NO;
    plusButton.rippleBeyondBounds = YES;
    plusButton.tapCircleDiameter = MAX(plusButton.frame.size.width, plusButton.frame.size.height) * 1.3;
    [self.view addSubview:plusButton];
}

- (void) plusPressed:(BFPaperButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        sender.backgroundColor = [UIColor paperColorRed300];
        sender.tapCircleColor = [UIColor paperColorRed300];
    } else {
        sender.backgroundColor = [UIColor paperColorGreen300];
        sender.tapCircleColor = [UIColor paperColorGreen300];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
