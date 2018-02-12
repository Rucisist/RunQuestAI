//
//  AISPushAnimationLaunch.m
//  RunQuestAI
//
//  Created by Андрей Илалов on 12.02.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

#import "AISPushAnimationLaunch.h"

@implementation AISPushAnimationLaunch

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *destinationViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [containerView addSubview: destinationViewController.view];
    destinationViewController.view.alpha = 0.0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        destinationViewController.view.alpha = 1.0;
    } completion:^(BOOL finished){
        [transitionContext completeTransition: YES];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 2.0;
}

@end
