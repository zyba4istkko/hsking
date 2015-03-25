//
//  AMConnection.h
//  Werbary
//
//  Created by Иван Труфанов on 07.07.14.
//  Copyright (c) 2014 Werbary. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    RequestTypeGET,
    RequestTypePOST,
    RequestTypePUT,
    RequestTypePATCH,
    RequestTypeDELETE,
    RequestTypeMultipartPUT,
    RequestTypeMultipartPOST,
    RequestTypeMultipartPatch,
    RequestTypeJSONPOST
} RequestType;

typedef void (^VMConnectionResultBlock)(BOOL success,NSHTTPURLResponse *httpResponse, id respObject, NSError *err);

@interface VMConnection : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate, NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionTaskDelegate> {
    BOOL triedToLogin;
    
    NSMutableDictionary *taskResultBlocks;
    NSMutableDictionary *taskParameters;
    NSMutableDictionary *taskDatas;
    
    NSURLSession *session;
}
+ (VMConnection *) sendRequestToPath:(NSString *)path withParameters:(NSDictionary *)parameters reqType:(RequestType)type resBlock:(VMConnectionResultBlock)resBlock;
+ (VMConnection *) sendRequestToPath:(NSString *)path withJSONObjectBody:(NSDictionary *)parameters resBlock:(VMConnectionResultBlock)resBlock;
+ (VMConnection *) sendRequestToPath:(NSString *)path withParameters:(NSDictionary *)parameters withHTTPHeaders:(NSDictionary *)headers reqType:(RequestType)type resBlock:(VMConnectionResultBlock)resBlock;

+ (void) cleanUpCookies;

+ (instancetype) instance;
- (void) setup;
- (void) sendToPath:(NSString *)apiPath parameters:(NSDictionary *)parameters headers:(NSDictionary *)headers reqType:(RequestType)typeOfRequest withResBlock:(VMConnectionResultBlock)resBlock;
- (void) cancel;
@end
