//
//  RunMissionMapViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISRunMissionMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AISDownloadService.h"

@interface AISRunMissionMapViewController ()

@property (nonatomic, strong) GMSMutablePath *path;
@property (nonatomic, strong) GMSPolyline *runTrack;
@property (nonatomic, strong) AISDownloadService *downloadService;

@property (nonatomic, strong) NSMutableArray *locationsArray;

@end

@implementation AISRunMissionMapViewController

-(instancetype)initWithRoute: (NSMutableArray *)locations
{
    self = [super init];
    if (self)
    {
        [self loadMap];
        
        _path = [GMSMutablePath new];
        _runTrack = [GMSPolyline new];
        
        CLLocation *location = [CLLocation new];
        CLLocation *lastLocation = [CLLocation new];
        lastLocation = locations.firstObject;
        
        double deltaDistance = 0;
        
        GMSMutablePath *somePath = [GMSMutablePath new];
        GMSPolyline *somePolyline = [GMSPolyline new];
        
        NSMutableArray<GMSPolyline *> *someArray = [NSMutableArray new];
        
        for (location in locations)
        {
            deltaDistance = [lastLocation distanceFromLocation:location];
            if (deltaDistance <= 20.0)
            {
                [somePath addCoordinate:location.coordinate];
                NSLog(@"%f", deltaDistance);
            }
            else
            {
                [somePath removeLastCoordinate];
                GMSPolyline *newPolyline = [GMSPolyline polylineWithPath:somePath];
                [someArray addObject:newPolyline];
                [somePath removeAllCoordinates];
            }
            
            lastLocation = location;
            
        }
        
        GMSPolyline *sP = [GMSPolyline new];
        
        for (sP in someArray)
        {
            sP.map = self.mapView;
        }
        
        somePolyline.path = [somePath mutableCopy];
        somePolyline.map = self.mapView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.downloadService = [AISDownloadService new];
    
    self.downloadService.delegate = self;
    
    [self configureUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}


-(void)configureUI
{
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)closeMapsController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadMap
{
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    
    [self.locationManager startUpdatingLocation];
    [self.locationManager startMonitoringSignificantLocationChanges];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude zoom:15];
    
    self.mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    self.mapView.myLocationEnabled = YES;
    
    [self.view addSubview:self.mapView];
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude];
    
    [self.downloadService loadDataFromGooglePlaces:currentLocation];
}

@end
