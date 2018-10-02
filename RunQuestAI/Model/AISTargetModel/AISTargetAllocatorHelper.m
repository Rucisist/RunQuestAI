//
//  AISTargetAllocatorHelper.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 18.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISTargetAllocatorHelper.h"

static const double AIScenterMoscowLattitude = 55.755733;
static const double AIScenterMoscowLongitude = 37.617923;

static const double AISNorthWestLattitude = 55.772886;
static const double AISNorthWestLongitude = 37.577896;

static const double AISSouthEastLattitude = 55.733665;
static const double AISSouthEastLongitude = 37.660980;


@implementation AISTargetAllocatorHelper

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _moscowCenterLocation = [[CLLocation alloc] initWithLatitude:AIScenterMoscowLattitude longitude:AIScenterMoscowLongitude];
        
        _moscowCenterNorthWestLocation = [[CLLocation alloc] initWithLatitude:AISNorthWestLattitude longitude:AISNorthWestLongitude];
        
        _moscowCenterSouthEastLocation = [[CLLocation alloc] initWithLatitude:AISSouthEastLattitude longitude:AISSouthEastLongitude];
    }
    return self;
}

-(CLLocation *)randomLocationInMoscowCenter
{
    float r = arc4random_uniform(1000)+1;
    float maxRange = self.moscowCenterNorthWestLocation.coordinate.latitude;
    float minRange = self.moscowCenterSouthEastLocation.coordinate.latitude;
    float randomLattitude = (r / 1000 * (maxRange - minRange)) + minRange;
    
    r = arc4random_uniform(1000)+1;
    minRange = self.moscowCenterNorthWestLocation.coordinate.longitude;
    maxRange = self.moscowCenterSouthEastLocation.coordinate.longitude;
    float randomLongitude = (r / 1000 * (maxRange - minRange)) + minRange;
    
    return [[CLLocation alloc] initWithLatitude:randomLattitude longitude:randomLongitude];
}

@end
