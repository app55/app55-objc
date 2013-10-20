//
//  A55Card.m
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Card.h"

@implementation A55Card
@dynamic token, holderName, number, expiry, expiryMonth, expiryYear, securityCode, address, type, description, issue;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(NSString, token, token)
    A55_PROPERTY(NSString, holder_name, holderName)
    A55_PROPERTY(NSString, number, number)
    A55_PROPERTY(NSString, expiry, expiry)
    A55_PROPERTY(NSString, expiry_month, expiryMonth)
    A55_PROPERTY(NSString, expiry_year, expiryYear)
    A55_PROPERTY(NSString, security_code, securityCode)
    A55_PROPERTY(A55Address, address, address)
    A55_PROPERTY(NSString, type, type)
    A55_PROPERTY(NSString, description, description)
    A55_PROPERTY(NSString, issue, issue)
    A55_END
}
@end
