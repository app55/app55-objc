//
//  A55User.m
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55User.h"

@implementation A55User
@dynamic identifier, name, email, password, confirmPassword, phone;

+ (void)initialize {
    A55_INTERFACE
    A55_PROPERTY(NSNumber, id, identifier)
    A55_PROPERTY(A55Name, name, name)
    A55_PROPERTY(NSString, email, email)
    A55_PROPERTY(NSString, password, password)
    A55_PROPERTY(NSString, password_confirm, confirmPassword)
    A55_PROPERTY(NSString, phone, phone)
    A55_END
}

@end
