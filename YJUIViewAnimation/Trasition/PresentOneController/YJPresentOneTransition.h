//
//  YJPresentOneTransition.h
//  YJUIViewAnimation
//
//  Created by Liyanjun on 2018/12/5.
//  Copyright © 2018 LIYANJUN. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, YJPresentOneTransitionType) {
    YJPresentOneTransitionTypePresent = 0,
    YJPresentOneTransitionTypeDismiss
};

@interface YJPresentOneTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(YJPresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(YJPresentOneTransitionType)type;

@end

NS_ASSUME_NONNULL_END
