//
//  AISConfiguratorProtocol.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 23.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AISRunMissionCharacteristicsViewController.h"

@protocol AISConfiguratorProtocol

@property(nonatomic, strong) AISRunMissionCharacteristicsViewController *viewController;

-(void)configureUI;

@end
