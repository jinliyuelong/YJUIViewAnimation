//
//  ElasticAnimationViewController.m
//  YJUIViewAnimation
//
//  Created by Liyanjun on 2018/12/2.
//  Copyright © 2018 LIYANJUN. All rights reserved.
//

#import "ElasticAnimationViewController.h"

@interface ElasticAnimationViewController ()
//两个辅助view 来绘制layer的的path
@property (nonatomic, strong) UIView *referView;
@property (nonatomic, strong) UIView *springView;
@property (nonatomic, strong) UIButton *animationBtn;
@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@end

@implementation ElasticAnimationViewController

// MARK:  - lifecircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.animationBtn];
    [self.view addSubview:self.referView];
    [self.view addSubview:self.springView];
    [self.view.layer addSublayer:self.layer];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.displayLink invalidate];
}

- (void)dealloc{
    NSLog(@"%@销毁",NSStringFromClass([self class]));
}

// MARK:  - action
- (void)animate:(UIButton *)sender{
    CGPoint target = CGPointMake(0, self.view.center.y/2);
    self.referView.layer.position = target;
    self.springView.layer.position = target;
    self.displayLink?[self.displayLink invalidate]:nil;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animateWave)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    CASpringAnimation *move = [CASpringAnimation animationWithKeyPath:@"position"];
    move.fromValue = [NSValue valueWithCGPoint:CGPointZero];
    move.toValue = [NSValue valueWithCGPoint:target];
    move.duration = 2;
    
    CASpringAnimation *spring = [CASpringAnimation animationWithKeyPath:@"position"];
    spring.fromValue = [NSValue valueWithCGPoint:CGPointZero];
    spring.toValue = [NSValue valueWithCGPoint:target];
    spring.duration = 2;
    spring.damping = 7;
    
    [self.referView.layer addAnimation:move forKey:nil];
    [self.springView.layer addAnimation:spring forKey:nil];
    self.referView.layer.position = target;
    self.springView.layer.position = target;
}

- (void)animateWave{
    UIBezierPath *path = ([UIBezierPath bezierPath]);
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(self.view.frame.size.width, 0)];
    CGFloat controlY = self.springView.layer.presentationLayer.position.y;
    CGFloat referY = self.referView.layer.presentationLayer.position.y;
    [path addLineToPoint:CGPointMake(self.view.frame.size.width, referY)];
    [path addQuadCurveToPoint:CGPointMake(0, referY) controlPoint:CGPointMake(self.view.frame.size.width/2, controlY)];
    [path addLineToPoint:CGPointZero];
    self.layer.path = path.CGPath;
}
// MARK:  - delegate

// MARK:  - getter and setter
- (UIButton *)animationBtn{
    if (!_animationBtn) {
        _animationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_animationBtn setTitle:@"动画" forState:UIControlStateNormal];
        [_animationBtn addTarget:self action:@selector(animate:) forControlEvents:UIControlEventTouchUpInside];
        _animationBtn.frame = CGRectMake(0, 0, 100, 50);
        _animationBtn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)+100);
    }
    return _animationBtn;
}
- (UIView *)referView{
    if (!_referView) {
        _referView = [[UIView alloc] initWithFrame:CGRectMake(0, -1, 2, 2)];
        _referView.backgroundColor = [UIColor redColor];
    }
    return _referView;
}
- (UIView *)springView{
    if (!_springView) {
        _springView = [[UIView alloc] initWithFrame:CGRectMake(0, -1, 20, 20)];
        _springView.backgroundColor = [UIColor yellowColor];
    }
    return _springView;
}
- (CAShapeLayer *)layer{
    if (!_layer) {
        _layer = [CAShapeLayer layer];
        _layer.fillColor = [UIColor colorWithRed:(105/255.f) green:(175/255.f) blue:(199/255.f) alpha:1].CGColor;
        _layer.strokeColor = [UIColor blueColor].CGColor;
    }
    return _layer;
}
@end
