//
//  DemoTests.m
//  DemoTests
//
//  Created by Hirohisa Kawasaki on 2013/11/16.
//  Copyright (c) 2013年 Hirohisa Kawasaki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Calculate.h"


@interface DemoTests : XCTestCase

@end

@implementation DemoTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample
{
    NSString *str = @"1234567890";
    XCTAssertTrue([str lengthIncludeEmoji] == 10,
                  @"[1234567890 lengthIncludeEmoji]:%d", [str lengthIncludeEmoji]);
    str = @"𠮷野家コヒ\u309Aへ\u309A";
    XCTAssertTrue([str lengthIncludeEmoji] == 6,
                  @"[𠮷野家コヒ\u309Aへ\u309A lengthIncludeEmoji]:%d", [str lengthIncludeEmoji]);
}

@end
