//
//  AISDataService.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 17.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Run+CoreDataProperties.h"
#import "Location+CoreDataProperties.h"
#import "AppDelegate.h"

@interface AISDataService : NSObject

@property (nonatomic, strong, readonly) Run *run;

-(void)saveDataWith:(NSArray *)locations duration: (int16_t)duration distance:(double)distance date:(NSDate *)date;

-(NSMutableArray *)loadAllRuns;

-(void)deleteRun: (Run*)run;

@end
