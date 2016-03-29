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

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, assign) CircleTransitionType type;

@property (nonatomic, strong) UIView *snapshot;

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
    return 0.6;
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
    
    self.transitionContext = transitionContext;
    
    CircleDetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CircleViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *container = [transitionContext containerView];
    [container addSubview:toVC.view];
    
    // bezierpath起始位置
    CGRect startFrame = [container convertRect:fromVC.pushButton.frame toView:container];
    
    // 计算结束bezipath圆的半径
    CGRect toVCFrame = [transitionContext finalFrameForViewController:toVC];
    
    CGFloat width_cut = toVCFrame.size.width - CGRectGetMidX(startFrame);
    CGFloat height_cut = CGRectGetMidY(startFrame);
    
    CGFloat radius = sqrt(width_cut * width_cut + height_cut * height_cut);
    
    // bezierpath 结束位置
    CGRect finalFrame = CGRectMake(CGRectGetMidX(startFrame)-radius, CGRectGetMidY(startFrame)-radius, radius*2, radius*2);
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:startFrame];
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:finalFrame];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = finalPath.CGPath;
    
    toVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.fromValue = (__bridge id)startPath.CGPath;
    basicAnimation.toValue = (__bridge id)finalPath.CGPath;
    basicAnimation.duration = [self transitionDuration:transitionContext];
    basicAnimation.delegate = self;
    
    [maskLayer addAnimation:basicAnimation forKey:@"path"];
    
}

- (void)popAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    self.transitionContext = transitionContext;
    
    CircleViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    UIView *snapshot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    snapshot.frame = [transitionContext finalFrameForViewController:toVC];
    self.snapshot = snapshot;
    
    [container addSubview:toVC.view];
    [container addSubview:snapshot];
    
    // bezierpath起始位置
    CGRect finalFrame = [container convertRect:toVC.pushButton.frame toView:container];
    
    // 计算结束bezipath圆的半径
    CGRect toVCFrame = [transitionContext finalFrameForViewController:toVC];
    
    CGFloat width_cut = toVCFrame.size.width - CGRectGetMidX(finalFrame);
    CGFloat height_cut = CGRectGetMidY(finalFrame);
    
    CGFloat radius = sqrt(width_cut * width_cut + height_cut * height_cut);
    
    // bezierpath 结束位置
    CGRect startFrame = CGRectMake(CGRectGetMidX(finalFrame)-radius, CGRectGetMidY(finalFrame)-radius, radius*2, radius*2);
 
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:startFrame];
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:finalFrame];
    
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = finalPath.CGPath;
    snapshot.layer.mask = mask;
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnimation.fromValue = (__bridge id)startPath.CGPath;
    basicAnimation.toValue = (__bridge id)finalPath.CGPath;
    basicAnimation.duration = [self transitionDuration:transitionContext];
    basicAnimation.delegate = self;
    [mask addAnimation:basicAnimation forKey:@"path"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    [self.snapshot removeFromSuperview];
//    self.snapshot = nil;
}

@end
