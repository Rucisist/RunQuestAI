//
//  AISTargetAllocatorHelper.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 18.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AISTargetAllocatorHelper : NSObject

@property (nonatomic, strong) CLLocation *moscowCenterLocation;
@property (nonatomic, strong) CLLocation *moscowCenterNorthWestLocation;
@property (nonatomic, strong) CLLocation *moscowCenterSouthEastLocation;

-(CLLocation *)randomLocationInMoscowCenter;

@end
