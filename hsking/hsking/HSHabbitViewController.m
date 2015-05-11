//
//  HSHabbitViewController.m
//  hsking
//
//  Created by Иван Труфанов on 28.03.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import "HSHabbitViewController.h"
#import "UIColor+BFPaperColors.h"
#import "UIColor+HEX.h"
#import "UIImageView+WebCache.h"
#import "HSWebViewController.h"
#import "NSString+Size.h"
#import "HSMineManager.h"
#import "HSHabbitSettingsController.h"
#import "HSActivityManager.h"
#import "HSAuthManager.h"
#import "TSMessage.h"

@interface HSHabbitViewController ()

@end

@implementation HSHabbitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateProgress];
    [self setup];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.tabBarController.tabBar setHidden:YES];
}
- (void) updateProgress {
    CGFloat progress = [HSActivityManager progressForHabbit:_habbitDictionary];
    progressWidth.constant = self.view.frame.size.width * progress;
    [self.view layoutIfNeeded];
}
- (void) setup {
    BOOL isMine = [HSMineManager isMine:_habbitDictionary];
    if (isMine) {
        viewAdd.hidden = YES;
        viewProgress.hidden = NO;
        viewRemove.hidden = NO;
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"gear_settings"] style:UIBarButtonItemStylePlain target:self action:@selector(showSettings)];
        self.navigationItem.rightBarButtonItem = item;
        
        HabbitWorkStatus workState = [HSActivityManager workStatusForHabbit:_habbitDictionary];
        if (workState == HabbitWorkStatusDelayed || workState == HabbitWorkStatusNotWorking) {
            [bottomButton setTitleColor:[UIColor colorWithRed:0.13 green:0.81 blue:0.15 alpha:1] forState:UIControlStateNormal];
            [bottomButton setTitle:@"Начать" forState:UIControlStateNormal];
        } else if (workState == HabbitWorkStatusWorking) {
            [bottomButton setTitleColor:[UIColor colorWithRed:0.93 green:0.45 blue:0.31 alpha:1] forState:UIControlStateNormal];
            [bottomButton setTitle:@"Завершить" forState:UIControlStateNormal];
        } else {
            viewRemove.hidden = YES;
        }
    } else {
        viewAdd.hidden = NO;
        viewProgress.hidden = YES;
        viewRemove.hidden = YES;
    }
    labelName.text = _habbitDictionary[@"Name"];
    labelCategory.text = [_habbitDictionary[@"Category"][@"Name"] uppercaseString];
    
    NSString *hexColor = _habbitDictionary[@"bg_color"];
    if (!hexColor || [hexColor isKindOfClass:[NSNull class]]) {
        hexColor = @"#1E1E1E";
    }
    imgView.backgroundColor = [UIColor colorWithHEXString:hexColor];
    
    NSString *urlString = _habbitDictionary[@"ImageUrl"];
    if (urlString && ![urlString isKindOfClass:[NSNull class]]) {
        NSURL *url = [NSURL URLWithString:_habbitDictionary[@"ImageUrl"]];
        if (url) {
            [imgView sd_setImageWithURL:url];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {“
        UIFont *font = [UIFont systemFontOfSize:15];
        CGFloat width = tableView.frame.size.width - 30;
        NSString *str = _habbitDictionary[@"Description"];
    if (indexPath.row == 1) {
        str = _habbitDictionary[@"Feature"];
        width = width - 33;
    }
        CGSize size = [str sizeWithFont:font limitWidth:width limitHeight:CGFLOAT_MAX lineBreakMode:NSLineBreakByWordWrapping];
        return 46 + ceilf(size.height);
//    } else {
//        return 44;
//    }
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellDescription"];
        UILabel *descrLabel = (UILabel *)[cell viewWithTag:1];
        NSString *descr = _habbitDictionary[@"Description"];
        descrLabel.text = descr;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFeature"];
        UILabel *descrLabel = (UILabel *)[cell viewWithTag:1];
        NSString *descr = _habbitDictionary[@"Feature"];
        descrLabel.text = descr;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *htmlStr = nil;
    if (indexPath.row == 1) {
        htmlStr = _habbitDictionary[@"Solution"];
    } else if (indexPath.row == 2) {
        htmlStr = @"XXX";
    }
    if (htmlStr) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UINavigationController *nav = [sb instantiateViewControllerWithIdentifier:@"WebViewNav"];
        HSWebViewController *webViewController = nav.viewControllers[0];
        webViewController.HTMLString = htmlStr;
        [self presentViewController:nav animated:YES completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)bottomButtonClicked {
    HabbitWorkStatus workState = [HSActivityManager workStatusForHabbit:_habbitDictionary];
    if (workState == HabbitWorkStatusDelayed || workState == HabbitWorkStatusNotWorking) {
        [HSActivityManager setWorkStatus:HabbitWorkStatusWorking forHabbit:_habbitDictionary];
    } else {
        [HSActivityManager setWorkStatus:HabbitWorkStatusCompleted forHabbit:_habbitDictionary];
    }
    [self setup];
    
    [UIView animateWithDuration:0.2 animations:^(){
        [self updateProgress];
    }];
    
}
- (IBAction)showSettings {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *navController = [sb instantiateViewControllerWithIdentifier:@"HabbitSettingsNav"];
    HSHabbitSettingsController *vc = navController.viewControllers[0];
    vc.habbitDictionary = _habbitDictionary;
    [self presentViewController:navController animated:YES completion:nil];
}
- (IBAction)addToMyHabbits {
    if ([HSAuthManager isAuthenticated] ) {
        [HSMineManager addToMine:_habbitDictionary];
        
        [TSMessage showNotificationInViewController:self title:@"Привычка добавлена" subtitle:@"Самое время начать её развивать" type:TSMessageNotificationTypeSuccess duration:4];
        
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [HSAuthManager showAuthScreen];
    }
    
    [self setup];
}
- (IBAction)removeFromMyHabbits {
    [HSMineManager removeFromMine:_habbitDictionary];
    
    [self setup];
}

@end
