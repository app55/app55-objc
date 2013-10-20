//
//  A55Address.m
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Address.h"

@implementation A55Address
@dynamic street, street2, city, postalCode, country;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(NSString, street, street)
    A55_PROPERTY(NSString, street2, street2)
    A55_PROPERTY(NSString, city, city)
    A55_PROPERTY(NSString, postal_code, postalCode)
    A55_PROPERTY(NSString, country, country)
    A55_END
}
@end
