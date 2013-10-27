//
//  A55Card.h
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Object.h"
#import "A55Address.h"

@interface A55Card : A55Object
@property (copy) NSString *token;
@property (copy) NSString *holderName;
@property (copy) NSString *number;
@property (copy) NSString *expiry;
@property (copy) NSString *expiryMonth;
@property (copy) NSString *expiryYear;
@property (copy) NSString *securityCode;
@property (copy) A55Address *address;
@property (copy) NSString *type;
@property (copy) NSString *description;
@property (copy) NSString *issue;

- (id)init;
- (id)initWithToken:(NSString*)token;
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
                 address:(A55Address*)address;
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
             description:(NSString*)description
                 address:(A55Address*)address;
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
                 address:(A55Address*)address;
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
             description:(NSString*)description
                 address:(A55Address*)address;
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
                 address:(A55Address*)address;
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
             description:(NSString*)description
                 address:(A55Address*)address;
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
                 address:(A55Address*)address;
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
             description:(NSString*)description
                 address:(A55Address*)address;

+ (id)card;
+ (id)cardWithToken:(NSString*)token;
+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
                 address:(A55Address*)address;
+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
             description:(NSString*)description
                 address:(A55Address*)address;
+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
                 address:(A55Address*)address;
+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
             description:(NSString*)description
                 address:(A55Address*)address;
+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
                 address:(A55Address*)address;
+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
             description:(NSString*)description
                 address:(A55Address*)address;
+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
                 address:(A55Address*)address;
+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
             description:(NSString*)description
                 address:(A55Address*)address;

@end
