//
//  A55ScheduleGetRequest.h
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Request.h"
#import "A55Response.h"
#import "A55Card.h"
#import "A55User.h"
#import "A55Schedule.h"
#import "A55Transaction.h"

@interface A55ScheduleGetResponse : A55Response
@property (copy) A55Card *card;
@property (copy) A55Schedule *schedule;
@property (copy) A55Transaction *transaction;
@end

@interface A55ScheduleGetRequest : A55Request
@property (copy) A55User *user;
@property (copy) A55Schedule *schedule;


- (id)initWithUser:(A55User*)user
          schedule:(A55Schedule*)schedule
           gateway:(A55Gateway*)gateway;
@end
