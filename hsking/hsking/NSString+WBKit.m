//
//  NSString+WBKit.m
//  WerbaryKit
//
//  Created by Иван Труфанов on 18.01.14.
//  Copyright (c) 2014 Werbary. All rights reserved.
//

#import "NSString+WBKit.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (WBKit)

- (NSString *)URLEncodedString
{
    NSString *result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
																		   CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8);
    CFAutorelease((__bridge CFStringRef)result);
	return result;
}

- (NSString*)URLDecodedString
{
	NSString *result = (__bridge NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)self,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8);
    CFAutorelease((__bridge CFStringRef)result);
	return result;
}


- (NSString *) MD5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

@end
