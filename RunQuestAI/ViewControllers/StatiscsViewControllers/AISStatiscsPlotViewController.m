//
//  AISStatiscsPlotViewController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 11.03.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISStatiscsPlotViewController.h"
#import "Location+CoreDataProperties.h"
#import "Location+CoreDataClass.h"
#import "Run+CoreDataClass.h"
#import "Run+CoreDataProperties.h"
#import "AISPathHelperModel.h"

static const double tx0 = 20;
static const double ty0 = 300;

@interface AISStatiscsPlotViewController ()

@property (nonatomic, strong) UIScrollView *graphScrollingView;
@property (nonatomic, strong) NSMutableArray *paceArray;

@end

@implementation AISStatiscsPlotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.graphScrollingView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.graphScrollingView.contentSize = CGSizeMake(3000, self.view.frame.size.height);
    
    self.paceArray = [AISPathHelperModel calculatePaceArrayForPlot:self.runDetails];
    
    self.view = self.graphScrollingView;
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(tx0, ty0)];
    
    NSUInteger i = 0;
    
    while (i < self.paceArray.count)
    {
        [path addLineToPoint:CGPointMake(tx0+i*3,ty0 - [self.paceArray[i] integerValue] / 3)];
        i = i + 1;
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor greenColor] CGColor];
    shapeLayer.lineWidth = 1.5;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [self.view.layer addSublayer:shapeLayer];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
