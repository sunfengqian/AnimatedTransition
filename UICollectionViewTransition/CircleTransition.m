//
//  CircleTransition.m
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/28.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import "CircleTransition.h"
#import "CircleViewController.h"
#import "CircleDetailViewController.h"

@interface CircleTransition ()

@property (nonatomic, assign) CircleTransitionType type;

@end

@implementation CircleTransition

- (instancetype)initWithTransitionType:(CircleTransitionType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

+ (instancetype)transitionWithType:(CircleTransitionType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.type) {
        case CircleTransitionTypePush:
        {
            [self pushAnimateTransition:transitionContext];
        }
            break;
        case CircleTransitionTypePop:
        {
            [self popAnimateTransition:transitionContext];
        }
            break;
    }
}

- (void)pushAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CircleDetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    // 起始位置
    CGRect startFrame = [container convertRect:toVC.popButton.frame fromView:toVC.view];
    
}

- (void)popAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {}

@end
