//
//  AISCaharcterSW.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 20.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISCaharcterSW.h"

@implementation AISCaharcterSW

//-(id)initWithImage: (UIImage *)imageOfCharacter description: (NSString *)description
//{
//    self = [super init];
//    if (self)
//    {
//        _characterImage = imageOfCharacter;
//        _characterDescription = description;
//    }
//    return self;
//}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _characterImage = [UIImage new];
        _characterDescription = [NSString new];
    }
    return self;
}

@end
