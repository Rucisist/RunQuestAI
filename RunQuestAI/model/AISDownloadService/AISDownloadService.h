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

@interface AISDownloadService : NSObject

@property(nonatomic, strong) id<AISDownloadServiceDelegate> delegate;

-(BOOL)loadDataFromGooglePlaces:(CLLocation *)locationCoordinates;

@end
