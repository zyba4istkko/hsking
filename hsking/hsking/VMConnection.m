//
//  AMConnection.m
//  amoCRM
//
//  Created by Иван Труфанов on 07.07.14.
//  Copyright (c) 2014 AmoCRM. All rights reserved.
//

#import "VMConnection.h"

#import "HSAuthManager.h"

#import "NSString+WBKit.h"
#import "NSError+WBKit.h"
#import "NSMutableURLRequest+MultipartForm.h"

@implementation VMConnection
+ (VMConnection *) sendRequestToPath:(NSString *)path withParameters:(NSDictionary *)parameters reqType:(RequestType)type resBlock:(VMConnectionResultBlock)resBlock{
    return [self sendRequestToPath:path withParameters:parameters withHTTPHeaders:@{} reqType:type resBlock:resBlock];
}
+ (VMConnection *) sendRequestToPath:(NSString *)path withJSONObjectBody:(NSDictionary *)parameters resBlock:(VMConnectionResultBlock)resBlock {
    NSData *data = nil;
    NSError *err = nil;
    data = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&err];
    if (err) {
        resBlock(nil,nil,nil,err);
        return nil;
    } else {
        return [self sendRequestToPath:path withParameters:(NSDictionary *)data withHTTPHeaders:@{@"content-type":@"application/json"} reqType:RequestTypePOST resBlock:resBlock];
    }
}
+ (VMConnection *) sendRequestToPath:(NSString *)path withParameters:(NSDictionary *)parameters withHTTPHeaders:(NSDictionary *)headers reqType:(RequestType)type resBlock:(VMConnectionResultBlock)resBlock {
    VMConnection *connection = [VMConnection instance];
    [connection sendToPath:path parameters:parameters headers:headers reqType:type withResBlock:resBlock];
    return connection;
}
+ (void)cleanUpCookies {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [cookieStorage cookiesForURL:[NSURL URLWithString:apiURL]];
    for (NSHTTPCookie *cookie in cookies) {
        NSLog(@"Deleting cookie for domain: %@", [cookie domain]);
        [cookieStorage deleteCookie:cookie];
    }
}

#pragma mark - AMConnection object actions
static VMConnection *connection = nil;
+ (instancetype) instance {
    if (!connection) {
        connection = [VMConnection new];
        [connection setup];
    }
    return connection;
}

- (void) setup {
    taskResultBlocks = [NSMutableDictionary new];
    taskParameters = [NSMutableDictionary new];
    taskDatas = [NSMutableDictionary new];
}
- (void) sendToPath:(NSString *)apiPath parameters:(NSDictionary *)parametersR headers:(NSDictionary *)headers reqType:(RequestType)typeOfRequest withResBlock:(VMConnectionResultBlock)resBlock {
    NSMutableDictionary *reqParameters = [NSMutableDictionary new];
    if (!apiPath) {
        return;
    }
    reqParameters[@"api_path"] = apiPath;
    reqParameters[@"req_type"] = @(typeOfRequest);
    if (parametersR) {
        reqParameters[@"parameters"] = parametersR;
    }
    if (headers) {
        reqParameters[@"headers"] = headers;
    }
    [self sendRequestWithParameters:reqParameters resBlock:resBlock];
}
- (void) sendRequestWithParameters:(NSDictionary *)parametersOfReq resBlock:(VMConnectionResultBlock)resBlock {
    NSString *apiPath = parametersOfReq[@"api_path"];
    RequestType typeOfRequest = (RequestType)[parametersOfReq[@"req_type"] integerValue];
    NSDictionary *parameters = parametersOfReq[@"parameters"];
    if (!parameters) {
        parameters = [NSDictionary new];
    }
    NSDictionary *headers = parametersOfReq[@"headers"];
    
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@%@?",apiURL,apiPath];
    
    NSMutableString *parametersString = [NSMutableString new];
    if ([parameters isKindOfClass:[NSString class]]) {
        parametersString = (NSMutableString *)[parameters mutableCopy];
    } else if ([parameters isKindOfClass:[NSData class]]) {
        parametersString = (NSMutableString *)parameters;
    } else if (typeOfRequest != RequestTypeMultipartPUT && typeOfRequest != RequestTypeMultipartPatch && typeOfRequest != RequestTypeMultipartPOST && typeOfRequest != RequestTypeJSONPOST) {
        if ([HSAuthManager isAuthenticated]) {
            NSMutableDictionary *parametersCopy = [parameters mutableCopy];
            parametersCopy[@"token"] = [HSAuthManager authToken];
            parameters = parametersCopy;
        }
        
        for (NSString *key in parameters.allKeys) {
            if (parametersString.length > 0) {
                [parametersString appendString:@"&"];
            }
            if ([parameters[key] isKindOfClass:[NSString class]]) {
                [parametersString appendFormat:@"%@=%@",key,[parameters[key] URLEncodedString]];
            } else if ([parameters[key] isKindOfClass:[NSNumber class]]) {
                [parametersString appendFormat:@"%@=%@",key,[parameters[key] stringValue]];
            } else {
                NSException *excp = [NSException exceptionWithName:@"AMConnection support only string values for GET requests" reason:[NSString stringWithFormat:@"Object at key %@ is %@",key,NSStringFromClass([parameters[key] class])] userInfo:nil];
                [excp raise];
            }
        }
    }
    
    
    if (typeOfRequest == RequestTypeGET) {
        NSRange questionRange = [urlString rangeOfString:@"?"];
        BOOL withoutAmp = NO;
        if (questionRange.location == NSNotFound) {
            [urlString appendString:@"?"];
            withoutAmp = YES;
        } else if ([urlString rangeOfString:@"&"].location == NSNotFound) {
            withoutAmp = YES;
        }
        
        if (!withoutAmp) {
            [urlString appendString:@"&"];
        }
        
        [urlString appendString:parametersString];
    } else {
        if ([HSAuthManager isAuthenticated]) {
            [urlString appendString:@"token="];
            [urlString appendString:[HSAuthManager authToken]];
        }
    }
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    if (typeOfRequest == RequestTypeGET) {
        [req setHTTPMethod:@"GET"];
    } else if (typeOfRequest == RequestTypePOST || typeOfRequest == RequestTypePUT || typeOfRequest == RequestTypePATCH || typeOfRequest == RequestTypeDELETE) {
        if (typeOfRequest == RequestTypePUT) {
            [req setHTTPMethod:@"PUT"];
        } else if (typeOfRequest == RequestTypePATCH) {
            [req setHTTPMethod:@"PATCH"];
        } else if (typeOfRequest == RequestTypeDELETE) {
            [req setHTTPMethod:@"DELETE"];
        } else {
            [req setHTTPMethod:@"POST"];
        }
        if ([parametersString isKindOfClass:[NSData class]]) {
            [req setHTTPBody:(NSData *)parametersString];
        } else {
            [req setHTTPBody:[parametersString dataUsingEncoding:NSUTF8StringEncoding]];
        }
        [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    } else if (typeOfRequest == RequestTypeMultipartPUT) {
        [req setMultipartData:parameters];
        [req setHTTPMethod:@"PUT"];
    } else if (typeOfRequest == RequestTypeMultipartPatch) {
        [req setMultipartData:parameters];
        [req setHTTPMethod:@"PATCH"];
    } else if (typeOfRequest == RequestTypeMultipartPOST) {
        [req setMultipartData:parameters];
        [req setHTTPMethod:@"POST"];
    } else if (typeOfRequest == RequestTypeJSONPOST) {
        [req setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil]];
        [req setHTTPMethod:@"POST"];
        [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    
    for (NSString *key in headers.allKeys) {
        [req setValue:headers[key] forHTTPHeaderField:key];
    }
    [req setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    
    if (!session) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        sessionConfig.allowsCellularAccess = YES;
        
        sessionConfig.timeoutIntervalForRequest = 30.0;
        sessionConfig.timeoutIntervalForResource = 60.0;
        sessionConfig.HTTPMaximumConnectionsPerHost = 1;
        
        sessionConfig.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
        
        sessionConfig.HTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        sessionConfig.HTTPShouldSetCookies = YES;
        sessionConfig.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicyAlways;
        
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    }
    
    NSString *str = [[NSString alloc] initWithData:req.HTTPBody encoding:NSUTF8StringEncoding];
    LogBlue(@"Request\nURL:\t%@\nHTTP Method:\t%@\nBody:\t%@",req.URL,req.HTTPMethod,str);
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:req];
    [task resume];
    
    if (resBlock) {
        taskResultBlocks[@(task.taskIdentifier)] = resBlock;
    }
    
    taskParameters[@(task.taskIdentifier)] = parametersOfReq;
}
- (void) cancel {
    [session invalidateAndCancel];
    session = nil;
}

+ (id) cleanObj:(id)obj {
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)obj;
        
        NSMutableDictionary *mutableCopy = [NSMutableDictionary new];
        for (NSString *key in [dict allKeys]) {
            mutableCopy[key] = [self cleanObj:dict[key]];
        }
        return mutableCopy;
    } else if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)obj;
        
        NSMutableArray *mutableCopy = [NSMutableArray new];
        for (id obj in array) {
            [mutableCopy addObject:[self cleanObj:obj]];
        }
        return mutableCopy;
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        str = [str stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        str = [str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        return str;
    } else {
        return obj;
    }
}

#pragma mark - <NSURLSessionDelegate>
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        VMConnectionResultBlock resBlock = [self resBlockForTask:task.taskIdentifier];
        if (resBlock) {
            NSData *data = taskDatas[@(task.taskIdentifier)];
            
            if (error || !data) {
                resBlock(NO,(NSHTTPURLResponse *)task.response,data,error);
                
                [taskResultBlocks removeObjectForKey:@(task.taskIdentifier)];
                [taskParameters removeObjectForKey:@(task.taskIdentifier)];
            } else {
                NSError *errJson = nil;
                
                NSDictionary *jsonParsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&errJson];
                if (!errJson) {
                    jsonParsed = [VMConnection cleanObj:jsonParsed];
                    
//                    NSString *errServer = jsonParsed[@"response"][@"error"];
//                    if (errServer) {
//                        resBlock(NO,(NSHTTPURLResponse *)task.response, jsonParsed[@"response"], [NSError errorWithTitle:NSLocalizedString(@"Sorry", nil) description:errServer]);
//                    } else {
                        resBlock(YES,(NSHTTPURLResponse *)task.response, jsonParsed,nil);
//                    }
                } else {
                    LogRed(@"Failed to parse JSON.\nURL:%@\nResp:%@\nBody:%@",task.response.URL,task.response,[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                    resBlock(NO,(NSHTTPURLResponse *)task.response,data,errJson);
                }
                
                [taskResultBlocks removeObjectForKey:@(task.taskIdentifier)];
                [taskParameters removeObjectForKey:@(task.taskIdentifier)];
                [taskDatas removeObjectForKey:@(task.taskIdentifier)];
            }
        }
    }];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSMutableData *dataStore = taskDatas[@(dataTask.taskIdentifier)];
        if (!dataStore) {
            dataStore = [NSMutableData new];
        }
        [dataStore appendData:data];
        taskDatas[@(dataTask.taskIdentifier)] = dataStore;
    }];
}


#pragma mark - <NSURLSessionDataDelegate>
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    NSLog(@"Finished");
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSHTTPURLResponse *recievedResponse = (NSHTTPURLResponse *)response;
        
        NSInteger statusCode = [recievedResponse statusCode];
        
        if (statusCode == 204) {
            [dataTask cancel];
            
            VMConnectionResultBlock resBlock = [self resBlockForTask:dataTask.taskIdentifier];
            if (resBlock) {
                resBlock(YES,(NSHTTPURLResponse *)response,nil,nil);
            }
            
            [taskResultBlocks removeObjectForKey:@(dataTask.taskIdentifier)];
            [taskParameters removeObjectForKey:@(dataTask.taskIdentifier)];
        } else {
            completionHandler(NSURLSessionResponseAllow);
        }
    }];
}

#pragma mark - <NSURLSessionTaskDelegate>
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest *))completionHandler {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
        if ([httpResp.allHeaderFields[@"Set-Cookie"] rangeOfString:@"amo_redesign=N"].location != NSNotFound && httpResp) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"new_design_unavailiable"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSMutableURLRequest *req = [request mutableCopy];
            
            NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSMutableArray *cookies = [[cookieStorage cookiesForURL:[NSURL URLWithString:apiURL]] mutableCopy];
            
            NSDictionary *headerCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
            for (NSString *key in headerCookies.allKeys) {
                [req setValue:headerCookies[key] forHTTPHeaderField:key];
            }
            
            completionHandler(req);
            return;
        }
        
        completionHandler (request);
    }];
}

#pragma mark - Data management
- (NSDictionary *) parametersForTask:(NSUInteger)taskIdentifier {
    return taskParameters[@(taskIdentifier)];
}
- (VMConnectionResultBlock) resBlockForTask:(NSUInteger)taskIdentifier {
    return taskResultBlocks[@(taskIdentifier)];
}
@end
