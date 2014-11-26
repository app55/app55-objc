//
//  A55CardCreateRequest.m
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55CardCreateRequest.h"
#import "A55Gateway.h"

@implementation A55CardCreateResponse
@dynamic card, user;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55Card, card, card)
    A55_PROPERTY(A55User, user, user)
    A55_END
}
@end

@implementation A55CardCreateRequest
@dynamic card, user;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55Card, card, card)
    A55_PROPERTY(A55User, user, user)
    A55_PROPERTY(NSString, ip_address, ipAddress)
    A55_END
}

- (id)initWithCard:(A55Card *)card user:(A55User *)user gateway:(A55Gateway *)gateway {
    if(self = [self initWithGateway:gateway]) {
        self.card = card;
        self.user = user;
    }
    return self;
}

- (NSString *)method {
    return @"POST";
}

- (NSString *)endpoint {
    return [NSString stringWithFormat:@"%@/card", self.gateway.environment.baseUrl];
}

+ (Class)responseClass {
    return [A55CardCreateResponse class];
}
@end



