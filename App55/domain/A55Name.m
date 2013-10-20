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
@end
