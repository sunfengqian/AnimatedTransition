//
//  OtherTransition.h
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/28.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

typedef NS_ENUM(NSInteger, OtherTransitionType) {
    OtherTransitionTypePush,
    OtherTransitionTypePop
};

@interface OtherTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithType:(OtherTransitionType)type;

@end
