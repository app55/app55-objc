//
//  A55Request.h
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//


#import "A55Message.h"
#import "A55Response.h"
#import "A55Exception.h"

typedef void (^A55ResponseHandler)(id response);
typedef void (^A55ErrorHandler)(A55Exception *error);

@interface A55Request : A55Message <NSURLConnectionDataDelegate>
@property (copy) NSString *data;
@property (copy) NSString *next;
@property (copy) NSString *apiKey;
@property (copy) NSString *callback;
@property (readonly) NSString *endpoint;
@property (readonly) NSString *method;

- (void)send:(A55ResponseHandler)responseHandler error:(A55ErrorHandler)errorHandler;

+ (Class)responseClass;

@end