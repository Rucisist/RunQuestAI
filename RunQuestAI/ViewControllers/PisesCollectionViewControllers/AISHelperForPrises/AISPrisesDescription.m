//
//  AISPrisesDescription.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 22.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISPrisesDescription.h"

@implementation AISPrisesDescription

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _album = @[@"alliance",@"GELogo",@"runbuttonImage",@"SWLogo"];
        _albumDescription = @[@"пробежать 1 км", @"пробежать 10 км", @"пробежать 50 км", @"пробежать 100 км"];
        _albumHelper = @[@1, @10, @50, @100];
    }
    return self;
}

@end
