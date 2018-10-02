//
//  AISRealVoicesPlayer.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 19.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/*! @brief класс для проигрывания звука старта забега */
@interface AISRealVoicesPlayer : NSObject <AVAudioPlayerDelegate>

/*! @brief аудиоплеер */
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

/*! @brief путь к звуку, проигрываемому во время старта */
@property (nonatomic, strong) NSString *soundURL;

-(void)play;

@end
