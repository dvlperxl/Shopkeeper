//
//  PopTransitionManager.m
//  Shopkeeper
//
//  Created by CaiMing on 2017/11/10.
//  Copyright © 2017年 dongyin. All rights reserved.
//

#import "PopTransitionManager.h"

@implementation PopTransitionManager

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    UIView *container = [transitionContext containerView];
    container.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    
    if (self.model)
    {
        switch (self.operation) {
            case UINavigationControllerOperationPush:
            {
                [container insertSubview:toVC.view belowSubview:fromVC.view];
                CGFloat topHeight = 0;
                toVC.view.frame = CGRectMake(0, topHeight, screenSize.width, screenSize.height - topHeight);
                fromVC.view.transform = CGAffineTransformIdentity;
                toVC.view.transform = CGAffineTransformMakeTranslation(screenSize.width, 0);
                [UIView animateWithDuration:duration
                                      delay:0.0
                     usingSpringWithDamping:1.0
                      initialSpringVelocity:6.0
                                    options:UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     toVC.view.transform = CGAffineTransformIdentity;
                                     fromVC.view.transform = CGAffineTransformMakeTranslation(-screenSize.width, 0);
                                 } completion:^(BOOL finished) {
                                     fromVC.view.transform = CGAffineTransformIdentity;
                                     [fromVC.view removeFromSuperview];
                                     [transitionContext completeTransition:YES];
                                 }];
            }
                break;
            case UINavigationControllerOperationPop:
                
            {
                [container insertSubview:toVC.view belowSubview:fromVC.view];
                CGFloat topHeight = 0;
                toVC.view.frame = CGRectMake(0, topHeight, screenSize.width, screenSize.height - topHeight);
                fromVC.view.transform = CGAffineTransformIdentity;
                toVC.view.transform = CGAffineTransformMakeTranslation(-screenSize.width, 0);;
                [UIView animateWithDuration:duration
                                      delay:0.0
                     usingSpringWithDamping:1.0
                      initialSpringVelocity:6.0
                                    options:UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     toVC.view.transform = CGAffineTransformMakeTranslation(0, 0);
                                     toVC.view.transform = CGAffineTransformIdentity;
                                     fromVC.view.transform = CGAffineTransformMakeTranslation(screenSize.width, 0);
                                 } completion:^(BOOL finished) {
                                     fromVC.view.transform = CGAffineTransformIdentity;
                                     [fromVC.view removeFromSuperview];
                                     [transitionContext completeTransition:YES];
                                 }];
                break;
            }
            default:
                
                break;
        }
    }
    
    
}


@end
