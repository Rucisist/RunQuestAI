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

@interface AISRunMissionCharacteristicsViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(void)pauseButtonPressed;
-(void)resumeButtonPressed;
-(void)stopButtonPressed;

@end
