//
//  A55Schedule.m
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Schedule.h"

@implementation A55Schedule
@dynamic identifier, timeUnit, units, day, start, end, next;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(NSNumber, id, identifier)
    A55_PROPERTY(NSString, time_unit, timeUnit)
    A55_PROPERTY(NSNumber, units, units)
    A55_PROPERTY(NSNumber, day, day)
    A55_PROPERTY(NSString, start, start)
    A55_PROPERTY(NSString, end, end)
    A55_PROPERTY(NSString, next, next)
    A55_END
}
@end
