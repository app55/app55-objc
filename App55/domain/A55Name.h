//
//  A55Name.h
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import "A55Object.h"

@interface A55Name : A55Object
@property (copy) NSString *first;
@property (copy) NSString *last;

- (id)init;
- (id)initWithString:(NSString*)string;
- (id)initWithFirstName:(NSString*)firstName lastName:(NSString*)lastName;

+ (id)name;
+ (id)nameWithString:(NSString*)string;
+ (id)nameWithFirstName:(NSString*)firstName lastName:(NSString*)lastName;
@end

