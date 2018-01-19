//
//  AISRunTarget.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 18.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISRunTarget.h"

@implementation AISRunTarget

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _targetLocation = [CLLocation new];
        _targetName = [NSString new];
        _targetDescription = [NSString new];
        _targetImage = [UIImage new];
    }
    return self;
}

@end
