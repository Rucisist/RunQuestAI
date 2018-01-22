//
//  Run+CoreDataProperties.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 21.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
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
@dynamic locations;

@end
