//
//  TranslationUnitsModel.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

/*!@brief Класс AISTranslationUnitsModel для создания форматированных строк расстояния, времени и темпа*/
@interface AISTranslationUnitsModel : NSObject

/*!
 @brief Этот метод переводит метры в километры и выводит строку в формате 0.00 km. С математическим округлением
 
 @param meters Дистанция в метрах.
 @code
 [AISTranslationUnitsModel stringifyDistance:20];
 @endcode
 @return stringifyDistance - строка
 */
+ (NSString *)stringifyDistance:(float)meters;


/*!
 @brief Этот метод превращает секунды в строку со временем, longFormat - 00hr 00min 00sec, shortformat - 00:00:00
 
 @param seconds время в секундах.
 @param longFormat - формат
 @code
 [AISTranslationUnitsModel stringifySecondCount:20 usingLongFormat:NO];
 @endcode
 @return stringifySecondCount - строка
 */
+ (NSString *)stringifySecondCount:(int)seconds usingLongFormat:(BOOL)longFormat;


/*!
 @brief Этот метод возвращает строку в в формате темп min/km
 
 @param  meters Дистанция в метрах.
 @code
 [AISTranslationUnitsModel stringifyAvgPaceFromDist:20 overTime:20];
 @endcode
 @return stringifyAvgPaceFromDist - строка
 */
+ (NSString *)stringifyAvgPaceFromDist:(float)meters overTime:(int)seconds;

+ (NSString *)stringifyPaceFrom:(double)seconds;

@end
