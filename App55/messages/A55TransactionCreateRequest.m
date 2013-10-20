//
//  A55TransactionCreateRequest.m
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55TransactionCreateRequest.h"
#import "A55Gateway.h"

@implementation A55TransactionCreateResponse
@dynamic user, transaction;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55User, user, user)
    A55_PROPERTY(A55Transaction, transaction, transaction)
    A55_END
}
@end

@implementation A55TransactionCreateRequest
@dynamic card, user, transaction;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55Card, card, card)
    A55_PROPERTY(A55User, user, user)
    A55_PROPERTY(A55Transaction, transaction, transaction)
    A55_PROPERTY(NSString, ip_address, ipAddress)
    A55_END
}


- (id)initWithCard:(A55Card*)card
              user:(A55User*)user
       transaction:(A55Transaction*)transaction
         ipAddress:(NSString*)ipAddress
           gateway:(A55Gateway*)gateway {
    if(self = [self initWithGateway:gateway]) {
        self.card = card;
        self.user = user;
        self.transaction = transaction;
        self.ipAddress = ipAddress;
    }
    return self;
}

- (id)initWithTransaction:(A55Transaction*)transaction
                ipAddress:(NSString*)ipAddress
                  gateway:(A55Gateway*)gateway {
    if(self = [self initWithCard:nil user:nil transaction:transaction ipAddress:ipAddress gateway:gateway]) {
        
    }
    return self;
}

- (id)initWithCard:(A55Card*)card
              user:(A55User*)user
       transaction:(A55Transaction*)transaction
           gateway:(A55Gateway*)gateway {
    if(self = [self initWithCard:card user:user transaction:transaction gateway:gateway]) {
        
    }
    return self;
}

- (id)initWithTransaction:(A55Transaction *)transaction
                  gateway:(A55Gateway *)gateway {
    if(self = [self initWithCard:nil user:nil transaction:transaction gateway:gateway]) {
        
    }
    return self;
}

- (NSString *)method {
    return @"POST";
}

- (NSString *)endpoint {
    return [NSString stringWithFormat:@"%@/transaction", self.gateway.environment.baseUrl];
}

- (Class)responseClass {
    return [A55TransactionCreateResponse class];
}
@end
