//
//  A55TransactionCreateRequest.h
//  App55
//
//  Created by Tim Behrsin on 20/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Request.h"
#import "A55Response.h"
#import "A55User.h"
#import "A55Transaction.h"
#import "A55Card.h"

@interface A55TransactionCreateResponse : A55Response
@property (copy) A55User *user;
@property (copy) A55Transaction *transaction;
@end

@interface A55TransactionCreateRequest : A55Request
@property (copy) A55Card *card;
@property (copy) A55User *user;
@property (copy) A55Transaction *transaction;
@property (copy) NSString *ipAddress;

- (id)initWithCard:(A55Card*)card
              user:(A55User*)user
       transaction:(A55Transaction*)transaction
         ipAddress:(NSString*)ipAddress
           gateway:(A55Gateway*)gateway;

- (id)initWithCard:(A55Card*)card
       transaction:(A55Transaction*)transaction
         ipAddress:(NSString*)ipAddress
           gateway:(A55Gateway*)gateway;

- (id)initWithCard:(A55Card*)card
              user:(A55User*)user
       transaction:(A55Transaction*)transaction
           gateway:(A55Gateway*)gateway;

- (id)initWithCard:(A55Card*)card
       transaction:(A55Transaction*)transaction
           gateway:(A55Gateway*)gateway;

@end
