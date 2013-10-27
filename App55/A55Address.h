//
//  A55Address.h
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Object.h"

@interface A55Address : A55Object
@property (copy) NSString *street;
@property (copy) NSString *street2;
@property (copy) NSString *city;
@property (copy) NSString *postalCode;
@property (copy) NSString *country;

- (id)init;
- (id)initWithStreet:(NSString*)street
                city:(NSString*)city
          postalCode:(NSString*)postalCode
             country:(NSString*)country;
- (id)initWithStreet:(NSString*)street
             street2:(NSString*)street2
                city:(NSString*)city
          postalCode:(NSString*)postalCode
             country:(NSString*)country;

+ (id)address;
+ (id)addressWithStreet:(NSString*)street
                   city:(NSString*)city
             postalCode:(NSString*)postalCode
                country:(NSString*)country;
+ (id)addressWithStreet:(NSString*)street
                street2:(NSString*)street2
                   city:(NSString*)city
             postalCode:(NSString*)postalCode
                country:(NSString*)country;
@end
