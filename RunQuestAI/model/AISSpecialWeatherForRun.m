//
//  AISSpecialWeatherForRun.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 23.02.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISSpecialWeatherForRun.h"

@implementation AISSpecialWeatherForRun

-(instancetype)initWithTemperature:(NSString *)temp
{
    self = [super init];
    
    if (self)
    {
        double temperature = [temp doubleValue] - 273.15;
        _temperatureString = [NSString stringWithFormat:@"%f,°C", temperature];
    }
    
    return self;
}

-(void)setTemperatureString:(NSString *)temperatureString
{
    double temperature = round([temperatureString doubleValue] - 273.15);
    _temperatureString = [NSString stringWithFormat:@"%.0f,°C", temperature];
}

@end
