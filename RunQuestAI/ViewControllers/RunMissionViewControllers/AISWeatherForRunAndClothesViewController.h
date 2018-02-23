//
//  AISWeatherForRunAndClothesViewController.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 22.02.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AISDownloadServiceDelegate.h"
#import "AISSpecialWeatherForRun.h"

@interface AISWeatherForRunAndClothesViewController : UIViewController <AISDownloadServiceDelegate>

@property (nonatomic, strong) AISSpecialWeatherForRun *weatherForRun;

@end
