//
//  RunStaticsViewController.h
//  RunQuestAI
//
//  Created by Андрей Илалов on 16.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Run+CoreDataProperties.h"
#import "Location+CoreDataProperties.h"

@interface RunStaticsViewController : UIViewController

@property (nonatomic, strong) NSDate *someDate;
@property (nonatomic, strong) Run *runDetails;

-(instancetype)initWithRunInfo:(NSDate *)date;

@end
