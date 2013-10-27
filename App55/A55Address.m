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

- (id)init {
    if(self = [super init]) {
        
    }
    return self;
}
- (id)initWithStreet:(NSString*)street
                city:(NSString*)city
          postalCode:(NSString*)postalCode
             country:(NSString*)country {
    if(self = [self init]) {
        self.street = street;
        self.city = city;
        self.postalCode = postalCode;
        self.country = country;
    }
    return self;
}
- (id)initWithStreet:(NSString*)street
             street2:(NSString*)street2
                city:(NSString*)city
          postalCode:(NSString*)postalCode
             country:(NSString*)country {
    if(self = [self init]) {
        self.street = street;
        self.street2 = street2;
        self.city = city;
        self.postalCode = postalCode;
        self.country = country;
    }
    return self;
}

+ (id)address {
    return [[A55Address alloc] init];
}
+ (id)addressWithStreet:(NSString*)street
                   city:(NSString*)city
             postalCode:(NSString*)postalCode
                country:(NSString*)country {
    return [[A55Address alloc] initWithStreet:street city:city postalCode:postalCode country:country];
}
+ (id)addressWithStreet:(NSString*)street
                street2:(NSString*)street2
                   city:(NSString*)city
             postalCode:(NSString*)postalCode
                country:(NSString*)country {
    return [[A55Address alloc] initWithStreet:street city:city postalCode:postalCode country:country];
}
@end
