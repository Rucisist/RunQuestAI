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

-(instancetype)initWithRoute: (NSMutableArray *)locations
{
    self = [super init];
    if (self)
    {
        [self load];
        
        _path = [GMSMutablePath new];
        _runTrack = [GMSPolyline new];
        
        CLLocation *location = [CLLocation new];
        
        for (location in locations)
        {
            [self.path addCoordinate:location.coordinate];
        }

            self.runTrack.path = self.path;
            self.runTrack.map = self.mapView;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configureUI];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *closeButton = [[UIButton alloc] initWithFrame: CGRectMake(40, 20, 50, 50)];
    closeButton.backgroundColor = [UIColor blackColor];
    [self.view addSubview:closeButton];
    [self.view bringSubviewToFront:closeButton];
    [closeButton addTarget:self action:@selector(closeMapsController) forControlEvents:UIControlEventTouchUpInside];
}

-(void)closeMapsController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadDataFromGooglePlaces:(CLLocation *) locationCoordinates
{
    NSURLComponents *components = [NSURLComponents componentsWithString:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json"];
    NSString *locCoordsStr = [NSString stringWithFormat:@"%f,%f", locationCoordinates.coordinate.latitude, locationCoordinates.coordinate.longitude];
    NSURLQueryItem *location = [NSURLQueryItem queryItemWithName:@"location" value:locCoordsStr];
    NSURLQueryItem *key = [NSURLQueryItem queryItemWithName:@"key" value:@"AIzaSyDjln72xgdfshmYUC9ZJnu_stcEeX7R0pY"];
    NSURLQueryItem *type = [NSURLQueryItem queryItemWithName:@"type" value:@"museum"];
    NSURLQueryItem *radius = [NSURLQueryItem queryItemWithName:@"radius" value:@"2000"];
    components.queryItems = @[ location,radius,type,key ];
    NSURL *url = components.URL;
    NSLog(@"%@", url);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error)
        {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (![json[@"status"]  isEqual: @"ZERO_RESULTS"])
            {
                NSDictionary *helperJSONDictionary;
                for (helperJSONDictionary in json[@"results"])
                {
                    NSLog(@"hhhghghgfhfhf%@", helperJSONDictionary[@"geometry"][@"location"]);
                    double POILattitude = [helperJSONDictionary[@"geometry"][@"location"][@"lat"] doubleValue];
                    double POILongitude = [helperJSONDictionary[@"geometry"][@"location"][@"lng"] doubleValue];
                    
            
                    NSString *POIName = [NSString stringWithFormat:@"%@", helperJSONDictionary[@"name"]];
                    NSLog(@"%@", POIName);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //self.imageView.image = [UIImage imageWithData:data];
                    NSLog(@"something");
                    GMSMarker *marker = [[GMSMarker alloc] init];
                    marker.position = CLLocationCoordinate2DMake(POILattitude, POILongitude);
                    marker.title = POIName;
                    marker.map = self.mapView;
                    });
                }
            }
            else
            {
                NSLog(@"zero");
            }
        }
        
        
    }];
    
    [dataTask resume];
}

-(void)load
{
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    
    [self.locationManager startUpdatingLocation];
    [self.locationManager startMonitoringSignificantLocationChanges];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude zoom:4];
    self.mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    self.mapView.myLocationEnabled = YES;
    [self.view addSubview:self.mapView];
    

    // Creates a marker in the center of the map.
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = self.locationManager.location.coordinate;
//    marker.title = @"Moscow";
//    marker.snippet = @"Russia";
//    marker.map = self.mapView;
//    self.mapView.mapType = kGMSTypeNormal;
    //CLLocation *someLoc = [[CLLocation alloc] initWithLatitude:55.7478257302915 longitude:37.607872330];
    CLLocation *someLoc = [[CLLocation alloc] initWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude];
    
    [self loadDataFromGooglePlaces:someLoc];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
//    [self.mapView clear];
//    [self.path addCoordinate:locations.lastObject.coordinate];
//    self.runTrack.path = self.path;
//    self.runTrack.map = self.mapView;
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
