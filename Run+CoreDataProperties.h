//
//  Run+CoreDataProperties.h
//  
//
//  Created by Андрей Илалов on 15.01.2018.
//
//

#import "Run+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Run (CoreDataProperties)

+ (NSFetchRequest<Run *> *)fetchRequest;

@property (nonatomic) double distance;
@property (nonatomic) int16_t duration;
@property (nullable, nonatomic, copy) NSDate *timestamp;
@property (nullable, nonatomic, retain) Location *loactions;

@end

NS_ASSUME_NONNULL_END
