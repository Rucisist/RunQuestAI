//
//  RunStaticsViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 16.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISRunStaticsViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AISPathHelperModel.h"



@interface AISRunStaticsViewController ()

@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, strong) GMSMutablePath *path;
@property (nonatomic, strong) GMSPolyline *runTrack;


@end

@implementation AISRunStaticsViewController


-(instancetype)initWithRunInfo:(NSDate *)date
{
    self = [super init];
    if (self)
    {
        _someDate = [NSDate new];
        _someDate = date;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadMap];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)loadMap
{
    CGRect AISGMSMapViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: self.runDetails.locations.lastObject.latitude longitude:self.runDetails.locations.lastObject.longitude zoom:16];
    
    self.mapView = [GMSMapView mapWithFrame:AISGMSMapViewFrame camera:camera];
    self.mapView.myLocationEnabled = YES;
    
    [self.view addSubview:self.mapView];
    
    self.mapView.mapType = kGMSTypeNormal;
    
    GMSMutablePath *path = [GMSMutablePath path];
    
    GMSMarker *startPointMarker = [[GMSMarker alloc] init];
    GMSMarker *endPointMarker = [[GMSMarker alloc] init];
    
    CLLocationCoordinate2D startRunPosition = CLLocationCoordinate2DMake(self.runDetails.locations.firstObject.latitude, self.runDetails.locations.firstObject.longitude);
    
    CLLocationCoordinate2D endRunPosition = CLLocationCoordinate2DMake(self.runDetails.locations.lastObject.latitude, self.runDetails.locations.lastObject.longitude);
    
    startPointMarker.position = startRunPosition;
    startPointMarker.title = @"Start";
    startPointMarker.snippet = @"Point";
    startPointMarker.map = self.mapView;
    
    endPointMarker.position = endRunPosition;
    endPointMarker.title = @"end";
    startPointMarker.snippet = @"Point";
    endPointMarker.map = self.mapView;

    
    AISPathHelperModel *model = [AISPathHelperModel new];
    
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    
    for (polyline in [model calculatePaceArrayWith:self.runDetails])
    {
        polyline.map = self.mapView;
    }
    
}

@end
