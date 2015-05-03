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

@interface HSHabbitViewController ()

@end

@implementation HSHabbitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.tabBarController.tabBar setHidden:YES];
}
- (void) setup {
    BOOL isMine = YES;
    if (isMine) {
        viewAdd.hidden = YES;
        viewProgress.hidden = NO;
        viewRemove.hidden = NO;
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"gear_settings"] style:UIBarButtonItemStylePlain target:self action:@selector(showSettings)];
        self.navigationItem.rightBarButtonItem = item;
        
        CGFloat progress = 0.7;
        progressWidth.constant = self.view.frame.size.width * progress;
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
    if (indexPath.row == 0) {
        UIFont *font = [UIFont systemFontOfSize:15];
        CGFloat width = tableView.frame.size.width - 30;
        NSString *str = _habbitDictionary[@"Description"];
        CGSize size = [str sizeWithFont:font limitWidth:width limitHeight:CGFLOAT_MAX lineBreakMode:NSLineBreakByWordWrapping];
        return 46 + ceilf(size.height);
    } else {
        return 44;
    }
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellDescription"];
        UILabel *descrLabel = (UILabel *)[cell viewWithTag:1];
        NSString *descr = _habbitDictionary[@"Description"];
        descrLabel.text = descr;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellBasic"];
        if (indexPath.row == 1) {
            cell.textLabel.text = @"Зачем? + Бонусы";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Бонусы";
        }
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
- (IBAction)showSettings {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *navController = [sb instantiateViewControllerWithIdentifier:@"HabbitSettingsNav"];
    HSHabbitSettingsController *vc = navController.viewControllers[0];
    vc.habbitDictionary = _habbitDictionary;
    [self presentViewController:navController animated:YES completion:nil];
}
- (IBAction)addToMyHabbits {
    [HSMineManager addToMine:_habbitDictionary];
    
    [self setup];
}
- (IBAction)removeFromMyHabbits {
    [HSMineManager removeFromMine:_habbitDictionary];
    
    [self setup];
}

@end
