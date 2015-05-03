//
//  HSWebViewController.h
//  hsking
//
//  Created by Иван Труфанов on 03.05.15.
//  Copyright (c) 2015 Werbary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSWebViewController : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *webView;
}
@property (nonatomic, strong) NSString *HTMLString;
@end
