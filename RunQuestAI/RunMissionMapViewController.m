//
//  RunMissionMapViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "RunMissionMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>

@interface RunMissionMapViewController ()

@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, strong) GMSMutablePath *path;
@property (nonatomic, strong) GMSPolyline *runTrack;

@end

@implementation RunMissionMapViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configureUI];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    
    [self.locationManager startUpdatingLocation];
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self load];
    self.path = [GMSMutablePath path];
    self.runTrack = [GMSPolyline new];
}


- (void)load
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude zoom:4];
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.view = self.mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = self.locationManager.location.coordinate;
    marker.title = @"Moscow";
    marker.snippet = @"Russia";
    marker.map = self.mapView;
    self.mapView.mapType = kGMSTypeNormal;
    //    GMSMutablePath *path = [GMSMutablePath path];
    //    CLLocation *location;
    //    for (location in self.locationArray) {
    //        [path addCoordinate:location.coordinate];
    //    }
    //    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    //    polyline.strokeColor = [UIColor redColor];
    //    polyline.map = mapView;
    [self.mapView clear];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    [self.mapView clear];
    NSLog(@"%f", locations.lastObject.coordinate.longitude);
    
//    if ([locations count] > 1)
//    {
//        NSLog(@"%f", [locations objectAtIndex:([locations indexOfObject:locations.lastObject] - 1)].coordinate.longitude);
//        [somePath addCoordinate:[locations objectAtIndex:([locations indexOfObject:locations.lastObject] - 1)].coordinate];

//    }
    [self.path addCoordinate:locations.lastObject.coordinate];
    
    self.runTrack.path = self.path;
    self.runTrack.map = self.mapView;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
