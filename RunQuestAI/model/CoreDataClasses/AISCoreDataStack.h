//
//  AISCoreDataStack.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 23.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/*! @brief класс для работы со стэком coreData */
@interface AISCoreDataStack : NSObject

@property (strong, readonly) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (id)sharedManager;
- (void)saveContext;

@end
