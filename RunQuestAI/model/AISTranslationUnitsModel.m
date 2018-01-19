//
//  TranslationUnitsModel.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISTranslationUnitsModel.h"
#import "Location+CoreDataProperties.h"
#import <CoreLocation/CoreLocation.h>

static bool const isMetric = YES;
static float const metersInKM = 1000;
static float const metersInMile = 1609.344;
//static const int idealSmoothReachSize = 33; // about 133 locations/mi


@implementation AISTranslationUnitsModel

+ (NSString *)stringifyDistance:(float)meters {
    
    float unitDivider;
    NSString *unitName;
    
    if (isMetric)
    {
        unitName = @"km";
        unitDivider = metersInKM;
    }
    else
    {
        unitName = @"mi";
        unitDivider = metersInMile;
    }
    
    return [NSString stringWithFormat:@"%.2f %@", (meters / unitDivider), unitName];
}

+ (NSString *)stringifySecondCount:(int)seconds usingLongFormat:(BOOL)longFormat
{
    int remainingSeconds = seconds;
    
    int hours = remainingSeconds / 3600;
    
    remainingSeconds = remainingSeconds - hours * 3600;
    
    int minutes = remainingSeconds / 60;
    
    remainingSeconds = remainingSeconds - minutes * 60;
    
    if (longFormat) {
        if (hours > 0)
        {
            return [NSString stringWithFormat:@"%ihr %imin %isec", hours, minutes, remainingSeconds];
            
        } else
        if (minutes > 0)
        {
            return [NSString stringWithFormat:@"%imin %isec", minutes, remainingSeconds];
        }
        else
        {
            return [NSString stringWithFormat:@"%isec", remainingSeconds];
        }
    }
    else
    {
        if (hours > 0)
        {
            return [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, remainingSeconds];
            
        }
        else if (minutes > 0)
        {
            return [NSString stringWithFormat:@"%02i:%02i", minutes, remainingSeconds];
            
        }
        else
        {
            return [NSString stringWithFormat:@"00:%02i", remainingSeconds];
        }
    }
}

+ (NSString *)stringifyAvgPaceFromDist:(float)meters overTime:(int)seconds
{
    if (seconds == 0 || meters == 0)
    {
        return @"0";
    }
    float avgPaceSecMeters = seconds / meters;
    
    float unitMultiplier;
    
    NSString *unitName;
    if (isMetric)
    {
        
        unitName = @"min/km";

        unitMultiplier = metersInKM;

    }
    else
    {
        
        unitName = @"min/mi";
        unitMultiplier = metersInMile;
    }
    
    int paceMin = (int) ((avgPaceSecMeters * unitMultiplier) / 60);
    int paceSec = (int) (avgPaceSecMeters * unitMultiplier - (paceMin*60));
    
    return [NSString stringWithFormat:@"%i.%02i %@", paceMin, paceSec, unitName];
}




@end
