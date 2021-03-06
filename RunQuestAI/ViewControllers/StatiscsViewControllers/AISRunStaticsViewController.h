//
//  RunStaticsViewController.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 16.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location+CoreDataProperties.h"

/*! @brief класс контроллера, выводящего на карту маршрут(разноцветный) в зависимости от темпа */
@interface AISRunStaticsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDate *someDate;
@property (nonatomic, strong) Run *runDetails;

/*! @brief метод для инициализации класса */
-(instancetype)initWithRunInfo:(NSDate *)date;

@end
