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
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(ctx, rect);
//    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor blueColor] CGColor]));
//    CGContextFillPath(ctx);
    
    
    
    CAShapeLayer *shape = [CAShapeLayer layer];


    UIBezierPath *aPath = [UIBezierPath bezierPath];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);

    CGFloat offsetY = 170;
    CGFloat offsetYCenter = 120;

    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(0.0, height)];

    // Draw the lines.
    [aPath addLineToPoint:CGPointMake(0.0, height - offsetY)];
    [aPath addLineToPoint:CGPointMake(width / 2, height - offsetYCenter)];
    [aPath addLineToPoint:CGPointMake(width, height - offsetY)];
    [aPath addLineToPoint:CGPointMake(width, height)];
    [aPath closePath];
    shape.path = aPath.CGPath;
    self.layer.mask = shape;
}

@end
