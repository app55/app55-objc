//
//  A55Environment.h
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    A55Development,
    A55Sandbox,
    A55Production
} A55EnvironmentName;

@interface A55Environment : NSObject {
    NSString *server;
    NSUInteger port;
    BOOL ssl;
    NSUInteger version;
}
@property (readonly) NSString *server;
@property (readonly) NSUInteger port;
@property (readonly) BOOL isSSL;
@property (readonly) NSUInteger version;
@property (readonly) NSString *baseUrl;
@property (readonly) NSString *scheme;
@property (readonly) NSString *host;

- initWithServer:(NSString*)server port:(NSUInteger)port ssl:(BOOL)ssl version:(NSUInteger)version;

+ environment:(A55EnvironmentName)environment;
+ environmentWithServer:(NSString*)server port:(NSUInteger)port ssl:(BOOL)ssl version:(NSUInteger)version;


@end
