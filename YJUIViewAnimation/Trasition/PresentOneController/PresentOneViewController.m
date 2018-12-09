//
//  PresentOneViewController.m
//  YJUIViewAnimation
//
//  Created by Liyanjun on 2018/12/5.
//  Copyright © 2018 LIYANJUN. All rights reserved.
//

#import "PresentOneViewController.h"
#import "Masonry.h"
#import "YJPresentOneTransition.h"
#import "PresentTwoViewController.h"
@interface PresentOneViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation PresentOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"弹性present";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor greenColor];
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(70);
        make.size.mas_equalTo(CGSizeMake(250, 250));
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或者向上滑动present" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(imageView.mas_bottom).offset(30);
    }];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)present{
    PresentTwoViewController *ctl = [[PresentTwoViewController alloc] init];
    ctl.transitioningDelegate = self;
    [self presentViewController:ctl animated:YES completion:nil];
}

// MARK:  - delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [YJPresentOneTransition transitionWithTransitionType:YJPresentOneTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [YJPresentOneTransition transitionWithTransitionType:YJPresentOneTransitionTypeDismiss];
}
@end
