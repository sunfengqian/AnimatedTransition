//
//  MyCollectionViewController.m
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/24.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionViewCell.h"
#import "MyViewController.h"
#import "MyAnimateTransition.h"

@interface MyCollectionViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) MyAnimateTransition *pushTransition;

@end

@implementation MyCollectionViewController

static NSString * const reuseIdentifier = @"MyCell";

#define screenWidth [UIScreen mainScreen].bounds.size.width

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((screenWidth-10)/2, screenWidth/2+60);
    self.collectionView.collectionViewLayout = layout;
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"myDetail"]) {
        MyViewController *vc = segue.destinationViewController;
        MyCollectionViewCell *cell = (MyCollectionViewCell *)sender;
        vc.image = cell.imageView.image;
        vc.context = cell.contentLabel.text;
        
    }
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.selectedCell = cell;
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return self.pushTransition;
    }
    return nil;
}

- (MyAnimateTransition *)pushTransition {
    if (_pushTransition == nil) {
        _pushTransition = [MyAnimateTransition animateTransitionWithType:MyAnimateTransitionTypePush];
    }
    return _pushTransition;
}


@end
