//
//  ShoppingAnimationViewController.m
//  YJUIViewAnimation
//
//  Created by Liyanjun on 2018/12/4.
//  Copyright © 2018 LIYANJUN. All rights reserved.
//

#import "ShoppingAnimationViewController.h"

@interface ShoppingAnimationViewController ()<CAAnimationDelegate>
@property (nonatomic, strong) UIButton *buyBtn;
@property (nonatomic, strong) UIImageView *shoppingCar;
@property (nonatomic, strong) UIImageView *juziImage;
@end

@implementation ShoppingAnimationViewController
// MARK:  - lifecircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.juziImage];
    [self.view addSubview:self.buyBtn];
    [self.view addSubview:self.shoppingCar];
    self.juziImage.frame = CGRectMake(0, 0, 50, 50);
    self.juziImage.center = self.shoppingCar.center;
    self.juziImage.alpha = 0;
    // Do any additional setup after loading the view.
}

- (void)dealloc{
    NSLog(@"%@销毁了",NSStringFromClass([self class]));
}

// MARK:  -action
- (void)buyClick:(UIButton *)btn{
        self.juziImage.alpha = 1;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:self.buyBtn.center];
        [path addQuadCurveToPoint:self.shoppingCar.center controlPoint:CGPointZero];
    
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.delegate = self;
        //动画时间
        animation.duration = 1;
        animation.path = path.CGPath;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.juziImage.layer addAnimation:animation forKey:nil];
}


// MARK:  - delegate
- (void)animationDidStart:(CAAnimation *)anim{
    
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"执行停止动画");
    if (flag == YES) {
        self.juziImage.alpha = 0;
    }
    
}
// MARK:  - getter and setter
- (UIButton *)buyBtn{
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_buyBtn setTitle:@"购买" forState:UIControlStateNormal];
        [_buyBtn addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
        _buyBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame)-150, 50, 100, 100);
    }
    return _buyBtn;
}
- (UIImageView *)juziImage{
    if (!_juziImage) {
        _juziImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"juzi"]];
    }
    return _juziImage;
}
- (UIImageView *)shoppingCar{
    if (!_shoppingCar) {
        _shoppingCar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gouwuche"]];
        _shoppingCar.frame = CGRectMake(10, CGRectGetHeight(self.view.frame)-150, 50, 50);
    }
    return _shoppingCar;
}


@end
