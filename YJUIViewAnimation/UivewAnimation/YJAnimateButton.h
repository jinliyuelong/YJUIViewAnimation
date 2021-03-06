//
//  YJAnimateButton.h
//  YJUIViewAnimation
//
//  Created by Liyanjun on 2018/12/1.
//  Copyright © 2018 LIYANJUN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJAnimateButton : UIButton
@property (nonatomic, assign)  CGFloat radius;


- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
