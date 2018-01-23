//
//  RunMissionCharacteristicsViewController.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AISConfiguratorProtocolDelegate.h"

/*! контроллер с основными характеристиками забега */
@interface AISRunMissionCharacteristicsViewController : UIViewController <CLLocationManagerDelegate, AISConfiguratorProtocolDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

/*! лейбл отображающий темп */
@property (nonatomic, strong) UILabel *paceLabel;

/*! лейбл отображающий время */
@property (nonatomic, strong) UILabel *timeLabel;

/*! лейбл отображающий пробег */
@property (nonatomic, strong) UILabel *distanceToAimLabel;

/*! лейбл отображающий дистанцию до цели в центре Москвы */
@property (nonatomic, strong) UILabel *distanceLabel;

/*! пауза - кнопка */
@property (nonatomic, strong) UIButton *pauseButton;

/*! кнопка остановки забега */
@property (nonatomic, strong) UIButton *stopButton;

/*! кнопка возобновления забега */
@property (nonatomic, strong) UIButton *resumeButton;

/*! кнопка открытия карты с достопримечательностями */
@property (nonatomic, strong) UIButton *mapViewOpenButton;

/*! эффект blur */
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;


@end
