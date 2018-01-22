//
//  RunStaticsViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 16.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISRunStaticsViewController.h"
#import <GoogleMaps/GoogleMaps.h>

static CGFloat AISTopMapViewOffset = 10;
static CGFloat AISBottomMapViewOffset = 200;

@interface AISRunStaticsViewController ()

@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, strong) GMSMutablePath *path;
@property (nonatomic, strong) GMSPolyline *runTrack;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *paceArray;
@property (nonatomic, strong) NSNumber *meanNormolizedPace;
@property (nonatomic, strong) NSNumber *minPace;
@property (nonatomic, strong) NSNumber *maxPace;

@end

@implementation AISRunStaticsViewController


-(instancetype)initWithRunInfo:(NSDate *)date
{
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        self.someDate = [NSDate new];
        self.someDate = date;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewDidAppear:(BOOL)animated
{
    Location *loc;
    for (loc in self.runDetails.locations)
    {
        NSLog(@"%f", loc.longitude);
    }
    
    [self load];
    [self.navigationController setNavigationBarHidden:NO];
    
}


-(void)calculatePaceArray
{
    NSUInteger i = 1;
    double delta = 100;
    double dt = 100;
    
    self.paceArray = [NSMutableArray new];
    
    while (i < self.runDetails.locations.count)
    {
        CLLocation *locationTo = [[CLLocation alloc] initWithLatitude:self.runDetails.locations[i].latitude longitude:self.runDetails.locations[i].longitude];
        
        CLLocation *locationFrom = [[CLLocation alloc] initWithLatitude:self.runDetails.locations[i-1].latitude longitude:self.runDetails.locations[i-1].longitude];
        
        dt = [self.runDetails.locations[i].timestamp timeIntervalSinceReferenceDate] - [self.runDetails.locations[i-1].timestamp timeIntervalSinceReferenceDate];
        
        delta = [locationTo distanceFromLocation:locationFrom] / dt;
        
        [self.paceArray addObject:[NSNumber numberWithDouble:delta]];
        i=i+1;
    }
    
    [self normalizingPaceArray];
}

-(void)normalizingPaceArray
{
    self.minPace = [NSNumber new];
    self.maxPace = [NSNumber new];
    
    NSNumber *max = [NSNumber new];
    NSNumber *min = [NSNumber new];
    
    max = [self.paceArray valueForKeyPath: @"@max.self"];
    min = [self.paceArray valueForKeyPath: @"@min.self"];
    
    self.minPace = min;
    self.maxPace = max;
    
    float helperNum;
    
    double sum = 0;
    double meanNormPace = 0;
   
    NSUInteger i = 0;
    
    while (i < self.paceArray.count)
    {
        helperNum = [self.paceArray[i] floatValue];
        
        helperNum = ((helperNum - [min floatValue]) / ([max floatValue] - [min floatValue]));
        
        if (helperNum < 0.1)
        {
            helperNum = 0.1;
        }
        
        self.paceArray[i] = [NSNumber numberWithFloat:helperNum];
        
        sum = sum + helperNum;
        
        i = i+1;
    }
    
    meanNormPace = sum / self.paceArray.count;
    
    self.meanNormolizedPace = [NSNumber numberWithDouble:meanNormPace];
}

-(void)load
{
    [self calculatePaceArray];
    
    CGRect AISGMSMapViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: self.runDetails.locations.lastObject.latitude longitude:self.runDetails.locations.lastObject.longitude zoom:16];
    
    self.mapView = [GMSMapView mapWithFrame:AISGMSMapViewFrame camera:camera];
    self.mapView.myLocationEnabled = YES;
    
    [self.view addSubview:self.mapView];
    
    self.mapView.mapType = kGMSTypeNormal;
    
    GMSMutablePath *path = [GMSMutablePath path];
    Location *loc;
    
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
    
    NSUInteger i = 1;
    while (i < self.runDetails.locations.count)
    {
        CLLocationCoordinate2D firstLocation = CLLocationCoordinate2DMake(self.runDetails.locations[i-1].latitude, self.runDetails.locations[i-1].longitude);
        
        CLLocationCoordinate2D secondLocation = CLLocationCoordinate2DMake(self.runDetails.locations[i].latitude, self.runDetails.locations[i].longitude);
        
        GMSMutablePath *path = [GMSMutablePath path];
        [path addCoordinate:firstLocation];
        [path addCoordinate:secondLocation];
        
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        
        float colorCoeficient = [self.paceArray[i-1] floatValue];
        
        float redColorCoefficient = [self.meanNormolizedPace doubleValue];
        
        if (redColorCoefficient <= 0)
        {
            redColorCoefficient = 0.5;
        }
        
        float greenColorCoefficient = 1 - redColorCoefficient;
        
        UIColor *strokeColor;
        
        if (colorCoeficient <= redColorCoefficient)
        {
            strokeColor = [UIColor colorWithRed:sqrt(colorCoeficient / redColorCoefficient) green: redColorCoefficient blue:0.2 alpha:1.0];
        }
        else
        {
            strokeColor = [UIColor colorWithRed: greenColorCoefficient green: sqrt (1-colorCoeficient) / greenColorCoefficient blue:0.2 alpha:1.0];
        }
        
        polyline.strokeColor = strokeColor;
        
        polyline.map = self.mapView;
        i = i+1;
    }
    
    for (loc in self.runDetails.locations)
    {
        [path addCoordinate:CLLocationCoordinate2DMake(loc.latitude, loc.longitude)];
    }
    
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = [UIColor redColor];
    //polyline.map = self.mapView;
}

-(void)printRunInfo
{
    NSLog(@"%@", self.paceArray);
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
