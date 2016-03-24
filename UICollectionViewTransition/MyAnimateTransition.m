//
//  MyAnimateTransition.m
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/24.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import "MyAnimateTransition.h"
#import "MyCollectionViewController.h"
#import "MyCollectionViewCell.h"
#import "MyViewController.h"
#import <UIKit/UIKit.h>

@interface MyAnimateTransition ()

@property (nonatomic, assign) MyAnimateTransitionType type;

@end

@implementation MyAnimateTransition

- (instancetype)initWithAnimateType:(MyAnimateTransitionType)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

+ (instancetype)animateTransitionWithType:(MyAnimateTransitionType)type {
    return [[self alloc] initWithAnimateType:type];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    switch (self.type) {
        case MyAnimateTransitionTypePush:
        {
            [self pushAnimatedTransition:transitionContext];
        }
            break;
        case MyAnimateTransitionTypePop:
        {
            [self popAnimatedTransition:transitionContext];
        }
            break;
 
    }
    
    
}

// push 动画
- (void)pushAnimatedTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    MyCollectionViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    MyViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = toVC.view;
    
    UIView *container = [transitionContext containerView];
    
    UIView *snapshot = [fromVC.selectedCell.imageView snapshotViewAfterScreenUpdates:NO];
    
    snapshot.frame = [container convertRect:fromVC.selectedCell.imageView.frame fromView:fromVC.selectedCell];
    
    CGRect finalFrame = toVC.imageView.frame;
    
    fromVC.selectedCell.imageView.hidden = YES;
    
    toView.alpha = 0;
    toVC.imageView.hidden = YES;
    
    [container addSubview:toView];
    [container addSubview:snapshot];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1;
        snapshot.frame = finalFrame;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromVC.selectedCell.imageView.hidden = NO;
        toVC.imageView.hidden = NO;
        [snapshot removeFromSuperview];
    }];
}

// pop动画
- (void)popAnimatedTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    MyViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    MyCollectionViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *container = [transitionContext containerView];
    
    // 图片截图
    UIView *imageSnapshot = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    imageSnapshot.frame = [container convertRect:fromVC.imageView.frame fromView:fromVC.view];
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    fromVC.imageView.hidden = YES;
    toVC.selectedCell.imageView.hidden = YES;
    
    [container insertSubview:toVC.view belowSubview:fromVC.view];
    [container addSubview:imageSnapshot];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0;
        imageSnapshot.frame = [container convertRect:toVC.selectedCell.imageView.frame fromView:toVC.selectedCell];
        
    } completion:^(BOOL finished) {
        
        BOOL cancel = [transitionContext transitionWasCancelled];
        
        if (cancel) {
            fromVC.imageView.hidden = NO;
        }
        
        toVC.selectedCell.imageView.hidden = NO;
        [imageSnapshot removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
       
    }];
    
    
}

- (void)animationEnded:(BOOL)transitionCompleted {
    if (transitionCompleted) {
        NSLog(@"动画执行完毕");
    } else {
        NSLog(@"动画被取消");
    }
}

@end
