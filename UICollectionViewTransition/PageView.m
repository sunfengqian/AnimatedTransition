//
//  PageView.m
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/25.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import "PageView.h"

@interface PageView ()

@property (nonatomic, strong) UIImageView *topView;

@property (nonatomic, strong) UIImageView *bottomView;

@end

@implementation PageView

- (void)addTopView {
    self.topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetMidY(self.bounds))];
    self.topView.layer.anchorPoint = CGPointMake(0.5, 1);
    // 把锚点规定在pageview 的中心
    self.topView.layer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    // 添加透视效果
//    self.topView.layer.transform = [self setTransfomr3D];
}

//- (CATransform3D)setTransfomr3D {
//    return 0;
//}

- (void)addBottomView {}

- (void)curtImageWithIdentifer:(NSString *)identifier {}

@end
