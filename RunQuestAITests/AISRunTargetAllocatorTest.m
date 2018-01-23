//
//  AISRunTargetAllocatorTest.m
//  RunQuestAITests
//
//  Created by Андрей Илалов on 23.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AISTargetAllocator.h"

@interface AISRunTargetAllocatorTest : XCTestCase

@property (nonatomic, strong) AISTargetAllocator *targetAllocator;

@end

@implementation AISRunTargetAllocatorTest

- (void)setUp {
    [super setUp];
    self.targetAllocator = [AISTargetAllocator new];
}

- (void)testInitializing
{
    XCTAssertNotNil([AISTargetAllocator new], @"не создается объект");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
