//
//  AILModelForFirstController.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 15.01.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AILModelForFirstController.h"
#import "BeginRunViewController.h"
#import "ColorUpdatable.h"

@implementation AILModelForFirstController

-(void)backgroundColorChange:(UIView *)view  toColor: (UIColor *)color
{
    view.backgroundColor = color;
    self.viewController = [BeginRunViewController new];
}


@end
