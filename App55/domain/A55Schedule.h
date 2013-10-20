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
@end
