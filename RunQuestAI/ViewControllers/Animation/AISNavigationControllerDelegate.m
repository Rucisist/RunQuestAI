//
//  AISNavigationControllerDelegate.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 12.02.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISNavigationControllerDelegate.h"
#import "AISPopAnimationLaunch.h"
#import "AISPushAnimationLaunch.h"

@implementation AISNavigationControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return operation == UINavigationControllerOperationPush ?
    [AISPushAnimationLaunch new] : [AISPopAnimationLaunch new];
}

@end
