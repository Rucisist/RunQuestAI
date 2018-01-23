//
//  StatsViewController.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 16.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Run+CoreDataProperties.h"
#import "Location+CoreDataProperties.h"

/*! @brief класс показывающий таблицу последних забегов */
@interface AISStatsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<Run *> *runArray;

@end
