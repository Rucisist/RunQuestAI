//
//  Run+CoreDataProperties.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 19.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//
//

#import "Run+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Run (CoreDataProperties)

+ (NSFetchRequest<Run *> *)fetchRequest;

@property (nonatomic) double distance;
@property (nonatomic) int16_t duration;
@property (nullable, nonatomic, copy) NSDate *timestamp;
@property (nullable, nonatomic, retain) NSOrderedSet<Location *> *locations;

@end

@interface Run (CoreDataGeneratedAccessors)

- (void)insertObject:(Location *)value inLocationsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLocationsAtIndex:(NSUInteger)idx;
- (void)insertLocations:(NSArray<Location *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLocationsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLocationsAtIndex:(NSUInteger)idx withObject:(Location *)value;
- (void)replaceLocationsAtIndexes:(NSIndexSet *)indexes withLocations:(NSArray<Location *> *)values;
- (void)addLocationsObject:(Location *)value;
- (void)removeLocationsObject:(Location *)value;
- (void)addLocations:(NSOrderedSet<Location *> *)values;
- (void)removeLocations:(NSOrderedSet<Location *> *)values;

@end

NS_ASSUME_NONNULL_END
