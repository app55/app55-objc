//
//  A55ScheduleListRequest.m
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55ScheduleListRequest.h"
#import "A55Gateway.h"

@implementation A55ScheduleListResponse
@dynamic schedules;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY_ARRAY(A55Schedule, schedules, schedules)
    A55_END
}
@end

@implementation A55ScheduleListRequest
@dynamic user, active;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55User, user, user)
    A55_PROPERTY(A55Number, active, active)
    A55_END
}


- (id)initWithUser:(A55User*)user
            active:(NSNumber*)active
           gateway:(A55Gateway*)gateway {
    if(self = [self initWithGateway:gateway]) {
        self.user = user;
        self.active = active;
    }
    return self;
}

- (id)initWithUser:(A55User*)user
           gateway:(A55Gateway*)gateway {
    if(self = [self initWithGateway:gateway]) {
        self.user = user;
    }
    return self;
}

- (NSString *)endpoint {
    return [NSString stringWithFormat:@"%@/schedule", self.gateway.environment.baseUrl];
}

+ (Class)responseClass {
    return [A55ScheduleListResponse class];
}
@end