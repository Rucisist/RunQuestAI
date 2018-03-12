//
//  AISCharacteristicViewConfigurator.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 23.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AISRunMissionCharacteristicsViewController.h"
#import "AISConfiguratorProtocolDelegate.h"

@interface AISCharacteristicViewConfigurator : NSObject

@property (nonatomic, weak) id<AISConfiguratorProtocolDelegate> delegate;

-(void)configureUI;

@end
