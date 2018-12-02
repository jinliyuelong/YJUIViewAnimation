//
//  ViewController.m
//  YJUIViewAnimation
//
//  Created by Liyanjun on 2018/12/1.
//  Copyright © 2018 LIYANJUN. All rights reserved.
//

#import "ViewController.h"


/**
 UIViewAnimationOptionLayoutSubviews            = 1 <<  0,// 动画过程中保证子视图跟随运动.
 UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, //  动画过程中允许用户交互.
 UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // 所有视图从当前状态开始运行.
 UIViewAnimationOptionRepeat                    = 1 <<  3, //动画循环执行
 UIViewAnimationOptionAutoreverse               = 1 <<  4, //动画在执行完毕后会反方向再执行一次
 UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // 忽略嵌套动画时间设置.
 UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // 忽略嵌套动画速度设置.
 UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // 动画过程中重绘视图（注意仅仅适用于转场动画）.
 UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, //  视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
 UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, //  不继承父动画设置或动画类型.
 
 UIViewAnimationOptionCurveEaseInOut            = 0 << 16, //先加速后减速，默认
 UIViewAnimationOptionCurveEaseIn               = 1 << 16, //由慢到快
 UIViewAnimationOptionCurveEaseOut              = 2 << 16, //由快到慢
 UIViewAnimationOptionCurveLinear               = 3 << 16, //匀速
 
 UIViewAnimationOptionTransitionNone            = 0 << 20, // //没有效果，默认
 UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,//从左翻转效果
 UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,//从右翻转效果
 UIViewAnimationOptionTransitionCurlUp          = 3 << 20,//从上往下翻页
 UIViewAnimationOptionTransitionCurlDown        = 4 << 20,//从下往上翻页
 UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,//旧视图溶解过渡到下一个视图
 UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,//从上翻转效果
 UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,//从上翻转效果
 
 UIViewAnimationOptionPreferredFramesPerSecondDefault     = 0 << 24,//默认的帧每秒.
 UIViewAnimationOptionPreferredFramesPerSecond60          = 3 << 24,// 60帧每秒的帧速率.
 UIViewAnimationOptionPreferredFramesPerSecond30          = 7 << 24,//30帧每秒的帧速率.
 
 
 */
@interface ViewController ()
@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *login;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.userName];
    [self.view addSubview: self.password];
    [self.view addSubview: self.login];
    // Do any additional setup after loading the view, typically from a nib.
    const CGFloat offset = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGPoint accountCenter = self.userName.center;
    CGPoint passwordCenter = self.password.center;
    CGPoint startAccountCenter = CGPointMake(self.userName.center.x - offset, self.userName.center.y);
    CGPoint startPsdCenter = CGPointMake(self.password.center.x - offset, self.password.center.y);
    
    self.userName.center = startAccountCenter;
    self.password.center = startPsdCenter;
    
    [UIView animateWithDuration: 0.5 animations: ^{
        self.userName.center = accountCenter;
    } completion: nil];
    
    [UIView animateWithDuration: 0.5 delay: 0.35 options: UIViewAnimationOptionAutoreverse  animations: ^{
        self.password.center = passwordCenter;
    } completion: ^(BOOL finished) {
//        dampingRatio：速度衰减比例。取值范围0 ~ 1，值越低震动越强
//        velocity：初始化速度，值越高则物品的速度越快
        [UIView animateWithDuration: 0.2 delay: 0 usingSpringWithDamping: 0.5 initialSpringVelocity: 0 options: UIViewAnimationOptionPreferredFramesPerSecond60 animations: ^{
            self.login.alpha = 1;
            CGPoint center = self.login.center;
            center.y -= 100;
            self.login.center = center;
        } completion: nil];
    }];
}

// MARK:  - action
- (void)loginBtnClicked{
    
    //执行在self.userName 上
    [UIView transitionWithView:self.userName duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    
    //第一个会消失 第二个不会
//    [UIView transitionFromView:self.password toView:self.login duration:0.6 options:UIViewAnimationOptionTransitionCrossDissolve completion:nil];
}


// MARK:  - getter and setter
- (UITextField *)userName
{
    if (!_userName) {
        _userName = [self commonTextFieldWithPlaceholder: @"userName" size: CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 100, 25)];
        _userName.center = CGPointMake(self.view.center.x, 200);
    }
    return _userName;
}

- (UITextField *)password
{
    if (!_password) {
        _password = [self commonTextFieldWithPlaceholder: @"password" size: CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 100, 25)];
        _password.center = CGPointMake(self.view.center.x, 250);
    }
    return _password;
}

- (UIButton *)login
{
    if (!_login) {
        _login = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 120, 30)];
        _login.backgroundColor = [UIColor colorWithRed: 233/255. green: 123/255. blue: 123/255. alpha: 1];
        [_login setTitle: @"login" forState: UIControlStateNormal];
        _login.center = CGPointMake(self.view.center.x, 400);
        _login.alpha = 0;
        [_login addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _login;
}

- (UITextField *)commonTextFieldWithPlaceholder: (NSString *)placeholder size: (CGSize)size
{
    UITextField * textField = [[UITextField alloc] initWithFrame: CGRectMake(0, 0, size.width, size.height)];
    
    textField.placeholder = placeholder;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    return textField;
}

@end
