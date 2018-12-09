//
//  MaskAnimationViewController.m
//  YJUIViewAnimation
//
//  Created by Liyanjun on 2018/12/9.
//  Copyright © 2018 LIYANJUN. All rights reserved.
//

#import "MaskAnimationViewController.h"

@interface MaskAnimationViewController ()

@end

@implementation MaskAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"mask动画";
    //测试mask
//    [self testMask];
    //图片转换动画
    [self pickChange];
}

- (void)pickChange{
    UIImageView *baseGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    baseGround.image        = [UIImage imageNamed:@"1"];
    baseGround.center       = self.view.center;
    [self.view addSubview: baseGround];
    
    UIImageView *upGround = [[UIImageView alloc] initWithFrame:baseGround.frame];
    upGround.image        = [UIImage imageNamed:@"2"];
    [self.view addSubview:upGround];
    
    //添加遮罩
    UIView *mask      = [[UIView alloc] initWithFrame:upGround.bounds];
    upGround.maskView = mask;
    
    //左边
    UIView *leftMask = [[UIView alloc] init];
    leftMask.frame =CGRectMake(0, 0, 100, 400); //高度是整个view的两倍，让透明的在下面
    leftMask.backgroundColor = [UIColor clearColor];
    //利用 CAGradientLayer添加透明度 上面一半透明度1 下面一半从1渐变到0
    CAGradientLayer *layer =  [CAGradientLayer layer];
    layer.colors = @[ (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor,
                             (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor,
                             (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor,
                             (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor,                             ];
    layer.locations =  @[@(0.0), @(0.5), @(0.66),@(0.84)];
    layer.frame = leftMask.bounds;
    [leftMask.layer addSublayer:layer];
//
    UIView *rightMask = [[UIView alloc] init];
    rightMask.frame = CGRectMake(100, -200, 100, 400); //高度是整个view的两倍，让透明的在上面面
    rightMask.backgroundColor = [UIColor clearColor];
//利用 CAGradientLayer添加透明度 上面一半透明度1 下面一半从0渐变到1 ，让透明的在下面
    CAGradientLayer *layer1 =  [CAGradientLayer layer];
    layer1.colors = @[
                     (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor,
                     (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor,
                     (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor,
                      (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor,];
    layer1.locations =  @[@(0),@(0.16), @(0.32), @(0.5)];
    layer1.frame = leftMask.bounds;
    [rightMask.layer addSublayer:layer1];
    
    [mask addSubview:leftMask];
    [mask addSubview:rightMask];

    //animaition
    
    CABasicAnimation *rightanimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    rightanimation.duration = 3;
    rightanimation.beginTime = CACurrentMediaTime() + 2;
    rightanimation.fromValue =  @(rightMask.center.y);
    rightanimation.toValue  =  @(rightMask.center.y + 400);
    rightanimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rightanimation.autoreverses = YES;
    rightanimation.repeatCount = HUGE_VALF;
    rightanimation.repeatCount = HUGE_VALF;
    [rightMask.layer addAnimation:rightanimation forKey:@"position"];
    
    CABasicAnimation *leftanimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    leftanimation.duration = 3;
    leftanimation.beginTime = CACurrentMediaTime() + 2;
    leftanimation.fromValue =  @(leftMask.center.y);
    leftanimation.toValue  =  @(leftMask.center.y - 400);
    leftanimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    leftanimation.autoreverses = YES;
    leftanimation.repeatCount = HUGE_VALF;
    leftanimation.repeatCount = HUGE_VALF;
   [leftMask.layer addAnimation:leftanimation forKey:@"position"];

}

- (void)testMask{
    UIView *bk = [[UIView alloc] initWithFrame:self.view.bounds];
    bk.backgroundColor = [UIColor redColor];
    [self.view addSubview:bk];
    UIView *leftMask = [[UIView alloc] init];
    leftMask.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame));
    leftMask.backgroundColor = [UIColor whiteColor];
    leftMask.alpha = 1;
    
    UIView *rightMask = [[UIView alloc] init];
    rightMask.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2, 0, CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame));
    rightMask.alpha = 0.5;
    rightMask.backgroundColor = [UIColor blackColor];
    
    UIView *maskview = [[UIView alloc] initWithFrame:bk.bounds];
    [maskview addSubview:leftMask];
    [maskview addSubview:rightMask];;
    bk.maskView = maskview;
}

// MARK:  - delegate

// MARK:  - setter and getter

@end
