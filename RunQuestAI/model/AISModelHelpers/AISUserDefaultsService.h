//
//  AISUserDefaultsService.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 17.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AISUserDefaultsService : NSObject

/*! класс для управления пользовательскими настройками */
@property (nonatomic, strong) NSUserDefaults *userDefaults;

/*! сохранение объекта в NSUserDefaults */
-(void)setUserDefaultsForTheKey: (NSString *) key objectForTheKey: (id) object;

/*! удаление объекта в NSUserDefaults */
-(void)deleteUserDefaultsForTheKey: (NSString *) key;

/*! сохраняемый или удаляемый объект */
-(id)objectForTheKey: (NSString *)key;


@end
