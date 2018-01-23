//
//  RunStaticsViewController.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 16.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Run+CoreDataClass.h"
#import "Location+CoreDataProperties.h"

/*! класс контроллера, выводящего на карту маршрут(разноцветный) в зависимости от темпа */
@interface AISRunStaticsViewController : UIViewController

@property (nonatomic, strong) NSDate *someDate;
@property (nonatomic, strong) Run *runDetails;

/*! метод для инициализации класса */
-(instancetype)initWithRunInfo:(NSDate *)date;

@end
