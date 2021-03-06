//
//  A55CardDeleteRequest.m
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55CardDeleteRequest.h"
#import "A55Gateway.h"

@implementation A55CardDeleteResponse
+ (void)initialize {
    A55_INTERFACE
    A55_END
}
@end

@implementation A55CardDeleteRequest
@dynamic user, card;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55User, user, user)
    A55_PROPERTY(A55Card, card, card)
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
    return @"DELETE";
}

- (NSString *)endpoint {
    return [NSString stringWithFormat:@"%@/card/%@", self.gateway.environment.baseUrl, self.card.token];
}

+ (Class)responseClass {
    return [A55CardDeleteResponse class];
}
@end
