//
//  A55Response.h
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Message.h"

@interface A55Response : A55Message
- (BOOL)isValidSignatureForGateway:(A55Gateway*)gateway;
@end
