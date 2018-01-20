//
//  AISSystemSpeaker.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 19.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Speech/Speech.h>

@interface AISSystemSpeaker : NSObject

-(void)speakCharacteristicsTime: (NSString *) time pace:(NSString *) pace distance:(NSString *) distance;

-(void)speakAnyString: (NSString *) anyString;

@end
