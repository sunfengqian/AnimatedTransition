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

@property (nonatomic, assign) CGFloat initialLocation;

@end

@implementation PageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTopView];
        [self addBottom];
        [self addGestureRecognizer];
    }
    return self;
}

- (void)addTopView {
    self.topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetMidY(self.bounds))];
    self.topView.layer.anchorPoint = CGPointMake(0.5, 1);
    // 把锚点规定在pageview 的中心
    self.topView.layer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    // 添加透视效果
//    self.topView.layer.transform = [self setTransfomr3D];
    self.topView.image = [self cutImageWithID:@"top"];
    self.topView.userInteractionEnabled = YES;
    self.topView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.topView];
}

- (void)addBottom {

    self.bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMidY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)/2)];
    self.bottomView.layer.anchorPoint = CGPointMake(0.5, 0);
    self.bottomView.layer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.bottomView.image = [self cutImageWithID:@"bottom"];
    self.bottomView.userInteractionEnabled = YES;
    self.bottomView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.bottomView];
}

-(void)addGestureRecognizer{
    UIPanGestureRecognizer *panGesture   = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan1:)];
    UITapGestureRecognizer *pokeGesture  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(poke1:)];
    [self.topView addGestureRecognizer:panGesture];
    [self.topView addGestureRecognizer:pokeGesture];
    
    UIPanGestureRecognizer *panGesture2  =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan2:)];
    UITapGestureRecognizer *pokeGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(poke2:)];
    
    [self.bottomView addGestureRecognizer:panGesture2];
    [self.bottomView addGestureRecognizer:pokeGesture2];
    
}

//-(void)pan1:(UIPanGestureRecognizer *)recognizer{
//    CGPoint location = [recognizer locationInView:self];
//    //获取手指在PageView中的初始坐标
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        self.initialLocation = location.y;
//        [self bringSubviewToFront:self.topView];
//    }
//    
//    //如果手指在PageView里面,开始使用POPAnimation
//    if([self isLocation:location InView:self]){
//        //把一个PI平均分成可以下滑的最大距离份
//        CGFloat percent = -M_PI / (CGRectGetHeight(self.bounds) - self.initialLocation);
//        
//        //POPAnimation的使用
//        //创建一个Animation,设置为绕着X轴旋转。还记得我们上面设置的锚点吗？设置为（0.5，0.5）。这时什么意思呢？当我们设置kPOPLayerRotationX（绕X轴旋转），那么x就起作用了，绕x所在轴；kPOPLayerRotationY，y就起作用了，绕y所在轴。
//        POPBasicAnimation *rotationAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationX];
//        
//        //给这个animation设值。这个值根据手的滑动而变化，所以值会不断改变。又因为这个方法会实时调用，所以变化的值会实时显示在屏幕上。
//        rotationAnimation.duration = 0.01;//默认的duration是0.4
//        rotationAnimation.toValue =@((location.y-self.initialLocation)*percent);
//        
//        //把这个animation加到topView的layer,key只是个识别符。
//        [self.topView.layer pop_addAnimation:rotationAnimation forKey:@"rotationAnimation"];
//        
//        //当松手的时候，自动复原
//        if (recognizer.state == UIGestureRecognizerStateEnded ||
//            recognizer.state == UIGestureRecognizerStateCancelled) {
//            POPSpringAnimation *recoverAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotationX];
//            recoverAnimation.springBounciness = 18.0f; //弹簧反弹力度
//            recoverAnimation.dynamicsMass = 2.0f;
//            recoverAnimation.dynamicsTension = 200;
//            recoverAnimation.toValue = @(0);
//            [self.topView.layer pop_addAnimation:recoverAnimation forKey:@"recoverAnimation"];
//        }
//        
//    }
//    
//    //手指超出边界也自动复原
//    if (location.y < 0 || (location.y - self.initialLocation)>(CGRectGetHeight(self.bounds))-(self.initialLocation)) {
//        recognizer.enabled = NO;
//        POPSpringAnimation *recoverAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotationX];
//        recoverAnimation.springBounciness = 18.0f; //弹簧反弹力度
//        recoverAnimation.dynamicsMass = 2.0f;
//        recoverAnimation.dynamicsTension = 200;
//        recoverAnimation.toValue = @(0);
//        [self.topView.layer pop_addAnimation:recoverAnimation forKey:@"recoverAnimation"];
//        
//    }
//    
//    recognizer.enabled = YES;
//}

//- (CATransform3D)setTransfomr3D {
//    return 0;
//}


-(UIImage *)cutImageWithID:(NSString *)ID{
    
    UIImage *image = [UIImage imageNamed:@"pp_dog"];
    
    CGRect rect = CGRectMake(0.f, 0.f, image.size.width, image.size.height / 2.f);
    if ([ID isEqualToString:@"bottom"]){
        rect.origin.y = image.size.height / 2.f;
    }
    
    CGImageRef imgRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *cuttedImage = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    
    return cuttedImage;
}
@end
