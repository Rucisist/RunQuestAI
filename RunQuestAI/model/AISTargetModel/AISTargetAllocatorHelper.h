//
//  AISTargetAllocatorHelper.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 18.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
/*! класс для создания цели забега */
@interface AISTargetAllocatorHelper : NSObject

/*! координаты центра Москвы. Они могут меняться */
@property (nonatomic, strong) CLLocation *moscowCenterLocation;

/*! координаты северозаподной границы центра Москвы */
@property (nonatomic, strong) CLLocation *moscowCenterNorthWestLocation;

/*! координаты юговосточной границы центра Москвы */
@property (nonatomic, strong) CLLocation *moscowCenterSouthEastLocation;

/*! @brief возвращает случайное местоположение в квадрате определенной юговосточной и северозападной границей Москвы
 @return CLLLocation местоколожение*/
-(CLLocation *)randomLocationInMoscowCenter;

@end
