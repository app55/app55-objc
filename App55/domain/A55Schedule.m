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

- (id)initWithIdentifier:(NSNumber*)identifier {
    if(self = [self init]) {
        self.identifier = identifier;
    }
    return self;
}
- (id)initWithIdentifier:(NSNumber *)identifier end:(NSString*)end {
    if(self = [self init]) {
        self.identifier = identifier;
        self.end = end;
    }
    return self;
}
- (id)initWithTimeUnit:(NSString*)timeUnit start:(NSString*)start {
    if(self = [self init]) {
        self.timeUnit = timeUnit;
        self.start = start;
    }
    return self;
}
- (id)initWithTimeUnit:(NSString*)timeUnit start:(NSString*)start end:(NSString*)end {
    if(self = [self init]) {
        self.timeUnit = timeUnit;
        self.start = start;
        self.end = end;
    }
    return self;
}
- (id)initWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units start:(NSString*)start {
    if(self = [self init]) {
        self.timeUnit = timeUnit;
        self.units = units;
        self.start = start;
    }
    return self;
}
- (id)initWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units start:(NSString*)start end:(NSString*)end {
    if(self = [self init]) {
        self.timeUnit = timeUnit;
        self.units = units;
        self.start = start;
        self.end = end;
    }
    return self;
}
- (id)initWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units day:(NSNumber*)day start:(NSString*)start {
    if(self = [self init]) {
        self.timeUnit = timeUnit;
        self.units = units;
        self.day = day;
        self.start = start;
    }
    return self;
}
- (id)initWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units day:(NSNumber*)day start:(NSString*)start end:(NSString*)end {
    if(self = [self init]) {
        self.timeUnit = timeUnit;
        self.units = units;
        self.day = day;
        self.start = start;
        self.end = end;
    }
    return self;
}

+ (A55Schedule*)scheduleWithIdentifier:(NSNumber*)identifier {
    return [[A55Schedule alloc] initWithIdentifier:identifier];
}
+ (A55Schedule*)scheduleWithIdentifier:(NSNumber *)identifier end:(NSString*)end {
    return [[A55Schedule alloc] initWithIdentifier:identifier end:end];
}
+ (A55Schedule*)scheduleWithTimeUnit:(NSString*)timeUnit start:(NSString*)start {
    return [[A55Schedule alloc] initWithTimeUnit:timeUnit start:start];
}
+ (A55Schedule*)scheduleWithTimeUnit:(NSString*)timeUnit start:(NSString*)start end:(NSString*)end {
    return [[A55Schedule alloc] initWithTimeUnit:timeUnit start:start end:end];
}
+ (A55Schedule*)scheduleWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units start:(NSString*)start {
    return [[A55Schedule alloc] initWithTimeUnit:timeUnit units:units start:start];
}
+ (A55Schedule*)scheduleWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units start:(NSString*)start end:(NSString*)end {
    return [[A55Schedule alloc] initWithTimeUnit:timeUnit units:units start:start end:end];
}
+ (A55Schedule*)scheduleWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units day:(NSNumber*)day start:(NSString*)start {
    return [[A55Schedule alloc] initWithTimeUnit:timeUnit units:units day:day start:start];
}
+ (A55Schedule*)scheduleWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units day:(NSNumber*)day start:(NSString*)start end:(NSString*)end {
    return [[A55Schedule alloc] initWithTimeUnit:timeUnit units:units day:day start:start end:end];
}

@end
