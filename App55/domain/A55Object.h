//
//  A55Object.h
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface A55Object : NSObject {
    NSMutableDictionary *dictionary;
}

- (id)initWithDictionary:(NSDictionary*)dictionary;
- (NSDictionary*)dictionary;

@end


void A55BeginInterface(Class cls);
void A55RegisterProperty(Class cls, const char *type, const char *key, const char *name, BOOL array);
void A55EndInterface(Class cls);

#define A55_INTERFACE A55BeginInterface(self);
#define A55_PROPERTY(type, key, name) A55RegisterProperty(self, #type, #key, #name, NO);
#define A55_PROPERTY_ARRAY(type, key, name) A55RegisterProperty(self, #type, #key, #name, YES);
#define A55_END A55EndInterface(self);