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

- (id)init {
    if(self = [super init]) {
        
    }
    return self;
}
- (id)initWithToken:(NSString*)token {
    if(self = [self init]) {
        self.token = token;
    }
    return self;
}
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
                 address:(A55Address*)address {
    if(self = [self init]) {
        self.holderName = holderName;
        self.number = number;
        self.expiry = expiry;
        self.securityCode = securityCode;
        self.issue = issue;
        self.address = address;
    }
    return self;
}
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
             description:(NSString*)description
                 address:(A55Address*)address {
    if(self = [self init]) {
        self.holderName = holderName;
        self.number = number;
        self.expiry = expiry;
        self.securityCode = securityCode;
        self.issue = issue;
        self.description = description;
        self.address = address;
    }
    return self;
}
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
                 address:(A55Address*)address {
    if(self = [self init]) {
        self.holderName = holderName;
        self.number = number;
        self.expiryMonth = expiryMonth;
        self.expiryYear = expiryYear;
        self.securityCode = securityCode;
        self.issue = issue;
        self.address = address;
    }
    return self;
}
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
             description:(NSString*)description
                 address:(A55Address*)address {
    if(self = [self init]) {
        self.holderName = holderName;
        self.number = number;
        self.expiryMonth = expiryMonth;
        self.expiryYear = expiryYear;
        self.securityCode = securityCode;
        self.issue = issue;
        self.description = description;
        self.address = address;
    }
    return self;
}
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
                 address:(A55Address*)address {
    if(self = [self init]) {
        self.holderName = holderName;
        self.number = number;
        self.expiry = expiry;
        self.securityCode = securityCode;
        self.address = address;
    }
    return self;
}
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
             description:(NSString*)description
                 address:(A55Address*)address {
    if(self = [self init]) {
        self.holderName = holderName;
        self.number = number;
        self.expiry = expiry;
        self.securityCode = securityCode;
        self.description = description;
        self.address = address;
    }
    return self;
}
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
                 address:(A55Address*)address {
    if(self = [self init]) {
        self.holderName = holderName;
        self.number = number;
        self.expiryMonth = expiryMonth;
        self.expiryYear = expiryYear;
        self.securityCode = securityCode;
        self.address = address;
    }
    return self;
}
- (id)initWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
             description:(NSString*)description
                 address:(A55Address*)address {
    if(self = [self init]) {
        self.holderName = holderName;
        self.number = number;
        self.expiryMonth = expiryMonth;
        self.expiryYear = expiryYear;
        self.securityCode = securityCode;
        self.description = description;
        self.address = address;
    }
    return self;
}

+ (id)card {
    return [[A55Card alloc] init];
}

+ (id)cardWithToken:(NSString*)token {
    return [[A55Card alloc] initWithToken:token];
}

+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
                 address:(A55Address*)address {
    return [[A55Card alloc] initWithHolderName:holderName
                                        number:number
                                        expiry:expiry
                                  securityCode:securityCode
                                         issue:issue
                                       address:address];
}
+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
             description:(NSString*)description
                 address:(A55Address*)address {
    return [[A55Card alloc] initWithHolderName:holderName
                                        number:number
                                        expiry:expiry
                                  securityCode:securityCode
                                         issue:issue
                                   description:description
                                       address:address];
}
+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
                 address:(A55Address*)address {
    return [[A55Card alloc] initWithHolderName:holderName
                                        number:number
                                   expiryMonth:expiryMonth
                                    expiryYear:expiryYear
                                  securityCode:securityCode
                                         issue:issue
                                       address:address];
}

+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
                   issue:(NSString*)issue
             description:(NSString*)description
                 address:(A55Address*)address {
    return [[A55Card alloc] initWithHolderName:holderName
                                        number:number
                                   expiryMonth:expiryMonth
                                    expiryYear:expiryYear
                                  securityCode:securityCode
                                         issue:issue
                                   description:description
                                       address:address];
}

+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
                 address:(A55Address*)address {
    return [[A55Card alloc] initWithHolderName:holderName
                                        number:number
                                        expiry:expiry
                                  securityCode:securityCode
                                       address:address];
}
+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
                  expiry:(NSString*)expiry
            securityCode:(NSString*)securityCode
             description:(NSString*)description
                 address:(A55Address*)address {
    return [[A55Card alloc] initWithHolderName:holderName
                                        number:number
                                        expiry:expiry
                                  securityCode:securityCode
                                   description:description
                                       address:address];
}
+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
                 address:(A55Address*)address {
    return [[A55Card alloc] initWithHolderName:holderName
                                        number:number
                                   expiryMonth:expiryMonth
                                    expiryYear:expiryYear
                                  securityCode:securityCode
                                       address:address];
}

+ (id)cardWithHolderName:(NSString*)holderName
                  number:(NSString*)number
             expiryMonth:(NSString*)expiryMonth
              expiryYear:(NSString*)expiryYear
            securityCode:(NSString*)securityCode
             description:(NSString*)description
                 address:(A55Address*)address {
    return [[A55Card alloc] initWithHolderName:holderName
                                        number:number
                                   expiryMonth:expiryMonth
                                    expiryYear:expiryYear
                                  securityCode:securityCode
                                   description:description
                                       address:address];
}
@end
