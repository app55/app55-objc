//
//  A55Request.h
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//


#import "A55Message.h"
#import "A55Response.h"

typedef void (^A55ResponseHandler)(id);
typedef void (^A55ErrorHandler)(id);

@interface A55Request : A55Message
@property (readonly) NSString *endpoint;
@property (readonly) NSString *method;

- (void)send:(A55ResponseHandler)responseHandler error:(A55ErrorHandler)errorHandler;

+ (Class)responseClass;
@end