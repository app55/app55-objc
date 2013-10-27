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

- (id)init {
    if(self = [super init]) {
        
    }
    return self;
}
- (id)initWithIdentifier:(NSNumber*)identifier {
    if(self = [self init]) {
        self.identifier = identifier;
    }
    return self;
}
- (id)initWithEmail:(NSString*)email {
    if(self = [self init]) {
        self.email = email;
    }
    return self;
}
- (id)initWithEmail:(NSString*)email password:(NSString*)password {
    if(self = [self init]) {
        self.email = email;
        self.password = password;
    }
    return self;
}
- (id)initWithEmail:(NSString*)email phone:(NSString*)phone password:(NSString*)password confirmPassword:(NSString*)confirmPassword {
    if(self = [self init]) {
        self.email = email;
        self.phone = phone;
        self.password = password;
        self.confirmPassword = confirmPassword;
    }
    return self;
}
- (id)initWithEmail:(NSString*)email password:(NSString*)password confirmPassword:(NSString*)confirmPassword {
    if(self = [self init]) {
        self.email = email;
        self.password = password;
        self.confirmPassword = confirmPassword;
    }
    return self;
}

- (id)initWithIdentifier:(NSNumber*)identifier email:(NSString*)email {
    if(self = [self init]) {
        self.identifier = identifier;
        self.email = email;
    }
    return self;
}

- (id)initWithIdentifier:(NSNumber*)identifier password:(NSString*)password confirmPassword:(NSString*)confirmPassword {
    if(self = [self init]) {
        self.identifier = identifier;
        self.password = password;
        self.confirmPassword = confirmPassword;
    }
    return self;
}

- (id)initWithIdentifier:(NSNumber*)identifier email:(NSString*)email password:(NSString*)password confirmPassword:(NSString*)confirmPassword {
    if(self = [self init]) {
        self.identifier = identifier;
        self.email = email;
        self.password = password;
        self.confirmPassword = confirmPassword;
    }
    return self;
}


+ (id)user {
    return [[A55User alloc] init];
}
+ (id)userWithIdentifier:(NSNumber*)identifier {
    return [[A55User alloc] initWithIdentifier:identifier];
}
+ (id)userWithEmail:(NSString*)email {
    return [[A55User alloc] initWithEmail:email];
}
+ (id)userWithEmail:(NSString*)email password:(NSString*)password {
    return [[A55User alloc] initWithEmail:email password:password];
}
+ (id)userWithEmail:(NSString*)email phone:(NSString*)phone password:(NSString*)password confirmPassword:(NSString*)confirmPassword {
    return [[A55User alloc] initWithEmail:email phone:phone password:password confirmPassword:confirmPassword];
}
+ (id)userWithEmail:(NSString*)email password:(NSString*)password confirmPassword:(NSString*)confirmPassword {
    return [[A55User alloc] initWithEmail:email password:password confirmPassword:confirmPassword];
}
+ (id)userWithIdentifier:(NSNumber*)identifier email:(NSString*)email {
    return [[A55User alloc] initWithIdentifier:identifier email:email];
}
+ (id)userWithIdentifier:(NSNumber*)identifier password:(NSString*)password confirmPassword:(NSString*)confirmPassword {
    return [[A55User alloc] initWithIdentifier:identifier password:password confirmPassword:confirmPassword];
}
+ (id)userWithIdentifier:(NSNumber*)identifier email:(NSString*)email password:(NSString*)password confirmPassword:(NSString*)confirmPassword {
    return [[A55User alloc] initWithIdentifier:identifier email:email password:password confirmPassword:confirmPassword];
}


@end
