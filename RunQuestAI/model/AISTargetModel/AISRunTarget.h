//
//  AISRunTarget.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 18.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
/*! класс - цель забега, содержащий метоположение, описание и изображение места-цели*/
@interface AISRunTarget : NSObject

/*! метоположение цели */
@property (nonatomic, strong) CLLocation * _Nullable targetLocation;

/*! название цели */
@property (nonatomic, strong) NSString * _Nullable targetName;

/*! описание цели */
@property (nonatomic, strong) NSString * _Nullable targetDescription;

/*! изображение цели */
@property (nonatomic, strong, nullable) UIImage *targetImage;

@end
