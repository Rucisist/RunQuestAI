//
//  Location+CoreDataProperties.h
//  
//
//  Created by Андрей Илалов on 15.01.2018.
//
//

#import "Location+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Location (CoreDataProperties)

+ (NSFetchRequest<Location *> *)fetchRequest;

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nullable, nonatomic, copy) NSDate *timestamp;
@property (nullable, nonatomic, retain) Run *run;

@end

NS_ASSUME_NONNULL_END
