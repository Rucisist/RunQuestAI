//
//  AISPlayerAudioTest.m
//  RunQuestAITests
//
//  Created by Андрей Илалов on 23.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AISRealVoicesPlayer.h"

@interface AISPlayerAudioTest : XCTestCase

@property (nonatomic, strong) AISRealVoicesPlayer *realVoicePlayer;

@end

@implementation AISPlayerAudioTest

- (void)setUp {
    [super setUp];
    self.realVoicePlayer = [AISRealVoicesPlayer new];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testExceptionOfPlaySound
{
    XCTAssertNoThrow(self.realVoicePlayer.play);
}

-(void)testInitializing
{
    XCTAssertNotNil(self.realVoicePlayer);
}



@end
