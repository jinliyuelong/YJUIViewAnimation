//
//  TransformAndTransformViewController.m
//  YJUIViewAnimation
//
//  Created by Liyanjun on 2018/12/1.
//  Copyright © 2018 LIYANJUN. All rights reserved.
//https://www.jianshu.com/p/a071bba99a1b
//

#import "TransformAndkeViewController.h"

@interface TransformAndkeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *leaf;
@property (weak, nonatomic) IBOutlet UILabel *summer;
@property (weak, nonatomic) IBOutlet UILabel *autumn;

@property (strong, nonatomic) NSTimer * timer;

@end

@implementation TransformAndkeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    
    /// 把下面的define这行代码注释就可以开启UIView的移动动画
#define KEYFRAMEANIMATION
#ifdef KEYFRAMEANIMATION
    _timer = [NSTimer scheduledTimerWithTimeInterval: 0.01 target: self selector: @selector(drawLeafPath) userInfo: nil repeats: YES];
    
//    + (void)animateKeyframesWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewKeyframeAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion
//    + (void)addKeyframeWithRelativeStartTime:(double)frameStartTime relativeDuration:(double)frameDuration animations:(void (^)(void))animations
//    第一个方法是创建一个关键帧动画，第二个方法用于在动画的代码块中插入关键帧动画信息，两个参数的意义表示如下：
//
//    frameStartTime 表示关键帧动画开始的时刻在整个动画中的百分比
//    frameDuration 表示这个关键帧动画占用整个动画时长的百分比。
//
    /// 替换options的参数看不同的效果
//    UIViewKeyframeAnimationOptionCalculationModeLinear      // 连续运算模式，线性
//    UIViewKeyframeAnimationOptionCalculationModeDiscrete    // 离散运算模式，只显示关键帧
//    UIViewKeyframeAnimationOptionCalculationModePaced       // 均匀执行运算模式，线性
//    UIViewKeyframeAnimationOptionCalculationModeCubic       // 平滑运算模式
//    UIViewKeyframeAnimationOptionCalculationModeCubicPaced  // 平滑均匀运算模式
   
    [UIView animateKeyframesWithDuration: 4 delay: 0 options: UIViewKeyframeAnimationOptionCalculationModeCubic animations: ^{
        __block CGPoint center = self->_leaf.center;
        [UIView addKeyframeWithRelativeStartTime: 0 relativeDuration: 0.1 animations: ^{
            self->_leaf.center = (CGPoint){ center.x + 15, center.y + 80 };
        }];
        [UIView addKeyframeWithRelativeStartTime: 0.1 relativeDuration: 0.15 animations: ^{
            self->_leaf.center = (CGPoint){ center.x + 45, center.y + 185 };
        }];
        [UIView addKeyframeWithRelativeStartTime: 0.25 relativeDuration: 0.3 animations: ^{
            self->_leaf.center = (CGPoint){ center.x + 90, center.y + 295 };
        }];
        [UIView addKeyframeWithRelativeStartTime: 0.55 relativeDuration: 0.3 animations: ^{
            self->_leaf.center = (CGPoint){ center.x + 180, center.y + 375 };
        }];
        [UIView addKeyframeWithRelativeStartTime: 0.85 relativeDuration: 0.15 animations: ^{
            self->_leaf.center = (CGPoint){ center.x + 260, center.y + 435 };
        }];
        [UIView addKeyframeWithRelativeStartTime: 0 relativeDuration: 1 animations: ^{
            self->_leaf.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    } completion: ^(BOOL finished) {
        if (self->_timer) {
            [self->_timer invalidate];
            self->_timer = nil;
        }
    }];
    
    
#else
   
    [self moveLeafWithOffset:(CGPoint){ 15, 80 } duration:0.4 completion:^(BOOL finished) {
        [self moveLeafWithOffset:(CGPoint){ 30, 105 } duration:0.6 completion:^(BOOL finished) {
            [self moveLeafWithOffset:(CGPoint){ 40, 110 } duration:1.2 completion:^(BOOL finished) {
                [self moveLeafWithOffset:(CGPoint){ 90, 80 } duration:1.2 completion:^(BOOL finished) {
                    [self moveLeafWithOffset:(CGPoint){ 80, 60 } duration:0.6 completion:nil];
                }];
            }];
        }];
    }];
   
    
    [UIView animateWithDuration: 4 animations: ^{
        _leaf.transform = CGAffineTransformMakeRotation(M_PI);
    }];
#endif
    
    CGFloat offset = _autumn.frame.size.height / 2;
    _autumn.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 0), CGAffineTransformMakeTranslation(0, -offset));
    CGAffineTransform transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 0.05), CGAffineTransformMakeTranslation(0, offset));
    [UIView animateWithDuration: 4 animations: ^{
        self->_autumn.alpha = 1;
        self->_summer.alpha = 0;
        self->_autumn.transform = CGAffineTransformIdentity;
        self->_summer.transform = transform;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)moveLeafWithOffset: (CGPoint)offset duration:(NSTimeInterval)duration completion:(void(^)(BOOL finished))completion{
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGPoint center = self->_leaf.center;
        center.x += offset.x;
        center.y += offset.y;
        self->_leaf.center = center;
        
    } completion:completion];
}


- (void)drawLeafPath
{
    UIView * point = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 2, 2)];
    CALayer * layer = self->_leaf.layer.presentationLayer;
    point.backgroundColor = [UIColor redColor];
    point.center = layer.position;
    [self.view insertSubview: point belowSubview: self->_leaf];
}


@end
