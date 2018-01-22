//
//  AISCustomRunView.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 19.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISCustomRunView.h"

@implementation AISCustomRunView

- (void)drawRect:(CGRect)rect
{
    CAShapeLayer *shape = [CAShapeLayer layer];

    UIBezierPath *aPath = [UIBezierPath bezierPath];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);

    CGFloat offsetY = 170;
    CGFloat offsetYCenter = 120;

    [aPath moveToPoint:CGPointMake(0.0, height)];

    [aPath addLineToPoint:CGPointMake(0.0, height - offsetY)];
    [aPath addLineToPoint:CGPointMake(width / 2, height - offsetYCenter)];
    [aPath addLineToPoint:CGPointMake(width, height - offsetY)];
    [aPath addLineToPoint:CGPointMake(width, height)];
    [aPath closePath];
    shape.path = aPath.CGPath;
    self.layer.mask = shape;
}

@end
