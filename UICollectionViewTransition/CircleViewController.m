//
//  AutoreleasePooVC.m
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/28.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import "CircleViewController.h"
#import "CircleTransition.h"

@interface CircleViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentTransition;

@property (nonatomic, strong) CircleTransition *pushTransition;

@property (nonatomic, strong) CircleTransition *popTransition;

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)screenEdgePanGestureAction:(UIScreenEdgePanGestureRecognizer *)pan {
    
    CGFloat progress = [pan translationInView:self.view].x / self.view.bounds.size.width;
    
    switch (pan.state) {
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
        default:
            break;
    }
    
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return self.pushTransition;
    }
    
    if (operation == UINavigationControllerOperationPop) {
        
        if (![toVC isKindOfClass:NSClassFromString(@"RootTableViewController")]) {
            return self.popTransition;
        }
        return nil;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.percentTransition;
}

#pragma mark - 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *toVC = [segue destinationViewController];
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenEdgePanGestureAction:)];
    gesture.edges = UIRectEdgeLeft;
    [toVC.view addGestureRecognizer:gesture];
    
}

#pragma mark - getter & setter

- (CircleTransition *)pushTransition {
    if (_pushTransition == nil) {
        _pushTransition = [CircleTransition transitionWithType:CircleTransitionTypePush];
    }
    return _pushTransition;
}


- (CircleTransition *)popTransition {
    if (_popTransition == nil) {
        _popTransition = [CircleTransition transitionWithType:CircleTransitionTypePop];
    }
    return _popTransition;
}

@end
