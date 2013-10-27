//
//  A55ScheduleCreateRequest.m
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55ScheduleCreateRequest.h"
#import "A55Gateway.h"

@implementation A55ScheduleCreateResponse
@dynamic card, transaction, schedule;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55Card, card, card)
    A55_PROPERTY(A55Transaction, transaction, transaction)
    A55_PROPERTY(A55Schedule, schedule, schedule)
    A55_END
}
@end

@implementation A55ScheduleCreateRequest
@dynamic card, user, transaction, schedule;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(A55Card, card, card)
    A55_PROPERTY(A55User, user, user)
    A55_PROPERTY(A55Transaction, transaction, transaction)
    A55_PROPERTY(A55Schedule, schedule, schedule)
    A55_END
}


- (id)initWithCard:(A55Card*)card
              user:(A55User*)user
       transaction:(A55Transaction*)transaction
          schedule:(A55Schedule *)schedule
           gateway:(A55Gateway*)gateway {
    if(self = [self initWithGateway:gateway]) {
        self.card = card;
        self.user = user;
        self.transaction = transaction;
        self.schedule = schedule;
    }
    return self;
}

- (NSString *)method {
    return @"POST";
}

- (NSString *)endpoint {
    return [NSString stringWithFormat:@"%@/schedule", self.gateway.environment.baseUrl];
}

+ (Class)responseClass {
    return [A55ScheduleCreateResponse class];
}
@end
