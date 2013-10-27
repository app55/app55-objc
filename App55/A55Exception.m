//
//  A55Exception.m
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Exception.h"

@implementation A55Exception
@synthesize message, code, body;
@dynamic type;

- (id)initWithMessage:(NSString *)_message code:(NSNumber *)_code body:(NSDictionary *)_body {
    if(self = [self init]) {
        message = _message;
        code = _code;
        body = _body;
    }
    return self;
}

- (NSString *)type {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"A55Exception.type not implemented"
                                 userInfo:nil];
}

+ (id)exceptionWithDictionary:(NSDictionary *)dictionary {
    NSDictionary *error = [dictionary valueForKey:@"error"];
    NSString *type = [error valueForKey:@"type"];
    NSString *message = [error valueForKey:@"message"];
    NSNumber *code = [error valueForKey:@"code"];
    NSDictionary *body = [error valueForKey:@"body"];
    
    if([type isEqualToString:@"request-error"])
        return [[A55RequestException alloc] initWithMessage:message code:code body:body];
    else if([type isEqualToString:@"authentication-error"])
        return [[A55AuthenticationException alloc] initWithMessage:message code:code body:body];
    else if([type isEqualToString:@"server-error"])
        return [[A55ServerException alloc] initWithMessage:message code:code body:body];
    else if([type isEqualToString:@"validation-error"])
        return [[A55ValidationException alloc] initWithMessage:message code:code body:body];
    else if([type isEqualToString:@"resource-error"])
        return [[A55ResourceException alloc] initWithMessage:message code:code body:body];
    else if([type isEqualToString:@"card-error"])
        return [[A55CardException alloc] initWithMessage:message code:code body:body];
    else
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:[NSString stringWithFormat:
                                               @"Invalid exception type %@",
                                               type]
                                     userInfo:nil];
}
@end

@implementation A55InvalidSignatureException
- (NSString *)type {
    return @"signature-error";
}

- (NSString *)description {
    return @"InvalidSignatureError";
}
@end

@implementation A55RequestException
- (NSString *)type {
    return @"request-error";
}

- (NSString *)description {
    return [NSString stringWithFormat:@"RequestError (0x%x): %@", [self.code intValue], self.message];
}
@end

@implementation A55AuthenticationException
- (NSString*)type {
    return @"authentication-error";
}

- (NSString *)description {
    return [NSString stringWithFormat:@"AuthenticationError (0x%x): %@", [self.code intValue], self.message];
}
@end

@implementation A55ServerException
- (NSString*)type {
    return @"server-error";
}

- (NSString *)description {
    return [NSString stringWithFormat:@"ServerError (0x%x): %@", [self.code intValue], self.message];
}
@end

@implementation A55ValidationException
- (NSString*)type {
    return @"validation-error";
}

- (NSString *)description {
    return [NSString stringWithFormat:@"ValidationError (0x%x): %@", [self.code intValue], self.message];
}
@end

@implementation A55ResourceException
- (NSString *)type {
    return @"resource-error";
}

- (NSString *)description {
    return [NSString stringWithFormat:@"ResourceError (0x%x): %@", [self.code intValue], self.message];
}
@end

@implementation A55CardException
- (NSString *)type {
    return @"card-error";
}

- (NSString *)description {
    return [NSString stringWithFormat:@"CardError (0x%x): %@", [self.code intValue], self.message];
}
@end