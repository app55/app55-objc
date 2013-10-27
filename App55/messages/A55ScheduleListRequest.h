//
//  A55ScheduleListRequest.h
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Request.h"
#import "A55Response.h"
#import "A55User.h"
#import "A55Schedule.h"

@interface A55ScheduleListResponse : A55Response
@property (copy) NSArray *schedules;
@end

@interface A55ScheduleListRequest : A55Request
@property (copy) A55User *user;
@property (copy) NSNumber *active;

- (id)initWithUser:(A55User*)user
            active:(NSNumber*)active
           gateway:(A55Gateway*)gateway;

- (id)initWithUser:(A55User *)user
           gateway:(A55Gateway *)gateway;

@end