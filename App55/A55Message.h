//
//  A55Message.h
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Object.h"

@class A55Gateway;

@interface A55Message : A55Object
@property (readonly) A55Gateway *gateway;
@property (readonly) NSString *formData;

- (id)initWithGateway:(A55Gateway*)gateway;
@end