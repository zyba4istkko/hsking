//
//  NSMutableURLRequest+MultipartForm.m
//  Kefir
//
//  Created by Иван Труфанов on 16.12.13.
//  Copyright (c) 2013 wit. All rights reserved.
//

#import "NSMutableURLRequest+MultipartForm.h"

@implementation NSMutableURLRequest (MultipartForm)
- (void) setMultipartData:(NSDictionary *)data {
    NSString *boundary = @"1BEF0A57BE110FD467A";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [self addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *bodyDataM = [[NSMutableData alloc] init];
    for (NSString *key in [data allKeys]) {
        [bodyDataM appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        id object = data[key];
        if ([object isKindOfClass:[NSNumber class]]) {
            [bodyDataM appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyDataM appendData:[[(NSNumber *)data[key] stringValue] dataUsingEncoding:NSUTF8StringEncoding]];
        } else if ([object isKindOfClass:[NSString class]]) {
            [bodyDataM appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyDataM appendData:[(NSString *)data[key] dataUsingEncoding:NSUTF8StringEncoding]];
        } else if ([object isKindOfClass:[NSData class]]) {
            [bodyDataM appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.png\"\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyDataM appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyDataM appendData:data[key]];
        } else if ([object isKindOfClass:[UIImage class]]) {
            [bodyDataM appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpeg\"\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyDataM appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [bodyDataM appendData:UIImageJPEGRepresentation(data[key], 1.0)];
        }
    }
    [bodyDataM appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    [self setHTTPBody:bodyDataM];
}
@end
