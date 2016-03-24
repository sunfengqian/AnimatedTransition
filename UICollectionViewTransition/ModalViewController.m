//
//  ModalViewController.m
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/24.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import "ModalViewController.h"
#import "ModalTransition.h"

@interface ModalViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@property (nonatomic, strong) ModalTransition *presentTransition;

@property (nonatomic, strong) ModalTransition *dismissTransition;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(barButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = item1;
    
    self.transitioningDelegate = self;
    
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGestureAction:)];
    edgePan.edges = UIRectEdgeRight;
    [self.view addGestureRecognizer:edgePan];
    
}

- (void)barButtonItemAction:(id)sender {
    [self performSegueWithIdentifier:@"modal" sender:sender];
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presentTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.percentDrivenTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.percentDrivenTransition;
}

#pragma mark - Private

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *vc = segue.destinationViewController;
    vc.transitioningDelegate = self;
    
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGestureAction:)];
    edgePan.edges = UIRectEdgeLeft;
    [vc.view addGestureRecognizer:edgePan];
    
}

- (void)edgePanGestureAction:(UIScreenEdgePanGestureRecognizer *)gesture {
    if (gesture.edges == UIRectEdgeRight) {
        [self presentAnimateWithGesture:gesture];
    } else if (gesture.edges == UIRectEdgeLeft) {
        [self dismissAnimateWithGesture:gesture];
    }
}

- (void)presentAnimateWithGesture:(UIScreenEdgePanGestureRecognizer *)gesture
{
    CGFloat progress =  fabs([gesture translationInView:[UIApplication sharedApplication].keyWindow].x / [UIApplication sharedApplication].keyWindow.bounds.size.width);
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self performSegueWithIdentifier:@"modal" sender:gesture];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.percentDrivenTransition updateInteractiveTransition:progress];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            if (progress > 0.5) {
                [self.percentDrivenTransition finishInteractiveTransition];
            } else {
                [self.percentDrivenTransition cancelInteractiveTransition];
            }
            self.percentDrivenTransition = nil;
        }
            break;
    }
}

- (void)dismissAnimateWithGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    CGFloat progress =  fabs([gesture translationInView:[UIApplication sharedApplication].keyWindow].x / [UIApplication sharedApplication].keyWindow.bounds.size.width);
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.percentDrivenTransition updateInteractiveTransition:progress];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            if (progress > 0.5) {
                [self.percentDrivenTransition finishInteractiveTransition];
            } else {
                [self.percentDrivenTransition cancelInteractiveTransition];
            }
            self.percentDrivenTransition = nil;
        }
            break;
    }
}

#pragma mark - Getter

- (ModalTransition *)presentTransition {
    if (!_presentTransition) {
        _presentTransition = [ModalTransition modalTransitionWithType:ModalTransitionTypePresent];
    }
    return _presentTransition;
}

- (ModalTransition *)dismissTransition {
    if (!_dismissTransition) {
        _dismissTransition = [ModalTransition modalTransitionWithType:ModalTransitionTypeDismiss];
    }
    return _dismissTransition;
}

@end
