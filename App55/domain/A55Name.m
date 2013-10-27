//
//  A55Name.m
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Name.h"

@implementation A55Name
@dynamic first, last;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(NSString, first, first)
    A55_PROPERTY(NSString, last, last)
    A55_END
}

- (id)init {
    if(self = [super init]) {
        
    }
    return self;
}
- (id)initWithString:(NSString*)string {
    if(self = [self init]) {
        NSArray *components = [string componentsSeparatedByString:@" "];
        self.first = [components objectAtIndex:0];
        self.last = [[components subarrayWithRange:NSMakeRange(1, components.count - 1)] componentsJoinedByString:@" "];
    }
    return self;
}
- (id)initWithFirstName:(NSString*)firstName lastName:(NSString*)lastName {
    if(self = [self init]) {
        self.first = firstName;
        self.last = lastName;
    }
    return self;
}

+ (id)name {
    return [[A55Name alloc] init];
}

+ (id)nameWithString:(NSString*)string {
    return [[A55Name alloc] initWithString:string];
}

+ (id)nameWithFirstName:(NSString*)firstName lastName:(NSString*)lastName {
    return [[A55Name alloc] initWithFirstName:firstName lastName:lastName];
}
@end
