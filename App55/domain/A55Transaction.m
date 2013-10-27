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

- (id)init {
    if(self = [super init]) {
        
    }
    return self;
}
- (id)initWithIdentifier:(NSString*)identifier {
    if(self = [self init]) {
        self.identifier = identifier;
    }
    return self;
}
- (id)initWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description {
    if(self = [self init]) {
        self.amount = amount;
        self.currency = currency;
        self.description = description;
    }
    return self;
}
- (id)initWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description {
    if(self = [self init]) {
        self.identifier = identifier;
        self.amount = amount;
        self.currency = currency;
        self.description = description;
    }
    return self;
}
- (id)initWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type {
    if(self = [self init]) {
        self.amount = amount;
        self.currency = currency;
        self.description = description;
        self.type = type;
    }
    return self;
}
- (id)initWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type {
    if(self = [self init]) {
        self.identifier = identifier;
        self.amount = amount;
        self.currency = currency;
        self.description = description;
        self.type = type;
    }
    return self;
}
- (id)initWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description commit:(NSNumber*)commit {
    if(self = [self init]) {
        self.amount = amount;
        self.currency = currency;
        self.description = description;
        self.commit = commit;
    }
    return self;
}
- (id)initWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description commit:(NSNumber*)commit {
    if(self = [self init]) {
        self.identifier = identifier;
        self.amount = amount;
        self.currency = currency;
        self.description = description;
        self.commit = commit;
    }
    return self;
}
- (id)initWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type commit:(NSNumber*)commit {
    if(self = [self init]) {
        self.amount = amount;
        self.currency = currency;
        self.description = description;
        self.type = type;
        self.commit = commit;
    }
    return self;
}
- (id)initWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type commit:(NSNumber*)commit {
    if(self = [self init]) {
        self.identifier = identifier;
        self.amount = amount;
        self.currency = currency;
        self.description = description;
        self.type = type;
        self.commit = commit;
    }
    return self;
}

+ (id)transaction {
    return [[A55Transaction alloc] init];
}
+ (id)transactionWithIdentifier:(NSString*)identifier {
    return [[A55Transaction alloc] initWithIdentifier:identifier];
}
+ (id)transactionWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description {
    return [[A55Transaction alloc] initWithAmount:amount currency:currency description:description];
}
+ (id)transactionWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description {
    return [[A55Transaction alloc] initWithIdentifier:identifier amount:amount currency:currency description:description];
}
+ (id)transactionWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type {
    return [[A55Transaction alloc] initWithAmount:amount currency:currency description:description type:type];
}
+ (id)transactionWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type {
    return [[A55Transaction alloc] initWithIdentifier:identifier amount:amount currency:currency description:description type:type];
}
+ (id)transactionWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description commit:(NSNumber *)commit {
    return [[A55Transaction alloc] initWithAmount:amount currency:currency description:description commit:commit];
}
+ (id)transactionWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description commit:(NSNumber *)commit {
    return [[A55Transaction alloc] initWithIdentifier:identifier amount:amount currency:currency description:description commit:commit];
}
+ (id)transactionWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type commit:(NSNumber *)commit {
    return [[A55Transaction alloc] initWithAmount:amount currency:currency description:description type:type commit:commit];
}
+ (id)transactionWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type commit:(NSNumber *)commit {
    return [[A55Transaction alloc] initWithIdentifier:identifier amount:amount currency:currency description:description type:type commit:commit];
}


@end
