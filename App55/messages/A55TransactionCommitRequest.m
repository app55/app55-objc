//
//  A55TransactionCommitRequest.m
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55TransactionCommitRequest.h"
#import "A55Gateway.h"

@implementation A55TransactionCommitResponse
@dynamic transaction;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55Transaction, transaction, transaction)
    A55_END
}
@end

@implementation A55TransactionCommitRequest
@synthesize transaction = _transaction;

+ (void)initialize {
    A55_INTERFACE
    A55_END
}

- (id)initWithTransaction:(A55Transaction*)transaction
                  gateway:(A55Gateway*)gateway {
    if(self = [self initWithGateway:gateway]) {
        self.transaction = transaction;
    }
    return self;
}

- (NSString *)method {
    return @"POST";
}

- (NSString *)endpoint {
    return [NSString stringWithFormat:@"%@/transaction/%@",
            self.gateway.environment.baseUrl, self.transaction.identifier];
}

- (Class)responseClass {
    return [A55TransactionCommitResponse class];
}
@end

