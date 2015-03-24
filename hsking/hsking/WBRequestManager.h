//
//  WBURLProtocol.h
//  WerbaryKit
//
//  Created by Ivan Trufanov on 18.01.14.
//  Copyright (c) 2014 Werbary. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface WBRequestManager : NSObject {
    NSInteger numberOfReqs;
}
//Start working
+ (void) beginWorking;

//Private
+ (WBRequestManager *)sharedManager;

- (void) reqStarted;
- (void) reqEnded;
@end

@interface WBURLProtocol : NSURLProtocol <NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property(nonatomic, strong) NSURLConnection *connection;
@property(nonatomic, strong) NSURLResponse *response;
@property(nonatomic, strong) NSMutableData *data;
@end
