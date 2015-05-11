//
//  ContentViewController.m
//  pdd
//
//  Created by Иван Труфанов on 04.12.14.
//  Copyright (c) 2014 werbary. All rights reserved.
//

#import "ContentViewController.h"
//#import "WBInAppHelper.h"
#import "MBProgressHUD.h"
#import "HSAuthManager.h"
//#import "Constants.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!textLabel) {
        return;
    }
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = 5;
    style.alignment = NSTextAlignmentCenter;
    
    UIFont *font = textLabel.font;
    textLabel.attributedText = [[NSAttributedString alloc] initWithString:textLabel.text attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style}];
    
    if (priceBtn) {
//        [self updatePrices];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePrices) name:@"loaded_products_list" object:nil];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if (_pageIndex == 0) {
            imgView.image = [UIImage imageNamed:@"ExamMode iPad_Portrait"];
        } else if (_pageIndex == 1) {
            imgView.image = [UIImage imageNamed:@"HighwayCode_iPad_Portrait"];
        } else if (_pageIndex == 2) {
            imgView.image = [UIImage imageNamed:@"MyMistakes_iPad_Portrait"];
        }
        
        if (iconImgView) {
            [iconImgView setImage:[UIImage imageNamed:@"AppIcon_iPad"]];
            [discountImgView setImage:[UIImage imageNamed:@"Discount_Badge_iPad"]];
        }
    } else if ([[UIScreen mainScreen] bounds].size.height > 568) {
        if (_pageIndex == 0) {
            imgView.image = [UIImage imageNamed:@"ExamMode_iPhone5c_for6"];
        } else if (_pageIndex == 1) {
            imgView.image = [UIImage imageNamed:@"Search_iPhone5c_for6"];
        } else if (_pageIndex == 2) {
            imgView.image = [UIImage imageNamed:@"MyMistakes_iPhone5c_for6"];
        }

    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self hideTopTitle]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hide_title" object:nil];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self hideTopTitle]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"show_title" object:nil];
    }
}
- (IBAction)makeRegistration {
    [HSAuthManager showAuthScreen];
}
//- (void) updatePrices {
//    NSString *price = [WBInAppHelper priceStringFromProductId:fullVersionDiscProductId];
//    if ([price rangeOfString:@"Error"].location != NSNotFound) {
//        [priceBtn setTitle:@"Отсутствует соединение" forState:UIControlStateNormal];
//    } else {
//        [priceBtn setTitle:[NSString stringWithFormat:@"Купить за %@",price] forState:UIControlStateNormal];
//    }
//}

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
//- (void)buy {
//    [MBProgressHUD showHUDAddedTo:self.parentViewController.view animated:YES];
//    [WBInAppHelper payProduct:fullVersionDiscProductId resBlock:^(BOOL successB, NSError *err) {
//        [MBProgressHUD hideAllHUDsForView:self.parentViewController.view animated:YES];
//        
//        if (successB) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"purchased_full_version" object:nil];
//            [self dismissViewControllerAnimated:YES completion:nil];
//        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:[err localizedDescription] delegate:nil cancelButtonTitle:@"Ок" otherButtonTitles:nil];
//            [alert show];
//        }
//    }];
//}
- (BOOL) hideTopTitle {
    if (priceBtn && [[UIScreen mainScreen] bounds].size.height <= 480) {
        return YES;
    }
    return NO;
}
@end
