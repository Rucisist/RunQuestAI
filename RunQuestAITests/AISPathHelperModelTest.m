//
//  AISPathHelperModelTest.m
//  RunQuestAITests
//
//  Created by Андрей Илалов on 23.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock.h>
#import "AISPathHelperModel.h"
#import "Run+CoreDataProperties.h"

@interface AISPathHelperModelTest : XCTestCase

@property (nonatomic, strong) AISPathHelperModel *pathHelperModel;

@end

@implementation AISPathHelperModelTest

- (void)setUp {
    [super setUp];
    self.pathHelperModel = [AISPathHelperModel new];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)testPathHelperModelInitialize
{
    XCTAssertNotNil(self.pathHelperModel, @"объект не проинициализировался");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testModelResultsNotNil
{
    id mockRunClass = OCMClassMock([Run class]);
    NSMutableArray *testedArray = [NSMutableArray new];
    testedArray = [self.pathHelperModel calculatePaceArrayWith:mockRunClass];
    XCTAssertNotNil(testedArray, @"функция возвращает nil");
//    NSInteger expectedFactorial3 = 6;
//    NSInteger expectedFactorial5 = 120;

//    OCMExpect([mockClassB factorial:5]).andReturn(expectedFactorial5);
//
//    NSInteger factorial3 = [mockClassB factorial:3];
//    NSInteger factorial5 = [mockClassB factorial:5];
//
//    XCTAssertEqual(factorial3, expectedFactorial3);
//    XCTAssertEqual(factorial5, expectedFactorial5);
    
}

-(void)testModelResultsReturnZeroElements
{
    NSInteger expectedNumberOfElements = 0;
    NSMutableArray *testedArray = [self.pathHelperModel calculatePaceArrayWith:nil];
    NSLog(@"%@", testedArray);
    XCTAssertEqual(testedArray.count, expectedNumberOfElements);
}

//-(void)testModelResultsReturnZeroElements
//{
//
//    NSMutableArray *testedArray = [NSMutableArray new];
//    testedArray = [self.pathHelperModel calculatePaceArrayWith:mockRunClass];
//}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
