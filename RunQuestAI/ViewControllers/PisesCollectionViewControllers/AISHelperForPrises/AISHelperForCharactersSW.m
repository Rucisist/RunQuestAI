//
//  AISHelperForCharactersSW.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 20.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISHelperForCharactersSW.h"
#import "AISCaharcterSW.h"

@interface AISHelperForCharactersSW()

@property (nonatomic, copy) NSMutableArray<AISCaharcterSW *> *characters;

@end

@implementation AISHelperForCharactersSW

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        _characters = [NSMutableArray new];
    }
    return self;
}

-(AISCaharcterSW *)charactersForDistance:(double)distance
{
    AISCaharcterSW *character = [AISCaharcterSW new];
    
    character.characterDescription = @"Ты падаван джедай";
    character.characterImage = [UIImage imageNamed:@"LukeSkywalkerImage"];
    
    if (distance > 2000) {
        character.characterDescription = @"Ты рыцарь джедай";
        character.characterImage = [UIImage imageNamed:@"obiwankenobiImage"];
    }
    if (distance > 10000) {
        character.characterDescription = @"Ты мастер джедай";
        character.characterImage = [UIImage imageNamed:@"MasterYodaImage"];
    }
    if (distance > 50000) {
        character.characterDescription = @"Ты рыцарь ситх";
        character.characterImage = [UIImage imageNamed:@"DookoImage"];
    }
    if (distance > 100000) {
        character.characterDescription = @"Ты мастер ситх";
        character.characterImage = [UIImage imageNamed:@"DarthVaderImage"];
    }
    return character;
}

@end
