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
#import "AISMathModel.h"

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
    
    NSLog(@"%@", [AISPathHelperModel normolizeArray:self.paceArray]);
    
    NSMutableArray *someAr = [AISMathModel smoothMedianFor:self.paceArray withWindo:20];
    
    self.view = self.graphScrollingView;
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self plotAxis];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(tx0 ,ty0 - [someAr.firstObject integerValue] / 3)];
    
    NSUInteger i = 0;
    
    self.graphScrollingView.contentSize = CGSizeMake(someAr.count + 2*tx0, self.view.frame.size.height);
    
    
    while (i < someAr.count)
    {
        [path addLineToPoint:CGPointMake(tx0+i,ty0 - round([someAr[i] doubleValue] / 3))];
        i = i + 1;
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor greenColor] CGColor];
    shapeLayer.lineWidth = 1.5;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [self.view.layer addSublayer:shapeLayer];
}

-(void)plotAxis
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(tx0, ty0)];
    [path addLineToPoint:CGPointMake(tx0 + self.paceArray.count,ty0)];
    [path moveToPoint:CGPointMake(tx0, ty0)];
    [path addLineToPoint:CGPointMake(tx0, ty0 - 200)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor blackColor] CGColor];
    shapeLayer.lineWidth = 3;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [self.view.layer addSublayer:shapeLayer];
}

@end
