//
//  AISDownloadedProtocol.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 22.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>

@protocol AISDownloadServiceDelegate

/*! @brief свойство - карты */
@property (nonatomic, strong) GMSMapView *mapView;

@end
