//
//  Run+CoreDataProperties.m
//  
//
//  Created by Андрей Илалов on 15.01.2018.
//
//

#import "Run+CoreDataProperties.h"

@implementation Run (CoreDataProperties)

+ (NSFetchRequest<Run *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Run"];
}

@dynamic distance;
@dynamic duration;
@dynamic timestamp;
@dynamic loactions;

@end
