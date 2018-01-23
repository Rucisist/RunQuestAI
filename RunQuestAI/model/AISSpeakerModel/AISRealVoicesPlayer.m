//
//  AISRealVoicesPlayer.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 19.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISRealVoicesPlayer.h"

@implementation AISRealVoicesPlayer

-(void)play
{
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"TimeToRun" ofType:@"m4a"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSError *error;
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                         error:&error];
    [self.audioPlayer play];
}



@end
