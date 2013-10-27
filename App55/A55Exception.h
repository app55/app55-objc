//
//  A55Exception.h
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface A55Exception : NSObject
@property (readonly) NSString *type;
@property (readonly) NSString *message;
@property (readonly) NSNumber *code;
@property (readonly) NSDictionary *body;

- (id)initWithMessage:(NSString*)message code:(NSNumber*)code body:(NSDictionary*)body;
+ (id)exceptionWithDictionary:(NSDictionary*)dictionary;
@end

@interface A55InvalidSignatureException : A55Exception
@end

@interface A55RequestException : A55Exception
@end

@interface A55AuthenticationException : A55Exception
@end

@interface A55ServerException : A55Exception
@end

@interface A55ValidationException : A55Exception
@end

@interface A55ResourceException : A55Exception
@end

@interface A55CardException : A55Exception
@end
