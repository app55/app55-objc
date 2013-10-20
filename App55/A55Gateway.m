//
//  A55Gateway.m
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Gateway.h"

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

- (id)initWithEnvironment:(A55Environment *)_environment
                   apiKey:(NSString *)_apiKey {
    
    if(self = [self initWithEnvironment:_environment
                                 apiKey:_apiKey
                              apiSecret:nil]) {
        
    }
    return self;
    
}

- (BOOL)hasApiSecret {
    return apiSecret != nil;
}

- (A55CardCreateRequest *)createCard:(A55Card *)card user:(A55User *)user {
    return [[A55CardCreateRequest alloc] initWithCard:card user:user gateway:self];
}
- (A55CardDeleteRequest *)deleteCard:(A55Card *)card user:(A55User *)user {
    return [[A55CardDeleteRequest alloc] initWithCard:card user:user gateway:self];
}
- (A55CardListRequest *)listCards:(A55User *)user {
    return [[A55CardListRequest alloc] initWithUser:user gateway:self];
}

- (A55UserAuthenticateRequest *)authenticateUser:(A55User *)user {
    return [[A55UserAuthenticateRequest alloc] initWithUser:user gateway:self];
}
- (A55UserCreateRequest *)createUser:(A55User *)user {
    return [[A55UserCreateRequest alloc] initWithUser:user gateway:self];
}
- (A55UserGetRequest *)getUser:(A55User *)user {
    return [[A55UserGetRequest alloc] initWithUser:user gateway:self];
}
- (A55UserUpdateRequest *)updateUser:(A55User *)user {
    return [[A55UserUpdateRequest alloc] initWithUser:user gateway:self];
}

- (A55TransactionCreateRequest *)createTransactionWithCard:(A55Card *)card
                                                      user:(A55User *)user
                                               transaction:(A55Transaction *)transaction
                                                 ipAddress:(NSString *)ipAddress {
    return [[A55TransactionCreateRequest alloc] initWithCard:card
                                                        user:user
                                                 transaction:transaction
                                                   ipAddress:ipAddress
                                                     gateway:self];
}
- (A55TransactionCreateRequest *)createTransactionWithCard:(A55Card *)card
                                                      user:(A55User *)user
                                               transaction:(A55Transaction *)transaction {
    return [[A55TransactionCreateRequest alloc] initWithCard:card
                                                        user:user
                                                 transaction:transaction
                                                     gateway:self];
}

- (A55TransactionCreateRequest *)createTransaction:(A55Transaction *)transaction
                                         ipAddress:(NSString *)ipAddress {
    return [[A55TransactionCreateRequest alloc] initWithTransaction:transaction
                                                          ipAddress:ipAddress
                                                            gateway:self];
}

- (A55TransactionCreateRequest *)createTransaction:(A55Transaction *)transaction {
    return [[A55TransactionCreateRequest alloc] initWithTransaction:transaction
                                                            gateway:self];
}

- (A55TransactionCommitRequest *)commitTransaction:(A55Transaction *)transaction {
    return [[A55TransactionCommitRequest alloc] initWithTransaction:transaction gateway:self];
}

@end
