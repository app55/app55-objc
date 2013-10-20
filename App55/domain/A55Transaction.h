//
//  A55Transaction.h
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Object.h"

@interface A55Transaction : A55Object
@property (copy) NSString *identifier;
@property (copy) NSString *amount;
@property (copy) NSString *currency;
@property (copy) NSString *description;
@property (copy) NSString *code;
@property (copy) NSString *authCode;
@property (copy) NSNumber *commit;
@property (copy) NSString *source;
@property (copy) NSString *type;
@end
