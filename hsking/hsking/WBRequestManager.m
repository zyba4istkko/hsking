//
//  WBURLProtocol.m
//  WerbaryKit
//
//  Created by Ivan Trufanov on 18.01.14.
//  Copyright (c) 2014 Werbary. All rights reserved.
//

#import "WBRequestManager.h"

@implementation WBRequestManager

+ (void) beginWorking {
    [NSURLProtocol registerClass:[WBURLProtocol class]];
}


static WBRequestManager * manager = NULL;
+ (WBRequestManager *) sharedManager {
    if (!manager || manager == NULL) {
        manager = [WBRequestManager new];
    }
    return manager;
}

- (void) reqStarted {
    numberOfReqs = numberOfReqs + 1;
    
    [self updateIndicator];
}
- (void) reqEnded {
    if (numberOfReqs > 0) {
        numberOfReqs = numberOfReqs - 1;
    }
    
    [self updateIndicator];
}

- (void) updateIndicator {
    if (numberOfReqs > 0) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    } else {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

@end


@implementation WBURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    if ([request.URL.absoluteString hasPrefix:@"data:"]) {
        return NO;
    }
    
    id marker = [NSURLProtocol propertyForKey:@"marker"
                                    inRequest:request];
    return (marker == nil);
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

- (instancetype)initWithRequest:(NSURLRequest *)request
       cachedResponse:(NSCachedURLResponse *)cachedResponse
               client:(id<NSURLProtocolClient>)client
{
    self = [super initWithRequest:request
                   cachedResponse:cachedResponse
                           client:client];
    if (self) {
        
        NSMutableURLRequest *mURLRequest = [request mutableCopy];
        [NSURLProtocol setProperty:@"yes"
                            forKey:@"marker"
                         inRequest:mURLRequest];
        
        _connection = [[NSURLConnection alloc] initWithRequest:[mURLRequest copy]
                                                      delegate:self startImmediately:NO];
    }
    return self;
}

- (void)startLoading
{
    [[WBRequestManager sharedManager] reqStarted];
    [self.connection start];
}

- (void)stopLoading
{
    [[WBRequestManager sharedManager] reqEnded];
    [self.connection cancel];
}

#pragma mark - NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [[self client] URLProtocol:self didLoadData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
    if (redirectResponse == nil) {

    }
    else {
        [[self client] URLProtocol:self wasRedirectedToRequest:request redirectResponse:redirectResponse];
    }
    return request;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[self client] URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[WBRequestManager sharedManager] reqEnded];
    [[self client] URLProtocol:self didFailWithError:error];
}

#pragma mark Connection Authentication

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [[self client] URLProtocol:self didCancelAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [[self client] URLProtocol:self didReceiveAuthenticationChallenge:challenge];
}

@end