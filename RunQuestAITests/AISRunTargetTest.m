//
//  AISRunTargetTest.m
//  RunQuestAITests
//
//  Created by Андрей Илалов on 19.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AISRunTarget.h"

@interface AISRunTargetTest : XCTestCase

@property (nonatomic, strong) AISRunTarget *runTarget;

@end

@implementation AISRunTargetTest

- (void)setUp {
    [super setUp];
    self.runTarget = [AISRunTarget new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testRunTargetInitalisation {
    XCTAssertNotNil(self.runTarget, @"объект не проинициализировался");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
