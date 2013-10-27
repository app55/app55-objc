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

- (id)init;
- (id)initWithIdentifier:(NSNumber*)identifier;
- (id)initWithEmail:(NSString*)email;
- (id)initWithEmail:(NSString*)email password:(NSString*)password;
- (id)initWithEmail:(NSString*)email phone:(NSString*)phone password:(NSString*)password confirmPassword:(NSString*)confirmPassword;
- (id)initWithEmail:(NSString*)email password:(NSString*)password confirmPassword:(NSString*)confirmPassword;
- (id)initWithIdentifier:(NSNumber*)identifier email:(NSString*)email;
- (id)initWithIdentifier:(NSNumber*)identifier password:(NSString*)password confirmPassword:(NSString*)confirmPassword;
- (id)initWithIdentifier:(NSNumber*)identifier email:(NSString*)email password:(NSString*)password confirmPassword:(NSString*)confirmPassword;

+ (id)user;
+ (id)userWithIdentifier:(NSNumber*)identifier;
+ (id)userWithEmail:(NSString*)email;
+ (id)userWithEmail:(NSString*)email password:(NSString*)password;
+ (id)userWithEmail:(NSString*)email phone:(NSString*)phone password:(NSString*)password confirmPassword:(NSString*)confirmPassword;
+ (id)userWithEmail:(NSString*)email password:(NSString*)password confirmPassword:(NSString*)confirmPassword;
+ (id)userWithIdentifier:(NSNumber*)identifier email:(NSString*)email;
+ (id)userWithIdentifier:(NSNumber*)identifier password:(NSString*)password confirmPassword:(NSString*)confirmPassword;
+ (id)userWithIdentifier:(NSNumber*)identifier email:(NSString*)email password:(NSString*)password confirmPassword:(NSString*)confirmPassword;
@end