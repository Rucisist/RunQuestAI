//
//  AISDataService.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 17.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISDataService.h"

#import <CoreLocation/CoreLocation.h>

@interface AISDataService()

@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;

-(NSManagedObjectContext *)coreDataContext;

@end

@implementation AISDataService


-(NSMutableArray *)loadAllRuns
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Run" inManagedObjectContext:[self coreDataContext]];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    return [[[self coreDataContext] executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

-(void)deleteRun: (Run*)run
{
    self.managedObjectContext = [self coreDataContext];
    
    NSManagedObjectContext * context = [self managedObjectContext];
    
    [context deleteObject:run];
    
    NSError * error = nil;
    
    if (![context save:&error])
    {
        NSLog(@"Error ! %@", error);
    }
}
    
-(void)saveDataWith:(NSArray *)locations duration: (int16_t)duration distance:(double)distance date:(NSDate *)date
{
    if (distance >= 50)
    {
        self.managedObjectContext = [self coreDataContext];
    
        Run *newRun = [NSEntityDescription insertNewObjectForEntityForName:@"Run" inManagedObjectContext:self.managedObjectContext];
    
        newRun.distance = distance;
        newRun.duration = duration;
        newRun.timestamp = [NSDate date];

        NSMutableArray *locationArray = [NSMutableArray array];
        
        for (CLLocation *someLocation in locations)
        {
            Location *locationObject = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];

            locationObject.timestamp = someLocation.timestamp;
            locationObject.latitude = someLocation.coordinate.latitude;
            locationObject.longitude = someLocation.coordinate.longitude;
            [locationArray addObject:locationObject];
        }
        newRun.locations = [NSOrderedSet orderedSetWithArray:locationArray];
        NSError *error = nil;
    
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(NSManagedObjectContext *)coreDataContext
{
    AISCoreDataStack *dataStack = [AISCoreDataStack sharedManager];
    NSPersistentContainer *container = dataStack.persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    return context;
}

@end
