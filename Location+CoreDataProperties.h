//
//  Location+CoreDataProperties.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 21.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
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
