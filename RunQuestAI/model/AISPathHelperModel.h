//
//  AISPathHelperModel.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 22.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "Run+CoreDataProperties.h"
#import "Location+CoreDataProperties.h"

@interface AISPathHelperModel : NSObject

-(NSMutableArray *)calculatePaceArrayWith:(Run *)runDetails;

@end
