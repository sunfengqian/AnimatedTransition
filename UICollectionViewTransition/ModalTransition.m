//
//  ModalTransition.m
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/24.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import "ModalTransition.h"
#import <UIKit/UIKit.h>
#import "ModalViewController.h"
#import "ModalDetailViewController.h"

@interface ModalTransition ()

@property (nonatomic, assign) ModalTransitionType transitionType;

@end

@implementation ModalTransition

- (instancetype)initWithAnimationType:(ModalTransitionType)type {
    self = [super init];
    if (self) {
        self.transitionType = type;
    }
    return self;
}

+ (instancetype)modalTransitionWithType:(ModalTransitionType)type {
    return [[self alloc] initWithAnimationType:type];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.transitionType) {
        case ModalTransitionTypePresent:
        {
            [self presentAnimation:transitionContext];
        }
            break;
        case ModalTransitionTypeDismiss:
        {
            [self dismissAnimation:transitionContext];
        }
            break;

    }
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
 
    ModalViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ModalDetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    [container addSubview:toVC.view];
    [container bringSubviewToFront:fromVC.view];
    
    // 改变m34
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    container.layer.sublayerTransform = transform;
    
    // 设置anchorPoint 和 position
    CGRect initalFrame = [transitionContext initialFrameForViewController:fromVC];
    toVC.view.frame = initalFrame;
    fromVC.view.frame = initalFrame;
    fromVC.view.layer.anchorPoint = CGPointMake(0, 0.5);
    fromVC.view.layer.position = CGPointMake(0, initalFrame.size.height/2);
    
    // 添加阴影
    CAGradientLayer *shadowLayer = [CAGradientLayer layer];
    shadowLayer.colors = @[[UIColor colorWithWhite:0 alpha:1], [UIColor colorWithWhite:0 alpha:0.5], [UIColor colorWithWhite:1 alpha:0.5]];
    shadowLayer.startPoint = CGPointMake(0, 0.5);
    shadowLayer.endPoint = CGPointMake(1, 0.5);
    shadowLayer.frame = initalFrame;
    UIView *shadow = [[UIView alloc] initWithFrame:initalFrame];
    shadow.backgroundColor = [UIColor clearColor];
    [shadow.layer addSublayer:shadowLayer];
    [fromVC.view addSubview:shadow];
    shadow.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromVC.view.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
        shadow.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        fromVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
        fromVC.view.layer.position = CGPointMake(CGRectGetMidX(initalFrame), CGRectGetMidY(initalFrame));
        fromVC.view.layer.transform = CATransform3DIdentity;
        [shadow removeFromSuperview];
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        
    }];
    
}

// dismiss 动画
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    ModalDetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ModalViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    [container addSubview:toVC.view];
    
    // 改变m34
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    container.layer.sublayerTransform = transform;
    
    // 设置anchorPoint 和 position
    CGRect initalFrame = [transitionContext initialFrameForViewController:fromVC];
    toVC.view.frame = initalFrame;
    toVC.view.layer.anchorPoint = CGPointMake(0, 0.5);
    toVC.view.layer.position = CGPointMake(0, initalFrame.size.height/2);
    toVC.view.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    
    // 添加阴影
    CAGradientLayer *shadowLayer = [CAGradientLayer layer];
    shadowLayer.colors = @[[UIColor colorWithWhite:0 alpha:1], [UIColor colorWithWhite:0 alpha:0.5], [UIColor colorWithWhite:1 alpha:0.5]];
    shadowLayer.startPoint = CGPointMake(0, 0.5);
    shadowLayer.endPoint = CGPointMake(1, 0.5);
    shadowLayer.frame = initalFrame;
    UIView *shadow = [[UIView alloc] initWithFrame:initalFrame];
    shadow.backgroundColor = [UIColor clearColor];
    [shadow.layer addSublayer:shadowLayer];
    [toVC.view addSubview:shadow];
    shadow.alpha = 1;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toVC.view.layer.transform = CATransform3DIdentity;
        shadow.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toVC.view.layer.position = CGPointMake(CGRectGetMidX(initalFrame), CGRectGetMidY(initalFrame));
        toVC.view.layer.transform = CATransform3DIdentity;
        [shadow removeFromSuperview];
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        
    }];
    
}

@end
