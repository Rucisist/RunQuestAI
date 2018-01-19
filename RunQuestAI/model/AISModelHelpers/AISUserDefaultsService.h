//
//  AISUserDefaultsService.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 17.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AISUserDefaultsService : NSObject

@property (nonatomic, strong) NSUserDefaults *userDefaults;

-(void)setUserDefaultsForTheKey: (NSString *) key objectForTheKey: (id) object;

-(void)deleteUserDefaultsForTheKey: (NSString *) key;

-(id)objectForTheKey: (NSString *)key;


@end
