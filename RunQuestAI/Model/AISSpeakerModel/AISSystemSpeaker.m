//
//  AISSystemSpeaker.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 19.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISSystemSpeaker.h"

@interface AISSystemSpeaker()

@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@property (nonatomic, strong) AVSpeechUtterance *speechutt;

@end


@implementation AISSystemSpeaker

-(instancetype) init
{
    self = [super init];
    
    if (self)
    {
        _synthesizer = [[AVSpeechSynthesizer alloc]init];
        _speechutt = [AVSpeechUtterance new];
    }
    return self;
}

-(void)speakCharacteristicsTime: (NSString *) time pace:(NSString *) pace distance:(NSString *) distance
{
    NSString *stringWithTimePaceAndDistance = [NSString stringWithFormat:@"%@ %@ %@", time, distance, pace];
    
    self.speechutt = [AVSpeechUtterance speechUtteranceWithString: stringWithTimePaceAndDistance];
    [self.speechutt setRate:0.3f];
    self.speechutt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    [self.synthesizer speakUtterance:self.speechutt];
}


-(void)speakAnyString: (NSString *) anyString
{
    self.speechutt = [AVSpeechUtterance speechUtteranceWithString: anyString];
    [self.speechutt setRate:0.3f];
    self.speechutt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    [self.synthesizer speakUtterance:self.speechutt];
}

@end
