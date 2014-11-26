//
//  A55Object.m
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import <objc/runtime.h>
#import "A55Object.h"

@interface A55PropertyRegistration : NSObject
@property (copy) Class cls;
@property (copy) NSString *name;
@property (copy) NSString *key;
@property (assign) BOOL array;
- initWithClassName:(NSString*)className key:(NSString*)key name:(NSString*)name array:(BOOL)array;
@end

@implementation A55PropertyRegistration
@synthesize cls, name, key, array;
- (id)initWithClassName:(NSString *)_className key:(NSString *)_key name:(NSString *)_name array:(BOOL)_array {
    if(self = [self init]) {
        cls = NSClassFromString(_className);
        name = _name;
        key = _key;
        array = _array;
    }
    return self;
}
@end

static const char *kA55InterfaceKeys = "app55.interfaceKeys";
static const char *kA55InterfaceProperties = "app55.interfaceProperties";

void A55BeginInterface(Class cls) {
    NSMutableDictionary *keys = [NSMutableDictionary dictionary];
    NSDictionary *superKeys = objc_getAssociatedObject(class_getSuperclass(cls), kA55InterfaceKeys);
    if(superKeys) [keys addEntriesFromDictionary:superKeys];
    objc_setAssociatedObject(cls, kA55InterfaceKeys, keys, OBJC_ASSOCIATION_RETAIN);
    
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    NSDictionary *superProperties = objc_getAssociatedObject(class_getSuperclass(cls), kA55InterfaceProperties);
    if(superProperties) [properties addEntriesFromDictionary:superProperties];
    objc_setAssociatedObject(cls, kA55InterfaceProperties, properties, OBJC_ASSOCIATION_RETAIN);
}

void A55RegisterProperty(Class cls, const char *type, const char *key, const char *name, BOOL array) {
    NSMutableDictionary *keys = objc_getAssociatedObject(cls, kA55InterfaceKeys);
    NSMutableDictionary *properties = objc_getAssociatedObject(cls, kA55InterfaceProperties);
    
    A55PropertyRegistration *registration = [[A55PropertyRegistration alloc]
                                             initWithClassName:[NSString stringWithUTF8String:type]
                                             key:[NSString stringWithUTF8String:key]
                                             name:[NSString stringWithUTF8String:name]
                                             array:array];
    
    [keys setValue:registration forKey:[NSString stringWithUTF8String:key]];
    [properties setValue:registration forKey:[NSString stringWithUTF8String:name]];
}

void A55EndInterface(Class cls) {
    
}

static id A55GetProperty(A55Object *self, SEL sel) {
    NSMutableDictionary *properties = objc_getAssociatedObject([self class], kA55InterfaceProperties);
    A55PropertyRegistration *registration = [properties valueForKey:NSStringFromSelector(sel)];
    return [self valueForKey:registration.key];
}

static void A55SetProperty(A55Object *self, SEL sel, id value) {
    NSMutableDictionary *properties = objc_getAssociatedObject([self class], kA55InterfaceProperties);
    NSMutableString *property = [NSStringFromSelector(sel) mutableCopy];
    [property deleteCharactersInRange:NSMakeRange(0, 3)];
    [property deleteCharactersInRange:NSMakeRange(property.length - 1, 1)];
    [property replaceCharactersInRange:NSMakeRange(0, 1) withString:[[property substringToIndex:1] lowercaseString]];
    A55PropertyRegistration *registration = [properties valueForKey:property];
    [self setValue:[value copy] forKey:registration.key];
}

@implementation A55Object
- (id)init {
    if(self = [super init]) {
        dictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)_dictionary {
    if(self = [self init]) {
        Class class = [self class];
        NSMutableDictionary *keys = objc_getAssociatedObject(class, kA55InterfaceKeys);
        for(NSString *key in _dictionary) {
            id value = [_dictionary valueForKey:key];
            A55PropertyRegistration *registration = [keys valueForKey:key];
            if(registration == nil) {
                [self setValue:value forKey:key];
                continue;
            }
            
            if([value isKindOfClass:NSDictionary.class]) {
                value = [[registration.cls alloc] initWithDictionary:value];
            } else if([value isKindOfClass:NSArray.class]) {
                NSMutableArray *array = [NSMutableArray array];
                for(id o in value) {
                    [array addObject:[[registration.cls alloc] initWithDictionary:o]];
                }
                value = [NSArray arrayWithArray:array];
            }
            
            [self setValue:value forKey:key];
        }
    }
    return self;
}

- (NSDictionary *)dictionary {
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (id)valueForKey:(NSString *)key {
    return [dictionary objectForKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [dictionary setValue:value forKey:key];
}

- (id)copyWithZone:(NSZone *)zone {
    A55Object *object = [[[self class] allocWithZone:zone] initWithDictionary:dictionary];
    return object;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    __weak NSMutableDictionary *properties = objc_getAssociatedObject([self class], kA55InterfaceProperties);
    NSMutableString *property = [NSStringFromSelector(sel) mutableCopy];
    if([NSStringFromSelector(sel) hasPrefix:@"set"]) {
        [property deleteCharactersInRange:NSMakeRange(0, 3)];
        [property deleteCharactersInRange:NSMakeRange(property.length - 1, 1)];
        [property replaceCharactersInRange:NSMakeRange(0, 1) withString:[[property substringToIndex:1] lowercaseString]];
        __weak A55PropertyRegistration *registration = [properties valueForKey:property];
        if(registration == nil) return [super resolveInstanceMethod:sel];
        class_addMethod([self class], sel, (IMP)A55SetProperty, "v@:@");
        return YES;
    } else {
        __weak A55PropertyRegistration *registration = [properties valueForKey:property];
        if(registration == nil) return [super resolveInstanceMethod:sel];
        class_addMethod([self class], sel, (IMP)A55GetProperty, "@@:");
        return YES;
    }
}

@end




