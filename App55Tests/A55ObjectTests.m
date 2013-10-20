//
//  A55ObjectTests.m
//  App55
//
//  Created by Tim Behrsin on 19/10/2013.
//  Copyright (c) 2013 App55 Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "A55User.h"

@interface A55ObjectTests : XCTestCase

@end

@implementation A55ObjectTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    A55User *user = [[A55User alloc]
                     initWithDictionary:@{
                                          @"id": [NSNumber numberWithUnsignedLong:1],
                                          @"name": @{ @"first": @"APP55", @"last": @"User" },
                                          @"email": @"example@app55.com",
                                          @"password": @"pa55word",
                                          @"password_confirm": @"pa55word",
                                          @"phone": @"0123456789",
                                          @"other_property": @"value"
                                          }];
    XCTAssertEqual([NSNumber numberWithUnsignedLong:1] , user.identifier,
                   @"Expected 1 but got %@", [NSNumber numberWithUnsignedLong:1]);
    XCTAssertEqualObjects(@"APP55", user.name.first, @"Expected APP55 but got %@", user.name.first);
    XCTAssertEqualObjects(@"User", user.name.last, @"Expected User but got %@", user.name.last);
    XCTAssertEqualObjects(@"pa55word", user.password, @"Expected pa55word but got %@", user.password);
    XCTAssertEqualObjects(@"pa55word", user.confirmPassword, @"Expected pa55word but got %@", user.confirmPassword);
    XCTAssertEqualObjects(@"0123456789", user.phone, @"Expected 0123456789 but got %@", user.phone);
    XCTAssertEqualObjects(@"value", [user valueForKey:@"other_property"],
                          @"Expected value but got %@", [user valueForKey:@"other_property"]);
}

@end
