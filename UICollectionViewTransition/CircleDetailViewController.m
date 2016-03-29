//
//  CicleDetailViewController.m
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/28.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import "CircleDetailViewController.h"
#import "CircleTransition.h"

@interface CircleDetailViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) CircleTransition *popTransition;

@end

@implementation CircleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.popButton addTarget:self action:@selector(popButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.navigationController.delegate = self;
}

- (void)popButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return self.popTransition;
    }
    
    return nil;
}

- (CircleTransition *)popTransition {
    if (_popTransition == nil) {
        _popTransition = [CircleTransition transitionWithType:CircleTransitionTypePop];
    }
    return _popTransition;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
