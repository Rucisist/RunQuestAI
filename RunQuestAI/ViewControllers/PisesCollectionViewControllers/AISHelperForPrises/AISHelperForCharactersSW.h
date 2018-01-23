//
//  AISHelperForCharactersSW.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 20.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AISCaharcterSW.h"

/*! @brief класс для определения пресонажа из ЗВ за беговые заслуги */
@interface AISHelperForCharactersSW : NSObject

/*! @brief свойство возвращает персонажа в зависимости от пробега
 @params distance - все расстояние, которое было пройдено
 @return AISCaharcterSW персонаж */
-(AISCaharcterSW *)charactersForDistance:(double)distance;

@end
