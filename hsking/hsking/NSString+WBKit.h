//
//  NSString+WBKit.h
//  WerbaryKit
//
//  Created by Иван Труфанов on 18.01.14.
//  Copyright (c) 2014 Werbary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WBKit)

#pragma mark - URL Encoding/decoding
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *URLEncodedString;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *URLDecodedString;

#pragma mark - MD5
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *MD5;
@end
