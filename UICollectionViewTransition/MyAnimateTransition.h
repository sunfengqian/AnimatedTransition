//
//  MyAnimateTransition.h
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/24.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MyAnimateTransitionType) {
    MyAnimateTransitionTypePush,
    MyAnimateTransitionTypePop
};

@interface MyAnimateTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)animateTransitionWithType:(MyAnimateTransitionType)type;

@end
