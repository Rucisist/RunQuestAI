//
//  AISPathHelperModel.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 22.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISPathHelperModel.h"
#import <CoreLocation/CoreLocation.h>

@interface AISPathHelperModel()

@property (nonatomic, strong) NSNumber *minPace;
@property (nonatomic, strong) NSNumber *maxPace;
@property (nonatomic, strong) NSNumber *meanNormolizedPace;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *paceArray;
@property (nonatomic, strong) NSMutableArray<GMSPolyline *> *polylineColorSegments;

@end

@implementation AISPathHelperModel

-(NSMutableArray *)calculatePaceArrayWith:(Run *)runDetails
{
    NSUInteger i = 1;
    double delta = 100;
    double dt = 100;
    
    self.polylineColorSegments = [NSMutableArray new];
    
    self.paceArray = [NSMutableArray new];
    NSLog(@"%lu", runDetails.locations.count);
    while (i < runDetails.locations.count)
    {
        CLLocation *locationTo = [[CLLocation alloc] initWithLatitude:runDetails.locations[i].latitude longitude:runDetails.locations[i].longitude];
        
        CLLocation *locationFrom = [[CLLocation alloc] initWithLatitude:runDetails.locations[i-1].latitude longitude:runDetails.locations[i-1].longitude];
        
        dt = [runDetails.locations[i].timestamp timeIntervalSinceReferenceDate] - [runDetails.locations[i-1].timestamp timeIntervalSinceReferenceDate];
        
        delta = [locationTo distanceFromLocation:locationFrom] / dt;
        
        NSNumber *someNum = [NSNumber new];
        someNum = [NSNumber numberWithDouble:delta];
        
        [self.paceArray addObject:someNum];
        i=i+1;
        
    }
    
    [self normalizingPaceArray];
    return [self calculateStrokeColor:runDetails];
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
    
    float helperNum = 0;
    
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

-(NSMutableArray *)calculateStrokeColor:(Run *)runDetails
{
    NSUInteger i = 1;
    while (i < runDetails.locations.count)
    {
        CLLocationCoordinate2D firstLocation = CLLocationCoordinate2DMake(runDetails.locations[i-1].latitude, runDetails.locations[i-1].longitude);
        
        CLLocationCoordinate2D secondLocation = CLLocationCoordinate2DMake(runDetails.locations[i].latitude, runDetails.locations[i].longitude);
        
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
        
        [self.polylineColorSegments addObject:polyline];
        
        i = i+1;
    }
    return self.polylineColorSegments;
}

@end
