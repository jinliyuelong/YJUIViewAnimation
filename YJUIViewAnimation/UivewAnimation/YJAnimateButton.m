//
//  YJAnimateButton.m
//  YJUIViewAnimation
//
//  Created by Liyanjun on 2018/12/1.
//  Copyright © 2018 LIYANJUN. All rights reserved.
//

#import "YJAnimateButton.h"

@interface YJAnimateButton()
@property (nonatomic, strong) CAShapeLayer * circle;
@property (nonatomic, weak) NSTimer *timer;
@end
@implementation YJAnimateButton


#pragma mark - 布局
- (CAShapeLayer *)circle
{
    if (!_circle) {
        _circle = [CAShapeLayer layer];
        _circle.fillColor = [UIColor clearColor].CGColor;
        _circle.strokeColor = [UIColor whiteColor].CGColor;
        _circle.lineWidth = 1;
        _circle.opacity = 0;
        _circle.strokeEnd = _circle.strokeStart = 0;
        [self.layer addSublayer: _circle];
    }
    return _circle;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.circle.path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(self.frame.size.width / 2 - _radius / 2, self.frame.size.height / 2 - _radius / 2, _radius, _radius)].CGPath;
}

// MARK:  - 动画
const NSTimeInterval duration = 1.2;
- (void)start{
    if (_timer) {
        [_timer invalidate];
    }
    [self addAnimate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(addAnimate) userInfo:nil repeats:YES];
    [UIView animateWithDuration: 0.15 animations: ^{
        self->_circle.opacity = 1;
        [self setTitleColor: [UIColor colorWithWhite: 1 alpha: 0] forState: UIControlStateNormal];
    }];
}

- (void)stop
{
    if (_timer) {
        [_timer invalidate];
    }
    
    [self.circle removeAllAnimations];
    [UIView animateWithDuration: 0.15 animations: ^{
        self->_circle.opacity = 0;
        [self setTitleColor: [UIColor colorWithWhite: 1 alpha: 1] forState: UIControlStateNormal];
    }];
}

- (void)addAnimate{
    CABasicAnimation * endAnimation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    endAnimation.fromValue = @0;
    endAnimation.toValue = @1;
    endAnimation.duration = duration;
    endAnimation.removedOnCompletion = YES;
    [self.circle addAnimation: endAnimation forKey: @"end"];
    
    CABasicAnimation * startAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    startAnimation.beginTime = CACurrentMediaTime() + duration / 2;
    startAnimation.fromValue = @0;
    startAnimation.toValue = @1;
    startAnimation.removedOnCompletion = YES;
    startAnimation.duration = duration / 2;
    [self.circle addAnimation: startAnimation forKey: @"start"];
    
}
@end
