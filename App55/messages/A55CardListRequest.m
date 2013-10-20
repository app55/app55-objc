//
//  A55CardListRequest.m
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55CardListRequest.h"
#import "A55Gateway.h"

@implementation A55CardListResponse
@dynamic cards;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55Card, cards, cards)
    A55_END
}
@end

@implementation A55CardListRequest
@dynamic user;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55User, user, user)
    A55_END
}

- (id)initWithUser:(A55User *)user gateway:(A55Gateway *)gateway {
    if(self = [self initWithGateway:gateway]) {
        self.user = user;
    }
    return self;
}

- (NSString *)endpoint {
    return [NSString stringWithFormat:@"%@/card", self.gateway.environment.baseUrl];
}

- (Class)responseClass {
    return [A55CardListResponse class];
}
@end