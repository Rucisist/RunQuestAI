//
//  AISDownloadService.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 22.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "AISDownloadServiceDelegate.h"

/*! @brief класс для загрузки информации о достопримечательностях */
@interface AISDownloadService : NSObject

/*! @brief экземпляр делегата */
@property(nonatomic, strong) id<AISDownloadServiceDelegate> delegate;

/*! @brief функция загрузки информации о достопримечательностях рядо с местоположением
 @params locationCoordinates - местоположение */
-(BOOL)loadDataFromGooglePlaces:(CLLocation *)locationCoordinates;

-(BOOL)loadWeatherData:(CLLocation *)locationCoordinates;

@end
