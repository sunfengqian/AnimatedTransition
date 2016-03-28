//
//  OtherDetailViewController.m
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/28.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import "OtherDetailViewController.h"
#import "OtherTransition.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface OtherDetailViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentInteractive;

@property (nonatomic, strong) OtherTransition *popTransiton;

@end

@implementation OtherDetailViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 给detailVC 添加滑动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    panGesture.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panGesture];
    

}

// 处理滑动手势
- (void)panGestureAction:(UIPanGestureRecognizer *)pan {
//    NSLog(@"x = %f", [pan translationInView:self.view].x);
    CGFloat progress = fabs(MAX([pan translationInView:self.view].x , 0)/ self.view.bounds.size.width);
    
    NSLog(@"%f", progress);
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.percentInteractive = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
            [self.percentInteractive updateInteractiveTransition:progress];
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            if (progress > 0.5) {
                [self.percentInteractive finishInteractiveTransition];
            } else {
                [self.percentInteractive cancelInteractiveTransition];
            }
            self.percentInteractive = nil;
        }
            break;
        default:
            break;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.percentInteractive;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return self.popTransiton;
    }
    return nil;
}

- (OtherTransition *)popTransiton {
    if (!_popTransiton) {
        _popTransiton = [OtherTransition transitionWithType:OtherTransitionTypePop];
    }
    return _popTransiton;
}

@end
