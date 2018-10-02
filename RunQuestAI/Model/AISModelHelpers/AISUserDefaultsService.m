//
//  AISUserDefaultsService.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 17.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISUserDefaultsService.h"

@interface AISUserDefaultsService()

@end

@implementation AISUserDefaultsService

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

-(void)setUserDefaultsForTheKey: (NSString *) key objectForTheKey: (id) object
{
    [self.userDefaults setObject:object forKey:key];
    NSLog(@"name = %@", [self.userDefaults objectForKey:@"name"]);
}

-(void)deleteUserDefaultsForTheKey: (NSString *)key
{
    [self.userDefaults removeObjectForKey:key];
}

-(id)objectForTheKey: (NSString *)key
{
    return [self.userDefaults objectForKey:key];
}


@end
