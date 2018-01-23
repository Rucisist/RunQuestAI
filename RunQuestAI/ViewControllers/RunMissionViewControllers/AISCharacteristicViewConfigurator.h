//
//  AISCharacteristicViewConfigurator.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 23.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AISRunMissionCharacteristicsViewController.h"
#import "AISConfiguratorProtocol.h"

@interface AISCharacteristicViewConfigurator : NSObject <AISConfiguratorProtocol>

@property (nonatomic, weak) AISRunMissionCharacteristicsViewController *viewController;

-(void)configureUI;

@end
