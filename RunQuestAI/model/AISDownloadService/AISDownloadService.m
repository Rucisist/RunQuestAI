//
//  AISDownloadService.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 22.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISDownloadService.h"

@interface AISDownloadService()

@property (nonatomic) BOOL isOK;

@end

@implementation AISDownloadService

-(instancetype)init
{
    self = [super init];
    if (self) {
        _isOK = YES;
    }
    return self;
}

-(BOOL)loadDataFromGooglePlaces:(CLLocation *)locationCoordinates
{
    
    NSURLComponents *components = [NSURLComponents componentsWithString:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json"];
    
    NSString *locCoordsStr = [NSString stringWithFormat:@"%f,%f", locationCoordinates.coordinate.latitude, locationCoordinates.coordinate.longitude];
    
    NSURLQueryItem *location = [NSURLQueryItem queryItemWithName:@"location" value:locCoordsStr];
    
    NSURLQueryItem *key = [NSURLQueryItem queryItemWithName:@"key" value:@"AIzaSyDjln72xgdfshmYUC9ZJnu_stcEeX7R0pY"];
    
    NSURLQueryItem *type = [NSURLQueryItem queryItemWithName:@"type" value:@"museum"];
    
    NSURLQueryItem *radius = [NSURLQueryItem queryItemWithName:@"radius" value:@"3000"];
    
    components.queryItems = @[location, radius, type, key];
    
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
                    double POILattitude = [helperJSONDictionary[@"geometry"][@"location"][@"lat"] doubleValue];
                    double POILongitude = [helperJSONDictionary[@"geometry"][@"location"][@"lng"] doubleValue];
                    
                    NSString *POIName = [NSString stringWithFormat:@"%@", helperJSONDictionary[@"name"]];
                    NSLog(@"%@", POIName);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        GMSMarker *marker = [[GMSMarker alloc] init];
                        marker.position = CLLocationCoordinate2DMake(POILattitude, POILongitude);
                        marker.title = POIName;
                        marker.map = self.delegate.mapView;
                        
                    });
                }
            }
            else
            {
                NSLog(@"zero");
            }
            self.isOK = YES;
        }
        else
        {
            self.isOK = NO;
        }
    }];
    
    [dataTask resume];
    
    return self.isOK;
}

@end
