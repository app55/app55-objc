//
//  A55Response.m
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//


#import "A55Response.h"
#import "A55Gateway.h"
#import "A55Exception.h"


@implementation A55Response

+ (void)initialize {
    A55_INTERFACE
    A55_END
}

- (id)initWithDictionary:(NSDictionary *)_dictionary gateway:(A55Gateway *)gateway {
    if(self = [super initWithDictionary:_dictionary gateway:gateway]) {
    }
    return self;
}

- (BOOL)isValidSignatureForGateway:(A55Gateway*)gateway {
    if(gateway.hasApiSecret) {
        NSString *signature = [gateway sign:self];
        if(![signature isEqualToString:self.signature]) {
            return NO;
        }
    }
    
    return YES;
}

@end
