//
//  A55Message.m
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Message.h"

@implementation A55Message
@synthesize gateway;

- (id)initWithGateway:(A55Gateway *)_gateway {
    if(self = [self init]) {
        gateway = _gateway;
    }
    return self;
}
@end
