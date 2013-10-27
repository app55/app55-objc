//
//  A55Gateway.m
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "A55Gateway.h"
#import "A55Base64.h"

// Implemented in A55Request.m
NSDictionary *A55ObjectToDottedDictionary(A55Object *object);
NSString *A55URLEncode(NSDictionary *dictionary);

@implementation A55Gateway
@synthesize apiKey, environment, data, storeAuthenticationTokens;
@dynamic hasApiSecret;


- (id)initWithEnvironment:(A55Environment *)_environment
                   apiKey:(NSString *)_apiKey
                apiSecret:(NSString *)_apiSecret {
    
    if(self = [self init]) {
        environment = _environment;
        apiKey = _apiKey;
        apiSecret = _apiSecret;
        data = nil;
        storeAuthenticationTokens = YES;
    }
    return self;
    
}

+ (id)gatewayWithEnvironment:(A55Environment *)environment apiKey:(NSString *)apiKey apiSecret:(NSString *)apiSecret {
    return [[A55Gateway alloc] initWithEnvironment:environment apiKey:apiKey apiSecret:apiSecret];
}

- (id)initWithEnvironment:(A55Environment *)_environment
                   apiKey:(NSString *)_apiKey {
    
    if(self = [self initWithEnvironment:_environment
                                 apiKey:_apiKey
                              apiSecret:nil]) {
        
    }
    return self;
    
}

+ (id)gatewayWithEnvironment:(A55Environment *)environment apiKey:(NSString *)apiKey {
    return [[A55Gateway alloc] initWithEnvironment:environment apiKey:apiKey];
}

- (BOOL)hasApiSecret {
    return apiSecret != nil;
}

- (NSString *)sign:(A55Object *)object {
    NSMutableDictionary *dotted = [A55ObjectToDottedDictionary(object) mutableCopy];
    [dotted removeObjectForKey:@"sig"];
    NSString *encoded = A55URLEncode(dotted);
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *_data = [[apiSecret stringByAppendingString:encoded] dataUsingEncoding:NSUTF8StringEncoding];
    CC_SHA1(_data.bytes, (unsigned int)_data.length, digest);
    return [[[A55Base64 encode:[NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH]]
            stringByReplacingOccurrencesOfString:@"/" withString:@"_"]
            stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
}

- (void)setAuthorizationHeader:(NSMutableURLRequest *)request {
    if(self.hasApiSecret) {
        NSString *credentials = [NSString stringWithFormat:@"%@:%@", apiKey, apiSecret];
        credentials = [A55Base64 encode:[credentials dataUsingEncoding:NSUTF8StringEncoding]];
        [request addValue:[@"Basic " stringByAppendingString:credentials] forHTTPHeaderField:@"Authorization"];
    }
}

- (A55CardCreateRequest *)createCard:(A55Card *)card user:(A55User *)user {
    A55CardCreateRequest *request = [[A55CardCreateRequest alloc] initWithCard:card user:user gateway:self];
    //request.data = data;
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}
- (A55CardDeleteRequest *)deleteCard:(A55Card *)card user:(A55User *)user {
    A55CardDeleteRequest *request = [[A55CardDeleteRequest alloc] initWithCard:card user:user gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}
- (A55CardListRequest *)listCards:(A55User *)user {
    A55CardListRequest *request = [[A55CardListRequest alloc] initWithUser:user gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}

- (A55UserAuthenticateRequest *)authenticateUser:(A55User *)user {
    A55UserAuthenticateRequest *request = [[A55UserAuthenticateRequest alloc] initWithUser:user gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}
- (A55UserCreateRequest *)createUser:(A55User *)user {
    A55UserCreateRequest *request = [[A55UserCreateRequest alloc] initWithUser:user gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}
- (A55UserGetRequest *)getUser:(A55User *)user {
    A55UserGetRequest *request = [[A55UserGetRequest alloc] initWithUser:user gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}
- (A55UserUpdateRequest *)updateUser:(A55User *)user {
    A55UserUpdateRequest *request = [[A55UserUpdateRequest alloc] initWithUser:user gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}

- (A55TransactionCreateRequest *)createTransactionWithCard:(A55Card *)card
                                                      user:(A55User *)user
                                               transaction:(A55Transaction *)transaction
                                                 ipAddress:(NSString *)ipAddress {
    A55TransactionCreateRequest *request = [[A55TransactionCreateRequest alloc] initWithCard:card
                                                        user:user
                                                 transaction:transaction
                                                   ipAddress:ipAddress
                                                     gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}
- (A55TransactionCreateRequest *)createTransactionWithCard:(A55Card *)card
                                                      user:(A55User *)user
                                               transaction:(A55Transaction *)transaction {
    A55TransactionCreateRequest *request = [[A55TransactionCreateRequest alloc] initWithCard:card
                                                        user:user
                                                 transaction:transaction
                                                     gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}

- (A55TransactionCreateRequest *)createTransactionWithCard:(A55Card*)card
                                               transaction:(A55Transaction *)transaction
                                                 ipAddress:(NSString *)ipAddress {
    A55TransactionCreateRequest *request = [[A55TransactionCreateRequest alloc] initWithCard:(A55Card*)card
                                                                                 transaction:transaction
                                                                                   ipAddress:ipAddress
                                                                                     gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}

- (A55TransactionCreateRequest *)createTransactionWithCard:(A55Card*)card
                                               transaction:(A55Transaction *)transaction {
    A55TransactionCreateRequest *request = [[A55TransactionCreateRequest alloc] initWithCard:(A55Card*)card
                                                                                 transaction:transaction
                                                                                     gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}

- (A55TransactionCommitRequest *)commitTransaction:(A55Transaction *)transaction {
    A55TransactionCommitRequest *request = [[A55TransactionCommitRequest alloc] initWithTransaction:transaction
                                                                                            gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}

- (A55ScheduleCreateRequest*)createScheduleWithCard:(A55Card*)card
                                               user:(A55User*)user
                                        transaction:(A55Transaction*)transaction
                                           schedule:(A55Schedule*)schedule {
    A55ScheduleCreateRequest *request = [[A55ScheduleCreateRequest alloc] initWithCard:card
                                                                                  user:user
                                                                           transaction:transaction
                                                                              schedule:schedule
                                                                               gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}

- (A55ScheduleDeleteRequest*)deleteScheduleWithUser:(A55User*)user
                                           schedule:(A55Schedule*)schedule {
    A55ScheduleDeleteRequest *request = [[A55ScheduleDeleteRequest alloc] initWithUser:user
                                                                              schedule:schedule
                                                                               gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}

- (A55ScheduleGetRequest*)getScheduleWithUser:(A55User*)user
                                     schedule:(A55Schedule*)schedule {
    A55ScheduleGetRequest *request = [[A55ScheduleGetRequest alloc] initWithUser:user
                                                                        schedule:schedule
                                                                         gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}

- (A55ScheduleListRequest*)listSchedules:(A55User*)user {
    A55ScheduleListRequest *request = [[A55ScheduleListRequest alloc] initWithUser:user
                                                                           gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}

- (A55ScheduleListRequest*)listSchedules:(A55User*)user active:(NSNumber*)active {
    A55ScheduleListRequest *request = [[A55ScheduleListRequest alloc] initWithUser:user
                                                                            active:active
                                                                           gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}

- (A55ScheduleUpdateRequest*)updateScheduleWithCard:(A55Card*)card
                                               user:(A55User*)user
                                           schedule:(A55Schedule*)schedule {
    A55ScheduleUpdateRequest *request = [[A55ScheduleUpdateRequest alloc] initWithCard:card
                                                                                  user:user
                                                                              schedule:schedule
                                                                               gateway:self];
    if(!self.hasApiSecret) request.apiKey = apiKey;
    return request;
}

@end
