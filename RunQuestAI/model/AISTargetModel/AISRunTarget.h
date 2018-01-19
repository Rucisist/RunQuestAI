//
//  AISRunTarget.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 18.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AISRunTarget : NSObject

@property (nonatomic, strong) CLLocation * _Nullable targetLocation;
@property (nonatomic, strong) NSString * _Nullable targetName;
@property (nonatomic, strong) NSString * _Nullable targetDescription;
@property (nonatomic, strong, nullable) UIImage *targetImage;

@end
