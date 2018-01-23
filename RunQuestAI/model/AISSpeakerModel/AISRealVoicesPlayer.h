//
//  AISRealVoicesPlayer.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 19.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/*! класс для проигрывания звука старта забега */
@interface AISRealVoicesPlayer : NSObject <AVAudioPlayerDelegate>

/*! аудиоплеер */
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

/*! путь к звуку, проигрываемому во время старта */
@property (nonatomic, strong) NSString *soundURL;

-(void)play;

@end
