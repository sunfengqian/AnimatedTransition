//
//  MyViewController.h
//  UICollectionViewTransition
//
//  Created by hahajing on 16/3/24.
//  Copyright © 2016年 hahajing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *context;

@end
