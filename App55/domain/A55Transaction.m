//
//  A55Transaction.m
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Transaction.h"

@implementation A55Transaction
@dynamic identifier, amount, currency, description, code, authCode, commit, source, type;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(NSString, id, identifier)
    A55_PROPERTY(NSString, amount, amount)
    A55_PROPERTY(NSString, currency, currency)
    A55_PROPERTY(NSString, description, description)
    A55_PROPERTY(NSString, code, code)
    A55_PROPERTY(NSString, auth_code, authCode)
    A55_PROPERTY(NSNumber, commit, commit)
    A55_PROPERTY(NSString, source, source)
    A55_PROPERTY(NSString, type, type)
    A55_END
}
@end
