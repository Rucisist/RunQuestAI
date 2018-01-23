//
//  BeginRunViewController.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 14.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AISBeginRunViewController : UIViewController <CLLocationManagerDelegate>

/*! @brief на вью создает экземпляр AISSaberView */
-(void)configureSaberView;

@end
