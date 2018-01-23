//
//  AISHelperForCharactersSW.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 20.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISHelperForCharactersSW.h"
#import "AISCaharcterSW.h"

static const double AISKnightJedyDistance = 2000.0;
static const double AISMasterJedyDistance = 10000.0;
static const double AISKnightSithDistance = 50000.0;
static const double AISMasterSithDistance = 100000.0;

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
    
    if (distance > AISKnightJedyDistance) {
        character.characterDescription = @"Ты рыцарь джедай";
        character.characterImage = [UIImage imageNamed:@"obiwankenobiImage"];
    }
    if (distance > AISMasterJedyDistance) {
        character.characterDescription = @"Ты мастер джедай";
        character.characterImage = [UIImage imageNamed:@"MasterYodaImage"];
    }
    if (distance > AISKnightSithDistance) {
        character.characterDescription = @"Ты рыцарь ситх";
        character.characterImage = [UIImage imageNamed:@"DookoImage"];
    }
    if (distance > AISMasterSithDistance) {
        character.characterDescription = @"Ты мастер ситх";
        character.characterImage = [UIImage imageNamed:@"DarthVaderImage"];
    }
    return character;
}

@end
