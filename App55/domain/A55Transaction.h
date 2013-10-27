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

- (id)init;
- (id)initWithIdentifier:(NSString*)identifier;
- (id)initWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description;
- (id)initWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description;
- (id)initWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type;
- (id)initWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type;
- (id)initWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description commit:(NSNumber*)commit;
- (id)initWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description commit:(NSNumber*)commit;
- (id)initWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type commit:(NSNumber*)commit;
- (id)initWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type commit:(NSNumber*)commit;

+ (id)transaction;
+ (id)transactionWithIdentifier:(NSString*)identifier;
+ (id)transactionWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description;
+ (id)transactionWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description;
+ (id)transactionWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type;
+ (id)transactionWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type;
+ (id)transactionWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description commit:(NSNumber*)commit;
+ (id)transactionWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description commit:(NSNumber*)commit;
+ (id)transactionWithAmount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type commit:(NSNumber*)commit;
+ (id)transactionWithIdentifier:(NSString*)identifier amount:(NSString*)amount currency:(NSString*)currency description:(NSString*)description type:(NSString*)type commit:(NSNumber*)commit;
@end
