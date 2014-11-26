//
//  A55Request.m
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import <objc/runtime.h>
#import "A55Request.h"
#import "A55JsonParser.h"
#import "A55Exception.h"
#import "A55Gateway.h"

static const char * kA55ResponseHandler = "app55.responseHandler";
static const char * kA55ErrorHandler = "app55.errorHandler";
static const char * kA55ResponseBuffer = "app55.responseBuffer";

static void _A55ConvertValue(NSMutableDictionary *dictout, NSString *key, id value);
static NSDictionary *_A55ArrayToDottedDictionary(NSArray *array, NSString *path);
static NSDictionary *_A55ObjectToDottedDictionary(A55Object *object, NSString *path);
NSDictionary *A55ObjectToDottedDictionary(A55Object *object);



static inline void _A55ConvertValue(__weak NSMutableDictionary *dictout, __weak NSString *key, __weak id value) {
    if([value isKindOfClass:[A55Object class]])
        [dictout addEntriesFromDictionary:_A55ObjectToDottedDictionary(value, key)];
    else if([value isKindOfClass:[NSArray class]])
        [dictout addEntriesFromDictionary:_A55ArrayToDottedDictionary(value, key)];
    else if(value) {
        if([value isKindOfClass:[NSNumber class]]) {
            if(value == (void*)kCFBooleanFalse) [dictout setValue:@"false" forKey:key];
            else if(value == (void*)kCFBooleanTrue) [dictout setValue:@"true" forKey:key];
            else [dictout setValue:[value stringValue] forKey:key];
        } else {
            [dictout setValue:[NSString stringWithFormat:@"%@", value] forKey:key];
        }
    }
}

static inline NSDictionary *_A55ArrayToDottedDictionary(__weak NSArray *array, __weak NSString *path) {
    NSMutableDictionary *dictout = [NSMutableDictionary dictionary];
    for(int i = 0; i < array.count; i++) {
        id value = [array objectAtIndex:i];
        NSString *key = [NSString stringWithFormat:@"%@.%d", path, i];
        _A55ConvertValue(dictout, key, value);
    }
    return dictout;
}

static inline NSDictionary *_A55ObjectToDottedDictionary(__weak A55Object *object, __weak NSString *path) {
    NSMutableDictionary *dictout = [NSMutableDictionary dictionary];
    __weak NSDictionary *dictionary = [object dictionary];
    
    for(NSString *k in dictionary) {
        __weak id value = [dictionary valueForKey:k];
        __weak NSString *key = path ? [NSString stringWithFormat:@"%@.%@", path, k] : k;
        _A55ConvertValue(dictout, key, value);
    }
    
    return dictout;
}

NSDictionary *A55ObjectToDottedDictionary(A55Object *object) {
    return _A55ObjectToDottedDictionary(object, nil);
}

NSString *A55URLEncode(NSDictionary *dictionary) {
    NSMutableArray *parts = [NSMutableArray array];
    for(NSString *key in [[dictionary allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
        NSString *value = [NSString stringWithFormat:@"%@", [dictionary valueForKey:key]];
        NSString *encKey = (__bridge id)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)key, NULL, CFSTR("@/"), kCFStringEncodingUTF8);
        NSString *encValue = (__bridge id)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)value, NULL, CFSTR("@/"), kCFStringEncodingUTF8);
        NSString *part = [NSString stringWithFormat:@"%@=%@", encKey, encValue];
        [parts addObject:part];
    }
    NSString *r = [parts componentsJoinedByString:@"&"];
    return r;
}

@implementation A55Request
@dynamic endpoint, method, data, next, apiKey, callback;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(NSString, data, data)
    A55_PROPERTY(NSString, next, next)
    A55_PROPERTY(NSString, api_key, apiKey)
    A55_PROPERTY(NSString, callback, callback)
    A55_END
}

- (NSString *)endpoint {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"A55Response.endpoint not implemented"
                                 userInfo:nil];
}

- (NSString*)method {
    return @"GET";
}

+ (Class)responseClass {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"A55Request.responseClass not implemented"
                                 userInfo:nil];
}

- (void)send:(A55ResponseHandler)responseHandler error:(A55ErrorHandler)errorHandler {
    NSDictionary *dotted = A55ObjectToDottedDictionary(self);
    NSString *qs = A55URLEncode(dotted);
    
    NSMutableURLRequest *request;
    if([self.method isEqualToString:@"GET"]) {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", self.endpoint, qs]]];
    } else {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.endpoint]];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[qs dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [self.gateway setAuthorizationHeader:request];
    [request setHTTPMethod:self.method];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setTimeoutInterval:30.0];
    objc_setAssociatedObject(request, kA55ResponseHandler, responseHandler, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(request, kA55ErrorHandler, errorHandler, OBJC_ASSOCIATION_RETAIN);
    [[NSURLConnection connectionWithRequest:request delegate:self] start];
}


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSMutableData *responseData = [NSMutableData data];
    objc_setAssociatedObject(connection.originalRequest, kA55ResponseBuffer, responseData, OBJC_ASSOCIATION_RETAIN);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSMutableData *responseData = objc_getAssociatedObject(connection.originalRequest, kA55ResponseBuffer);
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSMutableData *responseData = objc_getAssociatedObject(connection.originalRequest, kA55ResponseBuffer);
    A55ResponseHandler responseHandler = objc_getAssociatedObject(connection.originalRequest, kA55ResponseHandler);
    A55ErrorHandler errorHandler = objc_getAssociatedObject(connection.originalRequest, kA55ErrorHandler);
    
    objc_removeAssociatedObjects(connection.originalRequest);
    
    NSString *responseText = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSDictionary *responseDictionary = [A55JsonParser parse:responseText];

    if([responseDictionary valueForKey:@"error"]) {
        A55Exception *exception = [A55Exception exceptionWithDictionary:responseDictionary];
        errorHandler(exception);
    } else {
        A55Response *response = nil;
        @try {
            response = [[[[self class] responseClass] alloc] initWithDictionary:responseDictionary gateway:self.gateway];
            
            if(![response isValidSignatureForGateway:self.gateway]) errorHandler([[A55InvalidSignatureException alloc] init]);
        } @catch (NSException *e) {
            errorHandler(nil);
        }
        responseHandler(response);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    A55ErrorHandler errorHandler = objc_getAssociatedObject(connection.originalRequest, kA55ErrorHandler);
    errorHandler(nil);
}


@end
