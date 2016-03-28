//
//  OtherTransition.m
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/28.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import "OtherTransition.h"

@interface OtherTransition ()

@property (nonatomic, assign) OtherTransitionType type;

@end

@implementation OtherTransition

- (instancetype)initWithTransitionType:(OtherTransitionType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

+ (instancetype)transitionWithType:(OtherTransitionType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.type) {
        case OtherTransitionTypePush:
        {
            [self pushForAnimateTransition:transitionContext];
        }
            break;
        case OtherTransitionTypePop:
        {
            [self popAnimateTransition:transitionContext];
        }
            break;
    }
}

- (void)pushForAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    finalFrame.origin.x = CGRectGetMaxX(finalFrame);
    [container addSubview:toVC.view];
    toVC.view.frame = finalFrame;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        CGRect frame = finalFrame;
        frame.origin.x = 0;
        toVC.view.frame = frame;
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
    
}

- (void)popAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    [container insertSubview:toVC.view belowSubview:fromVC.view];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = finalFrame;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        CGRect frame = finalFrame;
        frame.origin.x = CGRectGetMaxX(finalFrame);
        fromVC.view.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

@end
