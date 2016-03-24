//
//  MyViewController.m
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/24.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import "MyViewController.h"
#import "MyAnimateTransition.h"

@interface MyViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) MyAnimateTransition *popTransition;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentTransition;

@end

@implementation MyViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenEdgePanGesture:)];
    gesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gesture];
    
    self.navigationController.delegate = self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.image;
    self.textView.text = self.context;
    self.textView.editable = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)screenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePan {
    CGFloat progress = [edgePan translationInView:self.view].x / (self.view.bounds.size.width/3*2);
    progress = MIN(progress, 1);
    switch (edgePan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.percentTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.percentTransition updateInteractiveTransition:progress];
        }
            break;
       
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            if (progress > 0.5) {
                [self.percentTransition finishInteractiveTransition];
            } else {
                [self.percentTransition cancelInteractiveTransition];
            }
            self.percentTransition = nil;
        }
            break;
    }
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.percentTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return self.popTransition;
    }
    return nil;
}

- (MyAnimateTransition *)popTransition {
    if (!_popTransition) {
        _popTransition = [MyAnimateTransition animateTransitionWithType:MyAnimateTransitionTypePop];
    }
    return _popTransition;
}

@end
