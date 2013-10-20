//
//  A55User.h
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Object.h"
#import "A55Name.h"

@interface A55User : A55Object
@property (copy) NSNumber *identifier;
@property (copy) A55Name *name;
@property (copy) NSString *email;
@property (copy) NSString *password;
@property (copy) NSString *confirmPassword;
@property (copy) NSString *phone;
@end