//
//  AISTranslationUnitModelTest.m
//  RunQuestAITests
//
//  Created by Андрей Илалов on 23.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AISTranslationUnitsModel.h"

@interface AISTranslationUnitModelTest : XCTestCase

@end

@implementation AISTranslationUnitModelTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStringifyDistance
{
    double testedValue1 = 3;
    double testedValue2 = 9;
    double testedValue3 = 93;
    double testedValue4 = 158;
    double testedValue5 = 1054;

    NSString *expectedValue1 = [NSString stringWithFormat:@"0.00 km"];
    NSString *expectedValue2 = [NSString stringWithFormat:@"0.01 km"];
    NSString *expectedValue3 = [NSString stringWithFormat:@"0.09 km"];
    NSString *expectedValue4 = [NSString stringWithFormat:@"0.16 km"];
    NSString *expectedValue5 = [NSString stringWithFormat:@"1.05 km"];
    
    NSString *value1 = [AISTranslationUnitsModel stringifyDistance:testedValue1];
    NSString *value2 = [AISTranslationUnitsModel stringifyDistance:testedValue2];
    NSString *value3 = [AISTranslationUnitsModel stringifyDistance:testedValue3];
    NSString *value4 = [AISTranslationUnitsModel stringifyDistance:testedValue4];
    NSString *value5 = [AISTranslationUnitsModel stringifyDistance:testedValue5];
    
    XCTAssertEqualObjects(expectedValue1, value1);
    XCTAssertEqualObjects(expectedValue2, value2);
    XCTAssertEqualObjects(expectedValue3, value3);
    XCTAssertEqualObjects(expectedValue4, value4);
    XCTAssertEqualObjects(expectedValue5, value5);
}

- (void)testStringifyTimeShortFormat
{
    int testedValue1 = 3;
    int testedValue2 = 23;
    int testedValue3 = 93;
    int testedValue4 = 3601;
    
    NSString *expectedValue1 = [NSString stringWithFormat:@"00:03"];
    NSString *expectedValue2 = [NSString stringWithFormat:@"00:23"];
    NSString *expectedValue3 = [NSString stringWithFormat:@"01:33"];
    NSString *expectedValue4 = [NSString stringWithFormat:@"01:00:01"];
    
    NSString *value1 = [AISTranslationUnitsModel stringifySecondCount:testedValue1 usingLongFormat:NO];
    NSString *value2 = [AISTranslationUnitsModel stringifySecondCount:testedValue2 usingLongFormat:NO];
    NSString *value3 = [AISTranslationUnitsModel stringifySecondCount:testedValue3 usingLongFormat:NO];
    NSString *value4 = [AISTranslationUnitsModel stringifySecondCount:testedValue4 usingLongFormat:NO];
    
    XCTAssertEqualObjects(expectedValue1, value1);
    XCTAssertEqualObjects(expectedValue2, value2);
    XCTAssertEqualObjects(expectedValue3, value3);
    XCTAssertEqualObjects(expectedValue4, value4);
}

- (void)testStringifyPace
{
    int testedtime1 = 360; //6 мин
    int testedValue2 = 1023; //15 мин 3 сек
    int testedValue3 = 432; //7 мин 12 сек
    
    
    NSString *expectedValue1 = [NSString stringWithFormat:@"6.00 min/km"];
    NSString *expectedValue2 = [NSString stringWithFormat:@"17.03 min/km"];
    NSString *expectedValue3 = [NSString stringWithFormat:@"7.12 min/km"];
    
    NSString *value1 = [AISTranslationUnitsModel stringifyAvgPaceFromDist:1000 overTime:testedtime1];
    NSString *value2 = [AISTranslationUnitsModel stringifyAvgPaceFromDist:1000 overTime:testedValue2];
    NSString *value3 = [AISTranslationUnitsModel stringifyAvgPaceFromDist:1000 overTime:testedValue3];
    
    XCTAssertEqualObjects(expectedValue1, value1);
    XCTAssertEqualObjects(expectedValue2, value2);
    XCTAssertEqualObjects(expectedValue3, value3);
}

- (void)testStringifyTimeLongFormat
{
    int testedValue1 = 3;
    int testedValue2 = 23;
    int testedValue3 = 93;
    int testedValue4 = 3601;
    
    NSString *expectedValue1 = [NSString stringWithFormat:@"3sec"];
    NSString *expectedValue2 = [NSString stringWithFormat:@"23sec"];
    NSString *expectedValue3 = [NSString stringWithFormat:@"1min 33sec"];
    NSString *expectedValue4 = [NSString stringWithFormat:@"1hr 0min 1sec"];
    
    NSString *value1 = [AISTranslationUnitsModel stringifySecondCount:testedValue1 usingLongFormat:YES];
    NSString *value2 = [AISTranslationUnitsModel stringifySecondCount:testedValue2 usingLongFormat:YES];
    NSString *value3 = [AISTranslationUnitsModel stringifySecondCount:testedValue3 usingLongFormat:YES];
    NSString *value4 = [AISTranslationUnitsModel stringifySecondCount:testedValue4 usingLongFormat:YES];
    
    XCTAssertEqualObjects(expectedValue1, value1);
    XCTAssertEqualObjects(expectedValue2, value2);
    XCTAssertEqualObjects(expectedValue3, value3);
    XCTAssertEqualObjects(expectedValue4, value4);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
