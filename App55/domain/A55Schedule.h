//
//  A55Schedule.h
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Object.h"

@interface A55Schedule : A55Object
@property (copy) NSNumber *identifier;
@property (copy) NSString *timeUnit;
@property (copy) NSNumber *units;
@property (copy) NSNumber *day;
@property (copy) NSString *start;
@property (copy) NSString *end;
@property (copy) NSString *next;

- (id)initWithIdentifier:(NSNumber*)identifier;
- (id)initWithIdentifier:(NSNumber *)identifier end:(NSString*)end;
- (id)initWithTimeUnit:(NSString*)timeUnit start:(NSString*)start;
- (id)initWithTimeUnit:(NSString*)timeUnit start:(NSString*)start end:(NSString*)end;
- (id)initWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units start:(NSString*)start;
- (id)initWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units start:(NSString*)start end:(NSString*)end;
- (id)initWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units day:(NSNumber*)day start:(NSString*)start;
- (id)initWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units day:(NSNumber*)day start:(NSString*)start end:(NSString*)end;

+ (A55Schedule*)scheduleWithIdentifier:(NSNumber*)identifier;
+ (A55Schedule*)scheduleWithIdentifier:(NSNumber *)identifier end:(NSString*)end;
+ (A55Schedule*)scheduleWithTimeUnit:(NSString*)timeUnit start:(NSString*)start;
+ (A55Schedule*)scheduleWithTimeUnit:(NSString*)timeUnit start:(NSString*)start end:(NSString*)end;
+ (A55Schedule*)scheduleWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units start:(NSString*)start;
+ (A55Schedule*)scheduleWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units start:(NSString*)start end:(NSString*)end;
+ (A55Schedule*)scheduleWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units day:(NSNumber*)day start:(NSString*)start;
+ (A55Schedule*)scheduleWithTimeUnit:(NSString*)timeUnit units:(NSNumber*)units day:(NSNumber*)day start:(NSString*)start end:(NSString*)end;
@end
