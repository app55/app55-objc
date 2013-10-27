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
@dynamic signature, timestamp, validity;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(NSString, sig, signature)
    A55_PROPERTY(NSString, ts, timestamp)
    A55_PROPERTY(NSNumber, v, validity)
    A55_END
}

- (id)initWithGateway:(A55Gateway *)_gateway {
    if(self = [self init]) {
        gateway = _gateway;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)_dictionary gateway:(A55Gateway *)_gateway {
    if(self = [super initWithDictionary:_dictionary]) {
        gateway = _gateway;
    }
    return self;
}
@end
