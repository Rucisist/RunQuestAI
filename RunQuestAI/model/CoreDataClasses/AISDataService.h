//
//  AISDataService.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 17.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Run+CoreDataProperties.h"
#import "Location+CoreDataProperties.h"
#import "AppDelegate.h"

/*!@brief Класс AISDataService это методы для работы с сохранением и загрузкой данных из coreData*/
@interface AISDataService : NSObject

/*!@brief свойсвто отвечающее за маршрут, который пробежали*/
@property (nonatomic, strong, readonly) Run *run;

/*!
 @brief этот метод сохраняет объект класса Run
 @param locations массив координат.
 @param duration время всего забега.
 @param distance общая дистанция.
 @param date дата и время когда забег закончился.
 @code
 AISDataService *dataService = [AISDataService new];
 [dataService saveDataWith:(NSArray *)locations duration: (int16_t)duration distance:(double)distance date:(NSDate *)date];
 @endcode
 */
-(void)saveDataWith:(NSArray *)locations duration: (int16_t)duration distance:(double)distance date:(NSDate *)date;

/*!
 @brief этот метод сохраняет объект класса Run
 @return NSMutableArray - массив со всеми точками всех забегов
 @code
 AISDataService *dataService = [AISDataService new];
 [dataService loadAllRuns];
 @endcode
 */
-(NSMutableArray *)loadAllRuns;

/*!
 @brief этот метод удаляет объект класса Run
 @param run класса (Run *).
 */
-(void)deleteRun: (Run*)run;

@end
