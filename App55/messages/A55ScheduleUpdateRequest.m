//
//  A55ScheduleUpdateRequest.m
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55ScheduleUpdateRequest.h"
#import "A55Gateway.h"

@implementation A55ScheduleUpdateResponse
+ (void)initialize {
    A55_INTERFACE
    A55_END
}
@end

@implementation A55ScheduleUpdateRequest
@dynamic card, user, schedule;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55Card, card, card)
    A55_PROPERTY(A55User, user, user)
    A55_PROPERTY(A55Schedule, schedule, schedule)
    A55_END
}


- (id)initWithCard:(A55Card*)card
              user:(A55User*)user
          schedule:(A55Schedule *)schedule
           gateway:(A55Gateway*)gateway {
    if(self = [self initWithGateway:gateway]) {
        self.card = card;
        self.user = user;
        self.schedule = schedule;
    }
    return self;
}

- (NSString *)method {
    return @"POST";
}

- (NSString *)endpoint {
    return [NSString stringWithFormat:@"%@/schedule/%@", self.gateway.environment.baseUrl, self.schedule.identifier];
}

+ (Class)responseClass {
    return [A55ScheduleUpdateResponse class];
}
@end
