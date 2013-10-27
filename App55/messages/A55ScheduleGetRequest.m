//
//  A55ScheduleGetRequest.m
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55ScheduleGetRequest.h"
#import "A55Gateway.h"

@implementation A55ScheduleGetResponse
@dynamic card, schedule;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55Card, card, card)
    A55_PROPERTY(A55Schedule, schedule, schedule)
    A55_PROPERTY(A55Transaction, transaction, transaction)
    A55_END
}
@end

@implementation A55ScheduleGetRequest
@dynamic user;
@synthesize schedule = _schedule;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55User, user, user)
    A55_END
}


- (id)initWithUser:(A55User*)user
          schedule:(A55Schedule *)schedule
           gateway:(A55Gateway*)gateway {
    if(self = [self initWithGateway:gateway]) {
        self.user = user;
        self.schedule = schedule;
    }
    return self;
}

- (NSString *)endpoint {
    return [NSString stringWithFormat:@"%@/schedule/%@", self.gateway.environment.baseUrl, self.schedule.identifier];
}

+ (Class)responseClass {
    return [A55ScheduleGetResponse class];
}
@end
