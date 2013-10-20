//
//  A55CardListRequest.h
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Request.h"
#import "A55Response.h"
#import "A55User.h"


@interface A55CardListResponse : A55Response
@property (copy) NSArray *cards;
@end

@interface A55CardListRequest : A55Request
@property (copy) A55User *user;

- (id)initWithUser:(A55User*)user gateway:(A55Gateway*)gateway;
@end
