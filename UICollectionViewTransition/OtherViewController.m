//
//  OtherViewController.m
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/25.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import "OtherViewController.h"
#import "OtherDetailViewController.h"
#import "OtherTransition.h"

@interface OtherViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) OtherTransition *pushTransition;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentTransition;

@end

@implementation OtherViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [self.view addGestureRecognizer:gesture];

}

- (void)panGestureAction:(UIPanGestureRecognizer *)pan {
    CGFloat progress = fabs(MIN([pan translationInView:self.view].x / self.view.bounds.size.width, 0));
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.percentTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self performSegueWithIdentifier:@"otherdetail" sender:nil];
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

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.percentTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return self.pushTransition;
    }
    
    if (operation == UINavigationControllerOperationPop) {
        return nil;
    }
    return nil;
}


- (OtherTransition *)pushTransition {
    if (!_pushTransition) {
        _pushTransition = [OtherTransition transitionWithType:OtherTransitionTypePush];
    }
    return _pushTransition;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    UIViewController *detail = segue.destinationViewController;
//    [self.navigationController pushViewController:detail animated:YES];
}
- (IBAction)buttonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"otherdetail" sender:sender];
}

@end
