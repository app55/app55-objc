//
//  A55Environment.m
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Environment.h"

@implementation A55Environment
@synthesize server, port, version;
@dynamic isSSL, baseUrl, scheme, host;

- (id)initWithServer:(NSString *)_server
                port:(NSUInteger)_port
                 ssl:(BOOL)_ssl
             version:(NSUInteger)_version {
    if(self = [self init]) {
        server = _server;
        port = _port;
        ssl = _ssl;
        version = _version;
    }
    return self;
}

- (BOOL)isSSL {
    return ssl;
}

- (NSString*)scheme {
    return ssl ? @"https" : @"http";
}

- (NSString*)host {
    if(port == 443 && ssl)
        return server;
    else if(port == 80 && !ssl)
        return server;
    else
        return [NSString stringWithFormat:@"%@:%lu", server, (unsigned long)port];
}

- (NSString*)baseUrl {
    return [NSString stringWithFormat:@"%@://%@/v%lu", self.scheme, self.host, (unsigned long)version];
}

+ (id)environment:(A55EnvironmentName)environment {
    static A55Environment *development, *sandbox, *production;
    switch(environment) {
        case A55Development:
            if(development == nil) {
                development = [[A55Environment alloc] initWithServer:@"dev.app55.com"
                                                                port:80
                                                                 ssl:NO
                                                             version:1];
            }
            return development;
        case A55Sandbox:
            if(sandbox == nil) {
                sandbox = [[A55Environment alloc] initWithServer:@"sandbox.app55.com"
                                                            port:443
                                                             ssl:YES
                                                         version:1];
            }
            return sandbox;
        case A55Production:
            if(production == nil) {
                production = [[A55Environment alloc] initWithServer:@"api.app55.com"
                                                               port:443
                                                                ssl:YES
                                                            version:1];
            }
            return production;
        default:
            @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The supplied environment was not recognized." userInfo:nil];
    }
}


+ (id)environmentWithServer:(NSString *)server
                       port:(NSUInteger)port
                        ssl:(BOOL)ssl
                    version:(NSUInteger)version {
    return [[A55Environment alloc] initWithServer:server port:port ssl:ssl version:version];
}

@end
