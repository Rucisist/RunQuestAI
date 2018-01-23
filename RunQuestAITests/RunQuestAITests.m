//
//  RunQuestAITests.m
//  RunQuestAITests
//
//  Created by Андрей Илалов on 12.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AISUserDefaultsService.h"

@interface RunQuestAITests : XCTestCase


@end

@implementation RunQuestAITests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitializing
{
    XCTAssertNotNil([AISUserDefaultsService new], @"не создается объект");
}


@end
