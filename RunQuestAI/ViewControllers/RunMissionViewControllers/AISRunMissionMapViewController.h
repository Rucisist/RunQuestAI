//
//  RunMissionMapViewController.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AISDownloadServiceDelegate.h"
#import <GoogleMaps/GoogleMaps.h>

@interface AISRunMissionMapViewController : UIViewController <CLLocationManagerDelegate, AISDownloadServiceDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *lastLocation;

@property (nonatomic, strong) GMSMapView *mapView;

-(instancetype)initWithRoute:(NSMutableArray *)locations;

@end
