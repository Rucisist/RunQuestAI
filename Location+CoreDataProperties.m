//
//  Location+CoreDataProperties.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 21.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
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
