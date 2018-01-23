//
//  AISTargetAllocatorHelperTest.m
//  RunQuestAITests
//
//  Created by Андрей Илалов on 23.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreLocation/CoreLocation.h>
#import "AISTargetAllocatorHelper.h"

static const double AISNorthWestLattitude = 55.772886;
static const double AISNorthWestLongitude = 37.577896;

static const double AISSouthEastLattitude = 55.733665;
static const double AISSouthEastLongitude = 37.660980;

@interface AISTargetAllocatorHelperTest : XCTestCase

@property (nonatomic, strong) AISTargetAllocatorHelper *allocatorHelper;

@end

@implementation AISTargetAllocatorHelperTest

- (void)setUp {
    [super setUp];
    self.allocatorHelper = [AISTargetAllocatorHelper new];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)testInitializing
{
    XCTAssertNotNil([AISTargetAllocatorHelper new], @"не создается объект");
}

- (void)testRandomLocationMoscowCenter
{
    CLLocation *resultedLocation = [CLLocation new];
    resultedLocation = [self.allocatorHelper randomLocationInMoscowCenter];
    
    XCTAssertGreaterThanOrEqual(resultedLocation.coordinate.longitude, AISNorthWestLongitude);
    XCTAssertLessThanOrEqual(resultedLocation.coordinate.latitude, AISNorthWestLattitude);
    XCTAssertLessThanOrEqual(resultedLocation.coordinate.longitude, AISSouthEastLongitude);
    XCTAssertGreaterThanOrEqual(resultedLocation.coordinate.latitude, AISSouthEastLattitude);
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

@end
