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

@interface AISRunMissionCharacteristicsViewController : UIViewController <CLLocationManagerDelegate, AISConfiguratorProtocolDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) UILabel *paceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *distanceToAimLabel;
@property (nonatomic, strong) UILabel *distanceLabel;

@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) UIButton *stopButton;
@property (nonatomic, strong) UIButton *resumeButton;
@property (nonatomic, strong) UIButton *mapViewOpenButton;

@property (nonatomic, strong) UIVisualEffectView *blurEffectView;

-(void)pauseButtonPressed;
-(void)resumeButtonPressed;
-(void)stopButtonPressed;

@end
