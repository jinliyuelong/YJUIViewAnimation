//
//  SoundWaveViewController.m
//  YJUIViewAnimation
//
//  Created by Liyanjun on 2018/12/2.
//  Copyright © 2018 LIYANJUN. All rights reserved.
//

#import "SoundWaveViewController.h"
#import "Masonry.h"
const NSTimeInterval twinkleInteval = 0.6;
@interface SoundWaveViewController ()<CAAnimationDelegate>
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *layarray;
@end

@implementation SoundWaveViewController

// MARK:  - lifeperiod
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"声波动画";
    [self.view addSubview:self.btn];
//    [self testLayer];
   
    
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_timer invalidate];
    _timer = nil;
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

- (void)dealloc{
    NSLog(@"销毁");
}

// MARK:  - action
- (void)testLayer{
     CAShapeLayer *circle  = [self roundLayerWithFrame:self.btn.frame];
    [self.view.layer addSublayer:circle];
}
- (void)btnClicked:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (!btn.selected) {
        if (_timer) {
            [_timer invalidate];
        }
        [self.layarray enumerateObjectsUsingBlock:^(CAShapeLayer*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperlayer];
        }];
        return;
    }
    if (_timer) {
        [_timer invalidate];
    }
    [self.layarray removeAllObjects];
    _timer = [NSTimer scheduledTimerWithTimeInterval:twinkleInteval repeats:YES block:^(NSTimer * _Nonnull timer) {
        CAShapeLayer *circle  = [self roundLayerWithFrame:self.btn.frame];
        [self.view.layer insertSublayer:circle above:self.btn.layer];
        [self.layarray addObject:circle];
        [self twinkle:circle];
    }];
    [_timer   setFireDate:[NSDate distantPast]];


}

- (CAShapeLayer *)roundLayerWithFrame:(CGRect)rect{
    CAShapeLayer *cricleLayer = [CAShapeLayer layer];
    cricleLayer.path = ([UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:CGRectGetWidth(rect)/2]).CGPath;
    cricleLayer.fillColor =_btn.backgroundColor.CGColor;
//     cricleLayer.fillColor =[UIColor redColor].CGColor;
    //不设置下面两个动画执行transform 会乱跑
    cricleLayer.position = _btn.center;
    cricleLayer.bounds = rect;
    return cricleLayer;
}

- (void)twinkle:(CAShapeLayer *)layer{
    CABasicAnimation *scleanimation =  [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //      CABasicAnimation *scleanimation =  [CABasicAnimation animationWithKeyPath:@"transform"];
    scleanimation.duration =  twinkleInteval *3;
    //     scleanimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(4, 4, 1)] ;
    scleanimation.toValue = @4 ;
    CABasicAnimation *opacityanimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityanimation.fromValue =  @0.75;
    opacityanimation.toValue = @0.3;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = twinkleInteval *3;
    group.animations = @[scleanimation,opacityanimation];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    group.delegate = self;
    [group setValue:layer forKey:@"layerKey"];
    [layer addAnimation:group forKey:@"group"];
    
}

// MARK:  - delegate
// MARK:  CAAnimationDelegate
/* Called when the animation begins its active duration. */

- (void)animationDidStart:(CAAnimation *)anim{
    
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"执行停止动画");
    CAShapeLayer *player = [anim valueForKey:@"layerKey"];
    if (player!=nil) {
        [player removeFromSuperlayer];
        player = nil;
    }
    
}

// MARK:  - setter and getter
- (NSMutableArray *)layarray{
    if (!_layarray) {
        _layarray = [[NSMutableArray alloc] init];
    }
    return _layarray;
}
- (UIButton *)btn{
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _btn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
        _btn.backgroundColor =  [UIColor colorWithRed:(29/255.f) green:(189/255.f) blue:(80/255.f) alpha:1];
        [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _btn.layer.cornerRadius = 40;
        _btn.layer.masksToBounds = YES;
    }
    return _btn;
}
@end
