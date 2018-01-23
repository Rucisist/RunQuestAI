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

/*! класс для проговоривания текста для голосового информирования бегуна о темпе, скорости и расстоянии */
@interface AISSystemSpeaker : NSObject

/*! @brief проговаривание строки состоящей из времени, темпа, дистанции
 @params time - время в формате 00:00
 @params pace - темп в формате 0.00 min/km
 @params distance - дистанция в формате 0.00 km*/
-(void)speakCharacteristicsTime: (NSString *)time pace:(NSString *)pace distance:(NSString *)distance;

/*! проговаривание любой строки */
-(void)speakAnyString:(NSString *)anyString;

@end
