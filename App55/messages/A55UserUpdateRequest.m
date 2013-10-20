//
//  A55UserUpdateRequest.m
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55UserUpdateRequest.h"
#import "A55Gateway.h"

@implementation A55UserUpdateResponse
+ (void)initialize {
    A55_INTERFACE
    A55_END
}
@end

@implementation A55UserUpdateRequest
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

- (NSString *)method {
    return @"POST";
}

- (NSString *)endpoint {
    return [NSString stringWithFormat:@"%@/user/%@", self.gateway.environment.baseUrl, self.user.identifier];
}

- (Class)responseClass {
    return [A55UserUpdateResponse class];
}
@end
