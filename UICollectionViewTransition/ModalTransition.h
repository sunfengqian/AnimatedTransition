//
//  ModalTransition.h
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/24.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ModalTransitionType) {
    ModalTransitionTypePresent,
    ModalTransitionTypeDismiss
};

@interface ModalTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)modalTransitionWithType:(ModalTransitionType)type;

@end
