//
//  Location+CoreDataProperties.m
//  
//
//  Created by Андрей Илалов on 15.01.2018.
//
//

#import "Location+CoreDataProperties.h"

@implementation Location (CoreDataProperties)

+ (NSFetchRequest<Location *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Location"];
}

@dynamic latitude;
@dynamic longitude;
@dynamic timestamp;
@dynamic run;

@end
